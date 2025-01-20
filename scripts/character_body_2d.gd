extends CharacterBody2D



enum PickUpState {ON,OFF}
@export var speed: float = 300
@export var momentum: Dictionary = {
	"initial_velocity": 300,
	"end_velocity": 300,
	"initial_dash_velocity":300,
	"end_dash_velocity": 300
}
@export var dash_modifier: float = 1.1

@export var direction_input: Dictionary = {
	"left": "ui_left",
	"right": "ui_right",
	"dash": "ui_up",
	"action": "ui_accept"
}
@onready var direction_input_storage = direction_input
@onready var action_value:Array = [null,null,null,null,null]
@onready var action_index:int 



@onready var action_second_parameter:Vector2
@onready var action_string:String
@onready var is_interact: bool = false
@onready var is_busy:bool = false
@onready var is_hand_full:bool = false
@onready var equipped_item:String
@onready var animation_ref = $anims/Sprite2D
@onready var camera_manage_ref = %Camera_setter
@onready var dialogue_ref = %DialogPopup
@onready var dialog_load_ref = %dialog_loader

var action_signal:bool = true
var is_dialogue_on:bool = false
var is_dashing:bool = false
var base_speed = speed
var is_reversing_anim:bool = true
var test_count:int = 1

func animate(state: String):
	if state == "walking":
		pass
	if state == "running":
		pass
	if state == "idle":
		pass
	if state == "hello":
		$anims/Item_equipped.visible = true

func inverse_animate(state:String):
	if state == "hello":
		$anims/Item_equipped.visible = false
		

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if dialogue_ref.active:
		is_dialogue_on = true
	else:
		is_dialogue_on = false
	if Input.is_action_just_pressed(direction_input["dash"]) and !is_dialogue_on:
		is_dashing = true
	if Input.is_action_just_released(direction_input["dash"]) and !is_dialogue_on:
		is_dashing = false
	
	
	if is_dashing:
		speed = move_toward(speed, base_speed*dash_modifier, momentum["initial_dash_velocity"])
	else:
		speed = move_toward(speed, base_speed, momentum["end_dash_velocity"])
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis(direction_input["left"],direction_input["right"])
	if direction and !is_dialogue_on:
		
		velocity.x = move_toward(velocity.x, direction * speed, momentum["initial_velocity"])
		animate("walking")
		if direction == -1:
			animation_ref.flip_h = true
		if direction == 1:
			animation_ref.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, momentum["end_velocity"])

	move_and_slide()
	

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_accept") and not is_interact and !is_dialogue_on:
		is_interact = true
		
	if not Input.is_action_just_pressed("ui_accept") and !is_dialogue_on:
		is_interact = false
	
	if is_busy and action_signal:
		action_signal = false
		if action_index == 0 and not is_hand_full:
			equipped_item = action_string
			animate(equipped_item)
			is_hand_full = false
			
		elif action_index == 1:
			camera_manage_ref.teleport_to_area(action_value[action_index],action_second_parameter)
		
		elif action_index == 2:
			var all_dialogue:Dictionary = dialog_load_ref.load_json(action_string)
			var dialogue_container:Array[String]
			for text in range(action_second_parameter.x, action_second_parameter.y+1):
				dialogue_container.append(all_dialogue[str(text)])
			dialogue_ref.begin_dialog(dialogue_container)
		elif action_index == 4:
			if action_string == "bro":
						
				if equipped_item == "hello":
						inverse_animate("hello")
						equipped_item = ""
						is_hand_full = false
				
		is_busy = false
		action_signal = true

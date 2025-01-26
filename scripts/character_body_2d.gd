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
@export var camera_settlement:int = 2
@onready var direction_input_storage = direction_input
@onready var action_value:Array = [null,null,null,null,null]
@onready var action_index:int 



@onready var action_second_parameter:Array[Vector2] = [Vector2.ZERO,Vector2.ZERO,Vector2.ZERO,Vector2.ZERO,Vector2.ZERO]
@onready var action_string:Array[String] = ["","","","",""]
@onready var action_tag:Array[int] = [0,0,0,0,0]
@onready var is_interact: bool = false
@onready var is_busy:bool = false
@onready var is_hand_full:bool = false
@onready var is_queuing_action:bool = false
@onready var is_dialogue_occupied:bool = false
@onready var equipped_item:String
@onready var animation_ref = $anims/Sprite2D
@onready var camera_manage_ref = %Camera_setter
@onready var camera = %"main camera"
@onready var dialogue_ref = %DialogPopup
@onready var dialog_load_ref = %dialog_loader
@onready var glow_objs = %"glowing objects"

@onready var dialogue_history:Dictionary = {
	"json": "",
	"from":0,
	"to":0
}
var action_signal:bool = true
var is_screen_busy:bool = false
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
		
func _ready() -> void:
	camera_manage_ref.teleport_to_area(2,Vector2(960, 37))


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if dialogue_ref.active or camera.camera_transitioning:
		is_screen_busy = true
	else:
		is_screen_busy = false
	if Input.is_action_just_pressed(direction_input["dash"]) and !is_screen_busy:
		is_dashing = true
	if Input.is_action_just_released(direction_input["dash"]) and !is_screen_busy:
		is_dashing = false
	
	
	if is_dashing:
		speed = move_toward(speed, base_speed*dash_modifier, momentum["initial_dash_velocity"])
	else:
		speed = move_toward(speed, base_speed, momentum["end_dash_velocity"])
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis(direction_input["left"],direction_input["right"])
	if direction and !is_screen_busy:
		
		velocity.x = move_toward(velocity.x, direction * speed, momentum["initial_velocity"])
		animate("walking")
		if direction == -1:
			animation_ref.flip_h = true
		if direction == 1:
			animation_ref.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, momentum["end_velocity"])

	move_and_slide()
	
func dialogue_load(json:String, from:int, to:int): # nested dictionaries not supported
	var all_dialogue:Dictionary = dialog_load_ref.load_json(json)
	var dialogue_container:Array[String]
		
	for text in range(from, to+1):
		dialogue_container.append(all_dialogue[str(text)])
	dialogue_ref.begin_dialog(dialogue_container)
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_accept") and not is_interact and !is_screen_busy and not is_queuing_action:
		is_interact = true
		
	if not Input.is_action_just_pressed("ui_accept") and !is_screen_busy:
		is_interact = false
	
	if is_dialogue_occupied and not is_queuing_action:
		dialogue_load(action_string[2],action_second_parameter[2].x,action_second_parameter[2].y)
	
	if is_busy and action_signal:
		action_signal = false
		if action_index == 0 and not is_hand_full:# NO QUEUE
			equipped_item = action_string[action_index]
			animate(equipped_item)
			is_hand_full = false
			
		elif action_index == 1 and not is_queuing_action: # QUEUE
			print("yuh")
			camera.transition()
			$timers/camera_transition_timing.start()
			if action_tag[action_index] == 222:
				pass
				print("yo")
				action_string[2] = "res://dialogs/json_test_file.json"
				action_second_parameter[2] = Vector2(4,4)
				is_dialogue_occupied = true
				
		
		elif action_index == 2: # QUEUE
			is_dialogue_occupied = true
			if action_tag[action_index] == 234:
				progress.complete_quest("The Fallen Mates")
				
		elif action_index == 4: # NO QUEUE
			print("yuh")
			if action_string[action_index] == "bro":
						
				if equipped_item == "hello":
						inverse_animate("hello")
						equipped_item = ""
						is_hand_full = false
				
			elif action_string[action_index] == "night":
				glow_objs.change_cycle("night")
				
			elif action_string[action_index] == "day":
				glow_objs.change_cycle("day")
		is_busy = false
		action_signal = true


func _on_camera_transition_timing_timeout() -> void:
	print(action_value[action_index])
	print(action_second_parameter[action_index])
	camera_manage_ref.teleport_to_area(action_value[action_index],action_second_parameter[action_index])
	$timers/camera_transition_timing.stop()

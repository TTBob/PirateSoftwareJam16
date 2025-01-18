extends CharacterBody2D


@export var speed: float = 300
@export var momentum: Dictionary = {
	"initial_velocity": 300,
	"end_velocity": 300,
	"initial_dash_velocity":300,
	"end_dash_velocity": 300
}
@export var dash_modifier: float = 1.1
@onready var animation_ref = $anims/Sprite2D
@export var direction_input: Dictionary = {
	"left": "ui_left",
	"right": "ui_right",
	"dash": "ui_up"
}
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
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	

	if Input.is_action_just_pressed(direction_input["dash"]):
		is_dashing = true
	if Input.is_action_just_released(direction_input["dash"]):
		is_dashing = false
	
	
	if is_dashing:
		speed = move_toward(speed, base_speed*dash_modifier, momentum["initial_dash_velocity"])
	else:
		speed = move_toward(speed, base_speed, momentum["end_dash_velocity"])
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis(direction_input["left"],direction_input["right"])
	if direction:
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
	
	if Input.is_action_just_pressed(direction_input["dash"]):
		%Camera_setter.teleport_to_area(test_count)
		test_count +=1
		print("test count"+ str(test_count))
		

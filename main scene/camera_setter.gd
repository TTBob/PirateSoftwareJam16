extends Node2D


@onready var component_ref = %Camera_setter
@export var camera_size = 1.845
@onready var camera_pos_ref = get_node("camera_pos")
@onready var is_active:bool = false
@onready var int_name = name.to_int()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	component_ref.camera_zoom[int_name] = camera_size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if component_ref.queue.size() > 0:
		if not is_active and component_ref.queue[0] == int_name:
			component_ref.camera_set(int_name,camera_pos_ref.global_position)
			is_active = true
		elif is_active and not component_ref.queue[0] == int_name:
			is_active = false
	

	

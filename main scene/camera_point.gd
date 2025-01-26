extends Node2D


@onready var component_ref = %Camera_setter
@export var camera_size = 1.845
@onready var camera_pos_ref = get_node("camera_pos")
@onready var int_name:int = name.to_int()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	component_ref.camera_zoom[int_name] = camera_size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

	

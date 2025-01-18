extends Area2D


@onready var component_ref = %Camera_setter
@onready var player_teleport_ref = get_node("Player_teleport_pos")
@onready var is_active:bool = false
@onready var int_name = name.to_int()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if component_ref.queue.size() > 0:
		if not is_active and component_ref.queue[0] == int_name:
			component_ref.camera_set(int_name,position, player_teleport_ref.global_position)
			is_active = true
		elif is_active and not component_ref.queue[0] == int_name:
			is_active = false
	

	

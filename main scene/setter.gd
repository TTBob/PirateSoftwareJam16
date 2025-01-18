extends Node2D

@export var camera_zoom:Array = [0, 1.845,1.845,1.845, 1.845, 1.845,1.845]
@onready var queue:Array = []
@onready var camera_ref = %Main_camera
@onready var player_ref = $"../CharacterBody2D"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func camera_set(area_index:int, self_position:Vector2, player_teleport_pos:Vector2):
	print("A" + str(player_teleport_pos))
	player_ref.position = player_teleport_pos
	camera_ref.position = self_position
	camera_ref.zoom = Vector2(camera_zoom[area_index],camera_zoom[area_index])
func teleport_to_area(area_index:int):
	queue.clear()
	queue.append(area_index)

@icon("res://icons/16x16/camera_free.png")
extends Node2D

@export var camera_zoom:Array = [
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	]
@onready var queue:int 
@onready var chosen_position:Vector2
@onready var camera_ref = %"main camera"
@onready var player_ref = %CharacterBody2D
var all_children:Array[Node] = get_children(false)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func camera_set(area_index:int, self_position:Vector2):
	print(chosen_position)
	player_ref = %CharacterBody2D
	all_children = get_children(false)
	player_ref.global_position = chosen_position
	camera_zoom[area_index] = all_children[area_index].camera_size
	camera_ref = %"main camera"
	camera_ref.position = self_position
	camera_ref.zoom = Vector2(camera_zoom[area_index],camera_zoom[area_index])
	
func teleport_to_area(area_index:int,pos_of_teleport:Vector2):
	chosen_position = pos_of_teleport
	#queue = area_index
	all_children = get_children(false)
	camera_set(area_index,all_children[area_index].global_position)
	

extends Control

@onready var main = $"Main"
@onready var settings = $"Settings"
@onready var credits = $"Credits"

@export var screen: int = 0

func _process(_delta):
	main.set_position(main.position.lerp(Vector2(get_viewport().get_visible_rect().size.x * screen, 0),0.2))
	settings.set_position(settings.position.lerp(Vector2(get_viewport().get_visible_rect().size.x * (screen+1), 0),0.2))
	credits.set_position(credits.position.lerp(Vector2(get_viewport().get_visible_rect().size.x * (screen-1), 0),0.2))

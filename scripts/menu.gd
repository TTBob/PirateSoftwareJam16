extends Control

@onready var main = $"Main"
@onready var settings = $"Settings"
@onready var credits = $"Credits"

@export var screen: int = 0

func _ready():
	var audio_player = AudioStreamPlayer.new()
	audio_player.stream = load("res://audio/music_final_1.mp3")
	audio_player.autoplay = true
	audio_player.bus = "Background Music"
	add_child(audio_player)

func _process(_delta):
	main.set_position(main.position.lerp(Vector2(get_viewport().get_visible_rect().size.x * screen, 0),0.2))
	settings.set_position(settings.position.lerp(Vector2(get_viewport().get_visible_rect().size.x * (screen+1), 0),0.2))
	credits.set_position(credits.position.lerp(Vector2(get_viewport().get_visible_rect().size.x * (screen-1), 0),0.2))

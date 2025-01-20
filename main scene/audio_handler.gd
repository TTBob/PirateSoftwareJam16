@icon("res://icons/16x16/music.png")
extends Node2D

func _ready():
	var background = AudioStreamPlayer.new()
	background.stream = load("res://audio/ominous_prototype_2.mp3")
	background.autoplay = true
	background.bus = "Background Music"
	add_child(background)

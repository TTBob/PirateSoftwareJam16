@icon("res://icons/16x16/window_dialogue.png")
extends Control

@onready var label = $"./Label"
@onready var timer = $"./Label/Timer"

var active = false
var sentences_left: Array[String]

func _ready() -> void:
	timer.timeout.connect(next_character)

func _process(_delta):
	if active:
		label.offset_top = lerp(label.offset_top, 50.0, 0.2)
	else:
		label.offset_top = lerp(label.offset_top, 300.0, 0.2)
func _input(_e):
	if Input.is_action_just_pressed("dialog_next") and active:
		if sentences_left[0].length() != 0:
			label.text += sentences_left[0]
			sentences_left[0] = ""
			timer.stop()
		else:
			sentences_left.pop_at(0)
			if sentences_left.size() == 0:
				active = false
				return
			label.text = ""
			timer.start()
	if Input.is_action_just_pressed("ui_cancel") and active:
		active = false
	
func dictionary_to_array(dictionary:Dictionary) -> Array[String]:
	var empty_array_string: Array[String]
	var value:Array = dictionary.values()
	empty_array_string.assign(value)
	return empty_array_string
func begin_dialog(dialog):
	# Get information from parser
	active = true
	sentences_left = dialog
	label.text = ""
	timer.start()
	
func next_character():
	label.text += sentences_left[0][0]
	sentences_left[0] = sentences_left[0].substr(1)
	if sentences_left[0].length() == 0:
		timer.stop()

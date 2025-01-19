extends Control

@onready var label = $"./Label"
@onready var timer = $"./Label/Timer"

var active = false
var sentences_left: Array[String]

func _ready() -> void:
	timer.timeout.connect(next_character)

func _process(_delta):
	if active:
		label.offset_top = lerp(label.offset_top, -200.0, 0.2)
	else:
		label.offset_top = lerp(label.offset_top, 50.0, 0.2)

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

func begin_dialog(dialog):
	# Get information from parser
	active = true
	sentences_left = [
		"This is a dialogue window. It handles dialogs by recieving dialog commands from a parser and sequences through them.",
		"This is the second part of this dialogue sequence. Notice how I had to press SPACE to toggle to this next one, which will leave the players plenty of time to read!"
	]
	label.text = ""
	timer.start()
	
func next_character():
	label.text += sentences_left[0][0]
	sentences_left[0] = sentences_left[0].substr(1)
	if sentences_left[0].length() == 0:
		timer.stop()

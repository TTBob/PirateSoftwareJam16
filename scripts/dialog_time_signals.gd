extends Node2D

@onready var end_dialogue_signal
@onready var end_statement_signal
@onready var start_dialogue_signal
@onready var start_statement_signal
@onready var dialogue_button_pressed
@onready var skipped
@onready var e
@onready var a
@onready var s
@onready var c

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if dialogue_button_pressed:
		print("-------------------dialogue_button_pressed--------------------")
		dialogue_button_pressed = false
	if end_dialogue_signal:
		$"../time_buffer".start()
		print("end_dialogue_signalEEEEE")
		end_dialogue_signal = false
		
	if end_statement_signal:
		print("end_statement_signalEEEEEE")
		end_statement_signal = false
		
	if start_dialogue_signal:
		print("start_dialogue_signalAAAAAA")
		start_dialogue_signal = false
		
	if start_statement_signal:
		print("start_statement_signalAAAAAAA")
		start_statement_signal = false
		
		
	if skipped:
		print("skip")
		skipped = false


func _on_time_buffer_timeout() -> void:
	pass
	$"..".character.is_queuing_action = false
	$"../time_buffer".stop()
	#$"..".character.is_dialogue_occupied = false
	#$"..".character.is_queuing_action = false

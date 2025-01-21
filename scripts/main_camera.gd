@icon("res://icons/16x16/camera.png")
extends Camera2D

@onready var camera_transitioning: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func transition(type:String):
	camera_transitioning = true
	pass
	$ColorRect/Timer.wait_time = 4
	$ColorRect.visible = true
	$ColorRect/fading.play("fade_in")
	if type == "ladder":
		$ColorRect/audios/ladder.play()
		$ColorRect/Timer.wait_time += 3
	else:
		$ColorRect/audios/Door.play()
	$ColorRect/Timer.start()

func _on_timer_timeout() -> void:
	camera_transitioning = false
	$ColorRect/Timer.stop()
	$ColorRect/fading.play_backwards("fade_in")
	$ColorRect/audios/Door.stop()

extends Button

func _ready():
	pressed.connect(self._button_pressed)

func _button_pressed():
	print("button pressed")
	$"../".begin_dialog({"1": "hello:34523432423", "2": "yo"})

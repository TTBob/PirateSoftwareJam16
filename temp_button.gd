extends Button

func _ready():
	pressed.connect(self._button_pressed)

func _button_pressed():
	print("button pressed")
	$"../".begin_dialog(0)

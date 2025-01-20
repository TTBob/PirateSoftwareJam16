extends HSlider

func _ready():
	value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Background Music")))*100

func _value_changed(new_value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Background Music"), linear_to_db(value/100))

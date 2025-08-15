extends HSlider

@export var bus_name: String

var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)
	
	value = AudioServer.get_bus_volume_linear(bus_index)

func _on_value_changed(volume: float):
	AudioServer.set_bus_volume_linear(bus_index, volume)

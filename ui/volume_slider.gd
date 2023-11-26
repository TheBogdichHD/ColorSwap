extends HSlider

@export var bus_name: String

var bus_index

func _ready():
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)
	value = Save.data["settings"][bus_name + "_volume"]

func _on_value_changed(value):
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	Save.data["settings"][bus_name + "_volume"] = value

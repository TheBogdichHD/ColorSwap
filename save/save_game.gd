extends Node

var path = "user://data.json"

var default_data = {
	"settings": {
		"fullscreen": false,
		"resolution": "",
		"Master_volume": 1.0,
		"music_volume": 0.3,
		"sfx_volume": 1.0,
	},
	"levels": {
		"level_unlocked": ["1"],
		"in_menu": false,
		"has_key": false,
	}
}

var data = {}


func _ready():
	load_game()


func load_game():
	if FileAccess.file_exists(path):
		var json_as_text = FileAccess.get_file_as_string(path)
		var json_as_dict = JSON.parse_string(json_as_text)
		
		if json_as_dict is Dictionary:
			data = json_as_dict
		else:
			print("Error reading")
	else:
		reset_data()

func save_game():
	var data_file = FileAccess.open(path, FileAccess.WRITE)
	data_file.store_line(JSON.stringify(data))

func reset_data():
	data = default_data.duplicate(true)


func _on_tree_exiting():
	save_game()

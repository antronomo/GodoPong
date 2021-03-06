extends Node

const SAVEFILE = "user://SAVEFILE.save"

var game_data = {}

func _ready() -> void:
	load_data()

func load_data() -> void:
	var file = File.new()
	if not file.file_exists(SAVEFILE):
		to_default_data()
	file.open(SAVEFILE, File.READ)
	game_data = file.get_var()
	file.close()

func save_data() -> void:
	var file = File.new()
	file.open(SAVEFILE, File.WRITE)
	file.store_var(game_data)
	file.close()

func to_default_data():
	game_data = {
			"char1_mode": 0,
			"char1_color": Color(1,1,1,1),
			"char2_mode": 1,
			"char2_color": Color(1,1,1,1),
			"win_condition": 3,
			"ball_color": Color(1,1,1,1)
		}
	save_data()

extends Node

const SAVEFILE = "user://SAVEFILE.save"
const CurrentVersion = "0.5.0"
const DefaultGameData : Dictionary = {
	"version" : CurrentVersion,
	"char1_mode" : 0,
	"char1_color" : Color(1,1,1,1),
	"char2_mode" : 1,
	"char2_color" : Color(1,1,1,1),
	"win_condition" : 3,
	"full_screen" : false,
	"ball_color" : Color(1,1,1,1),
	"MAS_slider" : 1.0,
	"MAS_muted" : false,
	"SFX_slider" : 1.0,
	"SFX_muted" : false,
	"MSC_slider" : 1.0,
	"MSC_muted" : false
}

var game_data : Dictionary = {}

func _ready() -> void:	
	load_data()

func load_data() -> void:
	var load_file = File.new()

	if !load_file.file_exists(SAVEFILE):
		to_default_data()
		
	load_file.open(SAVEFILE, File.READ)
	game_data = load_file.get_var()
	
	if !game_data.has("version") || game_data.version != CurrentVersion:
		to_default_data()
		
	load_file.close()

func save_data() -> void:
	var save_file = File.new()
	save_file.open(SAVEFILE, File.WRITE)
	save_file.store_var(game_data)
	save_file.close()

func to_default_data() -> void:
	game_data = DefaultGameData.duplicate()
	save_data()

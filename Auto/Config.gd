extends Node

onready var Sgd : Dictionary = Save.game_data

func _ready() -> void:
	audio_updater()
	window_updater()

func window_updater() -> void:
	Sgd = Save.game_data

	OS.window_fullscreen = Sgd.full_screen
	# OS.window_borderless

func audio_updater() -> void:
	Sgd = Save.game_data

	# MASTER
	var mas_vol : float = Sgd.MAS_slider
	AudioServer.set_bus_volume_db(0, linear2db(mas_vol))
	AudioServer.set_bus_mute(0, Sgd.MAS_muted)

	# Sound FX
	var sfx_vol : float = Sgd.SFX_slider
	AudioServer.set_bus_volume_db(1, linear2db(sfx_vol))
	AudioServer.set_bus_mute(1, Sgd.SFX_muted)

	# Music
	var msc_vol : float = Sgd.MSC_slider
	AudioServer.set_bus_volume_db(2, linear2db(msc_vol))
	AudioServer.set_bus_mute(2, Sgd.MSC_muted)

extends Node

signal char1_mode_toggled(value)
signal char2_mode_toggled(value)

func toggle_char1_mode(value : int) -> void :
	emit_signal("char1_mode_toggled", value)

func toggle_char2_mode(value : int) -> void :
	emit_signal("char2_mode_toggled", value)

extends Node

#Añadir una función para poner el juego en pantalla completa?

signal char1_toggled(value)
signal char2_toggled(value)

func char1_mode(value : int) -> void :
    emit_signal("char1_toggled", value)

func char2_mode(value : int) -> void :
    emit_signal("char2_toggled", value)
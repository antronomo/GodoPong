extends Node

export var main_music : AudioStream
export var explosion_sfx : AudioStream

func _ready():
	$Music.stream = main_music
	$Music.play()

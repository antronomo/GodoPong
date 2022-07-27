extends Node2D

onready var Sgd = Save.game_data

func _ready():
	$Particles2D.emitting = true
	self.modulate = Sgd.ball_color

func _on_Timer_timeout():
	queue_free()

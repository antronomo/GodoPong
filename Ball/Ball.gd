extends KinematicBody2D

var spd : int = 300
var vel : Vector2 = Vector2.ZERO

func _ready() -> void:

	randomize()
	vel.x = [-1, 1] [randi() % 2]
	vel.y = [-0.8, 0.8] [randi() % 2]

func movement(delta) -> void:

	vel = vel.normalized() * spd * delta
	var collision = move_and_collide(vel)

	if collision:
		vel = vel.bounce(collision.normal)

func _physics_process(delta) -> void:
	
	movement(delta)

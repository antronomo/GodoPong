extends KinematicBody2D

var spd : int = 300
var vel : Vector2 = Vector2.ZERO

func _ready() -> void:
	randomize()
	vel = initial_direction(randi() % 2)

func movement(delta) -> void:
	vel = vel.normalized() * spd * delta
	var collision = move_and_collide(vel)

	if collision:
		vel = vel.bounce(collision.normal)
		spd += 10

func initial_direction(come_from : int) -> Vector2:
	vel.x = [-1, 1] [come_from]
	vel.y = [-0.8, 0.8] [randi() % 2]
	return vel

func _physics_process(delta) -> void:
	movement(delta)

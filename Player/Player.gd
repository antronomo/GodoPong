extends KinematicBody2D

onready var ball = get_parent().find_node("Ball")
onready var s_size = get_parent().find_node("ColorRect")
#si "can_move" está habilitado por defecto, dara errores fuera de "arena"
onready var can_move : bool = false setget set_can_move, get_can_move

const InitialSPD : int = 500

export var spd : float = InitialSPD
export var c_name : String setget set_cName

var screen_size : Vector2
var vel : Vector2 = Vector2.ZERO

#Esto existe para que la consola no de avertencias
var collision : KinematicCollision2D

func player_movement(delta) -> void:
	vel.y = Input.get_action_strength(c_name + "_down") - Input.get_action_strength(c_name + "_up")
	collision = move_and_collide(vel * InitialSPD * delta)	

func bot_movement(delta) -> void:
	vel.y = 0
	if abs(ball.position.x - position.x) < s_size.rect_size.x / 2: # Si la pelota está en su mitad del campo
		if abs(ball.position.y - position.y) > 25: # Curar el Parkinson del bot
			if ball.position.y > position.y:
				vel.y = 1
			else:
				vel.y = -1

	collision = move_and_collide(vel * spd * delta)

func set_can_move(may_i : bool) -> void:
	can_move = may_i

func get_can_move() -> bool:
	return can_move

func set_cName(newName) -> void:
	c_name = newName

func _on_Nerfer_timeout():
	spd -= InitialSPD * 0.10

func _on_AnimationPlayer_animation_finished(anim_name : String):
	if anim_name == "Hurted":
		$AnimationPlayer.play("idle")
		print(c_name, "can dettect ball")

func _physics_process(delta) -> void:
	if can_move:
		match c_name:
			"player1":
				player_movement(delta)
			"player2":
				player_movement(delta)
			"bot":
				bot_movement(delta)

		if collision:
			var coll = collision.collider

			if coll == ball:
				$AnimationPlayer.play("Hurted")
				print(c_name, "cannot dettect ball")

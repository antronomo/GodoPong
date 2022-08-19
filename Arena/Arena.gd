extends Node 

var winner : String setget set_winner, get_winner
var score1 : int = 0
var score2 : int = 0
var color_winner : Color
var final_score : int
var explosion_particle_path = load("res://Ball/ExplosionParticles.tscn")
var coll_particle_path = load("res://Ball/CollisionParticles.tscn")

onready var initial_spd : int = $Ball.spd
onready var initial_pos_char1 : Vector2 = $Char1.position
onready var initial_pos_char2 : Vector2 = $Char2.position
onready var game_size : Vector2 = $ColorRect.rect_size
onready var score_anim = $Container/AnimationPlayer
onready var ui_anim = $UI_AnimationPlayer
onready var b_trail: Node = $BallTrail2D

# Para escribir menos
onready var Sgd = Save.game_data
onready var GCVW = $GameOverScreen/CenterContainer/VBoxContainer/WhoIsTheWinner

func _ready() -> void:
	# Char1
	var indice1 : int  = Sgd.char1_mode
	$Char1.c_name = "player1" if indice1 == 0 else "bot"
	$Char1.set_can_move(true)
	$C1Controllers.visible = true if indice1 == 0 else false
	$Char1.modulate = Sgd.char1_color
	$BorderLeft.modulate = Sgd.char1_color

	# Char2
	var indice2 = Sgd.char2_mode
	$Char2.c_name = "player2" if indice2 == 0 else "bot"
	$Char2.set_can_move(true)
	$C2Controllers.visible = true if indice2 == 0 else false
	$Char2.modulate = Sgd.char2_color
	$BorderRight.modulate = Sgd.char2_color

	# Score
	# con el "win condition" en negativo, la partida jamás acabará por muchos goles que char 1 o 2 meta
	if Sgd.win_condition != 0: 
		final_score = Sgd.win_condition
	else: 
		final_score = -1
	
	# sBall
	$Ball.position = game_size / 2
	$Ball.modulate = Sgd.ball_color
	$SpaceBar.visible = false if indice1 == 1 && indice2 == 1 else true
	b_trail.modulate = Sgd.ball_color
	
	# GameOverScreen
	$GameOverScreen.visible = false

	# Activar los nerfers si ambos tienen el mismo nombre (solo afecta a los bots)
	if $Char1/Nerfer.is_stopped() && $Char1.c_name == $Char2.c_name && $Char2/Nerfer.is_stopped():
		$Char1/Nerfer.start()
		$Char2/Nerfer.start()

func _on_body_entered(body : Node):
	var new_explo = explosion_particle_path.instance()
	new_explo.position = $Ball.position
	add_child(new_explo)
	$ExplosionStreamPlayer.stream = GlobalPlayer.explosion_sfx
	$ExplosionStreamPlayer.play()

# Señal 'body_exited' de wall_left y wall_right
func body_exited(body : Node) -> void:
	if body == $Ball:
		if body.position.x < game_size.x / 2:
			score2 += 1
			score_anim.play("Char2ScoreFlicker")
			$Container/Char2_score.text = str(score2)
			body.initial_direction(1)

		elif body.position.x > game_size.x / 2:
			score1 += 1
			score_anim.play("Char1ScoreFlicker")
			$Container/Char1_score.text = str(score1)
			body.initial_direction(0)

		body.set_can_move(false)
		body.position = game_size / 2
		body.spd = initial_spd

		if $Char1.c_name != $Char2.c_name:
			$Char1/Nerfer.stop()
			$Char2/Nerfer.stop()

		$Char1.spd = $Char1.InitialSPD
		$Char2.spd = $Char2.InitialSPD

		check_score()

	$Char1.position = initial_pos_char1
	$Char2.position = initial_pos_char2

func on_animation_finished():
	score_anim.play("Idle")

func check_score() -> void:
	if(score1 == final_score):
		set_winner($Char1.c_name)
	if(score2 == final_score):
		set_winner($Char2.c_name)

func set_winner(new_winner : String) -> void:
	winner = new_winner
	game_over()

func get_winner() -> String:
	return winner

func game_over() -> void:
	color_winner = Sgd.char1_color if score1 > score2 else Sgd.char2_color
	ui_anim.play("GameOverAnim")
	$PauseMenu.queue_free()
	GCVW.text = get_winner().to_upper()
	GCVW.modulate = color_winner
	$GameOverScreen/CenterContainer/VBoxContainer/MainMenuButton.grab_focus()

func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://UI/Main_menu.tscn")

# Esto es para esconder el "tutorial rápido sobre los controles"
func _input(event) -> void:
	if event.is_action_pressed("player1_up") || event.is_action_pressed("player1_down"):
		$C1Controllers.visible = false

	if event.is_action_pressed("player2_up") || event.is_action_pressed("player2_down"):
		$C2Controllers.visible = false

	if event.is_action_pressed("ui_accept"):
		$SpaceBar.visible = false

		# De todas formas, solo les afecta a los "bots"
		if $Char1/Nerfer.is_stopped():
			$Char1/Nerfer.start()

		if $Char2/Nerfer.is_stopped():
			$Char2/Nerfer.start()

func set_WITW_color(new_color : Color) -> void:
	GCVW.modulate = new_color

func _process(_delta) -> void:	
	if winner == "":
		if Input.is_action_just_pressed("ui_accept"):
			$Ball.set_can_move(true)

		if $Char1.c_name == "bot" && $Char1.c_name == $Char2.c_name:
			$Ball.set_can_move(true)

	else:
		$Char1.set_can_move(false)
		$Char2.set_can_move(false)
		$Ball.set_can_move(false)

	b_trail.add_point($Ball.position)

	if b_trail.get_point_count() > 45:
		b_trail.remove_point(0)

func _physics_process(delta):
	if $Ball.collision:
		var coll_explo = coll_particle_path.instance()
		coll_explo.position = $Ball.position
		add_child(coll_explo)

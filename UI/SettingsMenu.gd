extends Control

# Character mode
onready var char1_mode_but = $GridContainer/Character1/Char1Mode
onready var char2_mode_but = $GridContainer/Character2/Char2Mode
onready var win_ocn_but = $GridContainer/WinCondition/GoalsToWin

# Atajos para el ColorPicker
onready var char1_color_picker = $GridContainer/Character1Color/Popup/Char1ColorPicker
onready var char2_color_picker = $GridContainer/Character2Color/Popup/Char2ColorPicker
onready var ball_color_picker = $GridContainer/BallColor/Popup/BallColorPicker

# Atajos para el PopUp
onready var char1_color_popup = $GridContainer/Character1Color/Popup
onready var char2_color_popup = $GridContainer/Character2Color/Popup
onready var ball_color_popup = $GridContainer/BallColor/Popup

# Atajos para el ColorRect
onready var char1_color_cr = $GridContainer/Character1Color/ColorRect
onready var char2_color_cr = $GridContainer/Character2Color/ColorRect
onready var ball_color_cr = $GridContainer/BallColor/ColorRect

# Atajos para los color_buttons
onready var char1_color_button = $GridContainer/Character1Color/Char1Color
onready var char2_color_button = $GridContainer/Character2Color/Char2Color
onready var ball_color_button = $GridContainer/BallColor/BallColorBut

# Para escribir menos
onready var Sgd = Save.game_data
onready var win_con = $GridContainer/WinCondition/GoalsToWin

func _ready() -> void:
	char1_mode_but.grab_focus()

	char1_mode_but.select(Sgd.char1_mode)
	char1_color_cr.color = Sgd.char1_color

	char2_mode_but.select(Sgd.char2_mode)
	char2_color_cr.color = Sgd.char2_color

	win_ocn_but.select(Sgd.win_condition)
	ball_color_cr.color = Sgd.ball_color

# CHARACTER 1----------------------------------------------------------
func _on_Char1Mode_item_selected(index : int) -> void:
	Sgd.char1_mode = index

func _on_Char1Color_pressed() -> void:
	char1_color_popup.show()

func _on_Char1ColorPicker_color_changed(color_picked : Color) -> void:
	Sgd.char1_color = color_picked
	char1_color_cr.color = Sgd.char1_color

# CHARACTER 2-----------------------------------------------------------
func _on_Char2Mode_item_selected(index : int) -> void:
	Sgd.char2_mode = index

func _on_Char2Color_pressed() -> void:
	char2_color_popup.show()

func _on_Char2ColorPicker_color_changed(color_picked : Color) -> void:
	Sgd.char2_color = color_picked
	char2_color_cr.color = Sgd.char2_color

# BALL------------------------------------------------------------------
func _on_BallColorBut_pressed() -> void:
	ball_color_popup.show()

func _on_BallColorPicker_color_changed(color_picked : Color) -> void:
	Sgd.ball_color = color_picked
	ball_color_cr.color = Sgd.ball_color

# TO RESET TO DEFAULT----------------------------------------------------
func _on_DefaultSettingsButton_pressed() -> void:
	Save.to_default_data()
	_ready()

# WIN CONDITION SELECTOR-------------------------------------------------
func _on_GoalsToWin_item_selected(index : int) -> void:
	Sgd.win_condition = index
	
#------------------------------------------------------------------------
func _on_ReturnButton_pressed() -> void:
	exiting()

func _input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		if !char1_color_popup.is_visible_in_tree() && !char2_color_popup.is_visible_in_tree() && !ball_color_popup.is_visible_in_tree():
			exiting()
		
		hidder_picker(true)

func exiting() -> void:
	Save.save_data()
	get_tree().change_scene("res://UI/Main_menu.tscn")

# Su funci??n es esconder los colorpickers si su bot??n pierde "focus"
func hidder_picker(value : bool) -> void:
	if char1_color_button.has_focus() == value:
		char1_color_popup.hide()

	if char2_color_button.has_focus() == value:
		char2_color_popup.hide()
		
	if ball_color_button.has_focus() == value:
		ball_color_popup.hide()

func _process(_delta) -> void:
	hidder_picker(false)

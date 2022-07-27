extends Control

# Char1
onready var char1_mode_but = $TabContainer/Game/GameContainer/Character1/Char1Mode
onready var char1_color_picker = $TabContainer/Game/GameContainer/Character1Color/Popup/Char1ColorPicker
onready var char1_color_popup = $TabContainer/Game/GameContainer/Character1Color/Popup
onready var char1_color_cr = $TabContainer/Game/GameContainer/Character1Color/ColorRect
onready var char1_color_button = $TabContainer/Game/GameContainer/Character1Color/Char1Color

# Char2
onready var char2_mode_but = $TabContainer/Game/GameContainer/Character2/Char2Mode
onready var char2_color_picker = $TabContainer/Game/GameContainer/Character2Color/Popup/Char2ColorPicker
onready var char2_color_popup = $TabContainer/Game/GameContainer/Character2Color/Popup
onready var char2_color_cr = $TabContainer/Game/GameContainer/Character2Color/ColorRect
onready var char2_color_button = $TabContainer/Game/GameContainer/Character2Color/Char2Color

# Ball
onready var ball_color_picker = $TabContainer/Game/GameContainer/BallColor/Popup/BallColorPicker
onready var ball_color_popup = $TabContainer/Game/GameContainer/BallColor/Popup
onready var ball_color_cr = $TabContainer/Game/GameContainer/BallColor/ColorRect
onready var ball_color_button = $TabContainer/Game/GameContainer/BallColor/BallColorBut

# WinCondition
onready var win_con_but = $TabContainer/Game/GameContainer/WinCondition/GoalsToWin
onready var win_con = $TabContainer/Game/GameContainer/WinCondition/GoalsToWin

# Atajos para SoundTab
onready var SFXlabel = $TabContainer/Sound/SoundContainer/SoundEffect/SlideLabel
onready var SFXslider = $TabContainer/Sound/SoundContainer/SoundEffect/SoundSlider
onready var SFXcheck = $TabContainer/Sound/SoundContainer/SoundEffect/SoundCheckBox

onready var MSClabel = $TabContainer/Sound/SoundContainer/MusicEffect/SlideLabel
onready var MSCslider = $TabContainer/Sound/SoundContainer/MusicEffect/MusicSlider
onready var MSCcheck = $TabContainer/Sound/SoundContainer/MusicEffect/MusicCheckBox

onready var MASlabel = $TabContainer/Sound/SoundContainer/MasterVolume/SlideLabel
onready var MASslider = $TabContainer/Sound/SoundContainer/MasterVolume/MasterSlider
onready var MAScheck = $TabContainer/Sound/SoundContainer/MasterVolume/MasterCheckBox

# Para escribir menos
onready var Sgd : Dictionary = Save.game_data

func _ready() -> void:
	set_game_data()

func set_game_data():
	Sgd = Save.game_data
	
	char1_mode_but.select(Sgd.char1_mode)
	char1_color_cr.color = Sgd.char1_color
	char1_color_picker.color = Sgd.char1_color
	
	char2_mode_but.select(Sgd.char2_mode)
	char2_color_cr.color = Sgd.char2_color
	char2_color_picker.color = Sgd.char2_color
	
	win_con_but.select(Sgd.win_condition)
	ball_color_cr.color = Sgd.ball_color
	ball_color_picker.color = Sgd.ball_color
	
	MASslider.value = Sgd.MAS_slider
	MAScheck.pressed = Sgd.MAS_muted
	
	SFXslider.value = Sgd.SFX_slider
	SFXcheck.pressed = Sgd.SFX_muted
	
	MSCslider.value = Sgd.MSC_slider
	MSCcheck.pressed = Sgd.MSC_muted

# GAME TAB ---------------------------------------------------------------
# CHARACTER 1
func _on_Char1Mode_item_selected(index : int) -> void:
	Sgd.char1_mode = index

func _on_Char1Color_pressed() -> void:
	char1_color_popup.show()

func _on_Char1ColorPicker_color_changed(color_picked : Color) -> void:
	Sgd.char1_color = color_picked
	char1_color_cr.color = color_picked

# CHARACTER 2
func _on_Char2Mode_item_selected(index : int) -> void:
	Sgd.char2_mode = index

func _on_Char2Color_pressed() -> void:
	char2_color_popup.show()

func _on_Char2ColorPicker_color_changed(color_picked : Color) -> void:
	Sgd.char2_color = color_picked
	char2_color_cr.color = color_picked

# BALL 
func _on_BallColorBut_pressed() -> void:
	ball_color_popup.show()

func _on_BallColorPicker_color_changed(color_picked : Color) -> void:
	Sgd.ball_color = color_picked
	ball_color_cr.color = color_picked

# WIN CONDITION SELECTOR
func _on_GoalsToWin_item_selected(index : int) -> void:
	Sgd.win_condition = index

# SOUND TAB --------------------------------------------------------------
# MASTER VOLUME
func _on_MasterSlider_value_changed(value : float) -> void:
	MASlabel.text = str(value * 100) + "%"
	Sgd.MAS_slider = value

func _on_MasterCheckBox_toggled(value : bool) -> void:
	MASslider.editable = !value
	MASlabel.modulate = Color(1, 1, 1, 1) if !value else Color(1, 1, 1, 0.5)
	Sgd.MAS_muted = value

# SOUND FX VOLUME
func _on_SoundSlider_value_changed(value : float) -> void:
	SFXlabel.text = str(value * 100) + "%"
	Sgd.SFX_slider = value

func _on_SoundCheckBox_toggled(value : bool) -> void:
	SFXslider.editable = !value
	SFXlabel.modulate = Color(1, 1, 1, 1) if !value else Color(1, 1, 1, 0.5)
	Sgd.SFX_muted = value

# MUSIC VOLUME
func _on_MusicSlider_value_changed(value : float) -> void:
	MSClabel.text = str(value * 100) + "%"
	Sgd.MSC_slider = value

func _on_MusicCheckBox_toggled(value : bool) -> void:
	MSCslider.editable = !value
	MSClabel.modulate = Color(1, 1, 1, 1) if !value else Color(1, 1, 1, 0.5)
	Sgd.MSC_muted = value

# BOTTOM BUTTONS
# TO RESET TO DEFAULT ---------------------------------------------------
func _on_DefaultSettingsButton_pressed() -> void:
	Save.to_default_data()
	set_game_data()

# SAVE AND EXIT BUTTON----------------------------------------------------
func _on_SAE_button_pressed() -> void:
	exiting()

#-------------------------------------------------------------------------

func _input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		if !char1_color_popup.is_visible_in_tree() && !char2_color_popup.is_visible_in_tree() && !ball_color_popup.is_visible_in_tree():
			exiting()
		
		hidder_picker(true)

func exiting() -> void:
	Save.save_data()
	Config.audio_updater()
	get_tree().change_scene("res://UI/Main_menu.tscn")

func _on_ItchIO_pressed():
	OS.shell_open("https://antronomo.itch.io/godopong")

func _on_GitHub_pressed():
	OS.shell_open("https://github.com/antronomo/GodoPong")

func _on_Twitch_pressed():
	OS.shell_open("https://www.twitch.tv/rafalagoon")

# Su función es esconder los colorpickers si su botón tiene o no "focus"
func hidder_picker(value : bool) -> void:
	if char1_color_button.has_focus() == value:
		char1_color_popup.hide()
	
	if char2_color_button.has_focus() == value:
		char2_color_popup.hide()
	
	if ball_color_button.has_focus() == value:
		ball_color_popup.hide()

func _process(_delta) -> void:
	hidder_picker(false)

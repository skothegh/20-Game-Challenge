extends CanvasLayer

@onready var player_1_score: Label = $Player_1_Score
@onready var player_2_score: Label = $Player_2_score

@onready var player_1_button: Button = $player_1_button
@onready var player_2_button: Button = $player_2_button

@onready var message: Label = $Message
@onready var tutorial_1: Label = $Tutorial_1
@onready var tutorial_2: Label = $Tutorial_2
@onready var pause_label: Label = $Pause_Label


signal start_1_player_game
signal start_2_player_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_1_score.hide()
	player_2_score.hide()
	

func update_score(player,score) -> void:
	if player == 1:
		player_1_score.text = str(score)
	elif player == 2:
		player_2_score.text = str(score)
	else:
		print("Wrong Player")
		
	
# ---- Signals ---- #
func _on_player_1_button_pressed() -> void:
	player_1_button.hide()
	player_2_button.hide()
	start_1_player_game.emit()

func _on_player_2_button_pressed() -> void:
	# should this logic be here?
	player_1_button.hide()
	player_2_button.hide()
	start_2_player_game.emit()

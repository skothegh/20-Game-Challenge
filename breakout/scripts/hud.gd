extends CanvasLayer
@onready var score: Label = $Score

@onready var life_1: Sprite2D = $life_1
@onready var life_2: Sprite2D = $life_2
@onready var life_3: Sprite2D = $life_3
@onready var message: Label = $Message
@onready var start: Button = $start
@onready var restart: Button = $restart
@onready var pause_label: Label = $PauseLabel

signal start_game


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score.hide()
	pause_label.hide()
	life_1.hide()
	life_2.hide()
	life_3.hide()
	
func update_score(value: int):
	score.text = "Score: " + str(value)

func update_message(text: String):
	message.text = text

func _on_start_pressed() -> void:
	start_game.emit()
	
	message.hide()
	message.hide()
	start.hide()
	
	score.visible = true
	life_1.visible = true
	life_2.visible = true
	life_3.visible = true

extends Node

@onready var hud: CanvasLayer = $HUD
@onready var ball_timer: Timer = $ball_timer
@onready var separator: Sprite2D = $Separator

@export var ball_scene: PackedScene
@export var paddle_scene: PackedScene
@export var ai_scene: PackedScene


var score = {1:0, 2:0}
var direction = Vector2(randf(),randf_range(-1,1)).normalized()

func _ready() -> void:
	get_tree().paused = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("RunPause") && get_tree().paused:
		get_tree().paused = false
		get_node("HUD").pause_label.visible = false
		
	elif Input.is_action_just_pressed("RunPause") && (not get_tree().paused):
		get_tree().paused = true
		get_node("HUD").pause_label.visible = true

func spawn_ball():
	var ball = ball_scene.instantiate()
	ball.scored.connect(_on_ball_scored)
	
	ball.position = Vector2(320,200)
	ball.direction = direction
	
	add_child(ball)
	
func spawn_paddle(player:Variant, position:Vector2):
	var paddle = paddle_scene.instantiate()
	paddle.player = player
	paddle.position = position
	
	add_child(paddle)
	
func spawn_ai(position:Vector2):
	var paddle = ai_scene.instantiate()
	paddle.position = position
	
	add_child(paddle)
	
func _on_ball_scored(player:Variant, dir:Variant) -> void:
	direction.x = dir # if player 1 scores ball starts in player 1 direction
	score[player] += 1
	hud.update_score(player, score[player])
	ball_timer.start()

func _on_timer_timeout() -> void:
	#spawn_ball()
	get_node("Ball").position = Vector2(320,200)
	get_node("Ball").direction = Vector2(direction.x,randf_range(-1,1)).normalized()
	get_node("Ball").visible = true
	get_node("Ball").speed = 175

func _on_hud_start_1_player_game() -> void:
	separator.visible = true
	
	hud.player_1_score.visible = true
	hud.player_2_score.visible = true
	
	hud.message.visible = false
	
	hud.tutorial_1.visible = false
	hud.tutorial_2.visible = false
	
	spawn_paddle(1,Vector2(40,200))
	spawn_ai(Vector2(600,200))	
	spawn_ball()
	
	get_node("Ball").position_changed.connect(get_node("ai_paddle").update_position)
	

func _on_hud_start_2_player_game() -> void:
	separator.visible = true
	
	hud.player_1_score.visible = true
	hud.player_2_score.visible = true
	
	hud.message.visible = false
	
	hud.tutorial_1.visible = false
	hud.tutorial_2.visible = false
	
	spawn_paddle(1,Vector2(40,200))
	spawn_paddle(2,Vector2(600,200))
	
	spawn_ball()

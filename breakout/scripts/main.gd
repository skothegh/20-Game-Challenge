extends Node

@onready var hud: CanvasLayer = $HUD
@onready var ball: Area2D = $Ball
@onready var paddle: Area2D = $Paddle
@onready var brickmanager: Node = $brickmanager
@onready var level_reset_timer: Timer = $level_reset_timer
@onready var high_score_manager: Control = $HighScoreManager

var score = 0
var lifes = 3
var level = 1

var is_running = false

func _ready() -> void:
	ball.speed = 0
	paddle.speed = 0
	paddle.hide()
	ball.hide()
	get_tree().call_group("bricks","hide")
	
func _process(delta: float) -> void:
	if ball.speed == 0:
		ball.position.x = paddle.position.x
	
	if is_running:
		if Input.is_action_just_pressed("release") && ball.speed == 0:
			ball.speed = 200 * (1.125 ** (level-1))
	
	if Input.is_action_just_pressed("pause") && get_tree().paused:
		get_tree().paused = false
		get_node("HUD").pause_label.visible = false
		
	elif Input.is_action_just_pressed("pause") && (not get_tree().paused):
		get_tree().paused = true
		get_node("HUD").pause_label.visible = true
			

func reset_ball() -> void:
	ball.speed = 0
	ball.position = Vector2(320,340)
	ball.direction = Vector2(2*randf()-1,-1).normalized()


func game_over():
	get_tree().call_group("bricks","queue_free")
	
	ball.hide()
	paddle.hide()
	
	hud.update_message("GAME OVER")
	hud.message.show()
	
	high_score_manager.label_container.show()
	high_score_manager.on_game_over(score)
	
	
	
func _on_brickmanager_brick_destoyed(value: int) -> void:
	score += value
	hud.update_score(score)

func _on_ball_died() -> void:
	lifes -= 1
	reset_ball()
	if lifes == 2:
		hud.life_1.hide()
	if lifes == 1:
		hud.life_2.hide()
	if lifes == 0:
		hud.life_3.hide()	
	if lifes < 0:
		game_over()

func _on_hud_start_game() -> void:
	brickmanager.spawn_bricks()
	get_tree().call_group("bricks","show")
	
	lifes = 3
	
	high_score_manager.label_container.hide()
	
	paddle.show()
	ball.show()
	paddle.speed = 250
	is_running = true
	
func _on_brickmanager_level_complete() -> void:
	### add a "Level" message
	reset_ball()				# return ball to paddle
	is_running = false			# freeze ball on paddle/ prevent start
	level += 1					# increase level
	level_reset_timer.start()	# start the level timer
	
	if lifes == 3:
		hud.update_message("Perfect!")
		hud.message.show()
	if lifes == 2:
		hud.update_message("+1 UP!")
		hud.message.show()
		lifes += 1
		hud.life_1.show()
	if lifes == 1:
		hud.update_message("+1 UP!")
		hud.message.show()
		lifes += 1
		hud.life_2.show()
	if lifes == 0:
		hud.update_message("+1 UP!")
		hud.message.show()
		lifes += 1
		hud.life_3.show()

func _on_level_reset_timer_timeout() -> void:
	brickmanager.spawn_bricks()
	hud.message.hide()
	is_running = true

func _on_high_score_manager_input_done() -> void:
	hud.start.show()
	score = 0
	hud.update_score(score)

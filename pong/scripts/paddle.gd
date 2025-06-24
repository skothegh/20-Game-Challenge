extends Area2D

@export var player: int = 1

@onready var screen_size = get_viewport_rect().size
var speed = 200

func _ready() -> void:
	pass
## needs to move up and down, but be clmaped by screen_size
func _process(delta: float) -> void:
	var direction = 0
	
	if player == 1:
		if Input.is_action_pressed("p1_move_down"):
			direction += 1
		if Input.is_action_pressed("p1_move_up"):
			direction -= 1
			
	elif player == 2:
		if Input.is_action_pressed("p2_move_down"):
			direction += 1
		if Input.is_action_pressed("p2_move_up"):
			direction -= 1		
		
	position.y += direction * speed * delta
	position = position.clamp(Vector2.ZERO+Vector2(0,16),screen_size-Vector2(0,16))


## ---- Signals ---- #
func _on_area_entered(area: Area2D) -> void:
	if area.name == "Ball":
		area.direction = Vector2(-area.direction.x, 2 * randf() - 1).normalized()

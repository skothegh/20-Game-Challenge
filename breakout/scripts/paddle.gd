extends Area2D

@onready var screen_size = get_viewport_rect().size

var speed = 250

func _process(delta: float) -> void:
	var direction = 0
	if Input.is_action_pressed("move_left"):
		direction = -1

	if Input.is_action_pressed("move_right"):
		direction = +1
	
	position.x += direction * speed * delta
	position = position.clamp(Vector2(36,0),screen_size-Vector2(36,0))
	

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Ball":
		var relative_position = (area.position.x - position.x)/32
		area.direction = Vector2(relative_position,-area.direction.y).normalized()
	

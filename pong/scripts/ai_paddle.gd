extends Area2D

@onready var screen_size = get_viewport_rect().size
#@onready var parent = get_parent()
var speed = 175

## ---- Signals ---- #
func update_position(ball_position: Vector2):
	var delta = get_physics_process_delta_time()
	var dir_y = (ball_position.y - position.y) / abs(ball_position.y - position.y)
	position.y += dir_y * speed * delta * randf_range(0.325,0.8)
	position = position.clamp(Vector2.ZERO+Vector2(0,16),screen_size-Vector2(0,16))

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Ball":
		area.direction = Vector2(-area.direction.x, 2 * randf() - 1).normalized()

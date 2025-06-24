extends Area2D

var direction = Vector2(2*randf()-1,-1).normalized()

signal died

var speed = 200

func _physics_process(delta: float) -> void:
	if position.y - 4 < 0:
		direction.y = -direction.y
	if position.x - 4 < 0:
		direction.x = -direction.x	
	if position.x + 4 > 620:
		direction.x = -direction.x
	
	direction = direction.normalized()
	position += direction * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	speed = 0
	died.emit()

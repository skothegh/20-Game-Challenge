extends Area2D

@onready var screen_size = get_viewport_rect().size

var speed = 200
var direction: Vector2 = Vector2.ZERO

signal scored(player, direction)
signal position_changed(position)

func _physics_process(delta: float) -> void:
	# here i could do floor/ceiling bounce
	if position.y + 4 > 400:
		direction.y = -direction.y
	if position.y - 4 < 0:
		direction.y = -direction.y
		
	position += speed * direction * delta
	position_changed.emit(position)
#
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if position.x < 0:
		scored.emit(2, 1)
	else:
		scored.emit(1, -1)
	
	speed = 0
	hide()
	#queue_free()

extends Area2D

const SIZE = Vector2(30,10)
@onready var center = position #!

var value 

signal destroyed(val)


func _on_area_entered(area: Area2D) -> void:
	if area.name == "Ball":
		
		if area.position.y > (position.y + SIZE.y / 2) or area.position.y < (position.y - SIZE.y / 2):
			area.direction.y = -area.direction.y
		elif area.position.x > (position.x + SIZE.x / 2) or area.position.x < (position.x - SIZE.x / 2):
			area.direction.x = -area.direction.x
		
		queue_free()
		destroyed.emit(value)

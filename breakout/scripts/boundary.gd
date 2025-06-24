extends Node


func _on_top_body_entered(body: Node2D) -> void:
	if body.name == "ball":
		body.direction.y = -body.direction.y

func _on_left_body_entered(body: Node2D) -> void:
	if body.name == "ball":
		body.direction.x = -body.direction.x

func _on_right_body_entered(body: Node2D) -> void:
	if body.name == "ball":
		body.direction.x = -body.direction.x

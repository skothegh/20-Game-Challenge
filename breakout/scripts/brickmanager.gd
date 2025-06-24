extends Node

@export var brick_scene: PackedScene

signal brick_destoyed(value)
signal level_complete

var number_of_bricks = 0

func _ready() -> void:
	#spawn_bricks()
	pass

func spawn_bricks():
	for x in range(10,610,30):
		for y in range(50,90,10):
			var brick = brick_scene.instantiate()
			brick.position = Vector2(x+15,y)
			brick.modulate = Color(0,0,1,1)
			brick.value = 1
			brick.add_to_group("bricks")
			number_of_bricks += 1
			
			add_child(brick)
			brick.destroyed.connect(on_brick_destroyed)
		
		for y in range(90,130,10):
			var brick = brick_scene.instantiate()
			brick.position = Vector2(x+15,y)
			brick.modulate = Color(0,1,1,1)
			brick.value = 1
			brick.add_to_group("bricks")
			number_of_bricks += 1
			
			add_child(brick)
			brick.destroyed.connect(on_brick_destroyed)
		
		for y in range(130,170,10):
			var brick = brick_scene.instantiate()
			brick.position = Vector2(x+15,y)
			brick.modulate = Color(0,1,0,1)
			brick.value = 1
			brick.add_to_group("bricks")
			number_of_bricks += 1
			
			add_child(brick)
			brick.destroyed.connect(on_brick_destroyed)
		
		for y in range(170,210,10):
			var brick = brick_scene.instantiate()
			brick.position = Vector2(x+15,y)
			brick.modulate = Color(1,1,0,1)
			brick.value = 1
			brick.add_to_group("bricks")
			number_of_bricks += 1
			
			add_child(brick)
			brick.destroyed.connect(on_brick_destroyed)
			
		for y in range(210,250,10):
			var brick = brick_scene.instantiate()
			brick.position = Vector2(x+15,y)
			brick.modulate = Color(1,0,0,1)
			brick.value = 1
			brick.add_to_group("bricks")
			number_of_bricks += 1
			
			add_child(brick)
			brick.destroyed.connect(on_brick_destroyed)
	

func on_brick_destroyed(value: int):
	number_of_bricks -= 1
	brick_destoyed.emit(value)
	if number_of_bricks == 0:
		level_complete.emit()

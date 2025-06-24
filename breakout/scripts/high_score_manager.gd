extends Control

@onready var label_container: Control = $LabelContainer
@onready var name_input: LineEdit = $NameInput

signal input_done

var pending_index = -1
var pending_score = 0
var scores: Array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	name_input.max_length = 5
	load_scores()
	update_display()
	name_input.hide()
	label_container.hide()
	name_input.text_submitted.connect(on_name_entered)

	
func on_game_over(score: int):
	for i in range(10):
		if score > scores[i].points:
			pending_index = i
			pending_score = score
			break
			
	if pending_index != -1:
		var ScoreBox: HBoxContainer = label_container.get_node("Score%d" % pending_index)
		var NameLabel = ScoreBox.get_node("NameLabel%d" % pending_index)
		var ScoreLabel = ScoreBox.get_node("ScoreLabel%d" % pending_index)
		
		NameLabel.text = str(pending_index) + " _____ " 
		ScoreLabel.text = str(pending_score)
	
		name_input.show()
		name_input.text = ""
		name_input.grab_focus()

func on_name_entered(new_name: String):
	var entry = {"name": new_name, "points": pending_score}
	scores[pending_index] = entry
	save_scores()
	update_display()
	name_input.hide()
	input_done.emit() # ensure main makes the "restart" button appear
	
func update_display():
	for i in range(10):
		var ScoreBox = label_container.get_node("Score%d" % i)
		var NameLabel = ScoreBox.get_node("NameLabel%d" % i)
		var ScoreLabel = ScoreBox.get_node("ScoreLabel%d" % i)
		
		NameLabel.text = str(i+1) + ". " + scores[i].name
		ScoreLabel.text = str(scores[i].points)
		

func save_scores() -> void:
	if FileAccess.file_exists("res://highscores.json"):
		var file = FileAccess.open("res://highscores.json", FileAccess.WRITE)
		file.store_string(JSON.stringify(scores))
		file.close()
		

func load_scores() -> void:
	if FileAccess.file_exists("res://highscores.json"):
		var file = FileAccess.open("res://highscores.json", FileAccess.READ)
		var text = file.get_as_text()
		file.close()
		
		scores = JSON.parse_string(text)

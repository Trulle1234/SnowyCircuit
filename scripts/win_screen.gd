extends CenterContainer

@onready var label: Label = $VBoxContainer/Label
@onready var tap: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var restart: Button = $VBoxContainer/RestartButton

const BASE_TEXT = """
You Have Compleated this small game. 
Thank you loads for playing! 
Here are your stats:
"""

func _ready() -> void:
	restart.hide()
	
	var text = get_text(BASE_TEXT)
	
	for i in range(len(text)):
		label.text += text[i]
		tap.pitch_scale = randf_range(0.7, 1.5)
		tap.play()
		await get_tree().create_timer(0.05).timeout
	
	tap.play()
	restart.show()
	
func get_text(base_text):
	var text = (
		base_text + "\n"
		+ "Coins: " + str(GameManager.coins) + "\n\n"
		+ "Level times:\n"
		+ get_level_times()
	)
	
	return text

func get_level_times(level_times=GameManager.level_times):
	var string = ""
	
	for i in range(len(level_times)):
		string += ("Level " + str(i + 1) + ": "
			+ level_times[i] + "\n"
		)
	return string
	
func _on_restart_button_pressed() -> void:
	tap.play()
	await tap.finished
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")

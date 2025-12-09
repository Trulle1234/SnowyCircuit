extends Node2D

@onready var label: Label = $Label
@onready var tap: AudioStreamPlayer2D = $AudioStreamPlayer2D

const BASE_TEXT = """
You Have Compleated this small game. 
Thank you loads for playing! 
Here are your stats:
"""
	
func _ready() -> void:
	var text = get_text(BASE_TEXT)
	
	for i in range(len(text)):
		label.text += text[i]
		tap.pitch_scale = randf_range(0.5, 1.5)
		tap.play()
		await wait(0.05)

func get_text(base_text):
	var text = (
		base_text + "\n"
		+ "Coins: " + str(GameManager.coins) + "\n\n"
		+ "Times:\n"
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

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

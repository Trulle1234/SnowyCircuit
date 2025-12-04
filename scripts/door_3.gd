extends Node2D

@onready var animation_player = $AnimationPlayer

func _on_button_1_off() -> void:
	animation_player.play("door3_close")

func _on_button_1_on() -> void:
	animation_player.play("door3_open")

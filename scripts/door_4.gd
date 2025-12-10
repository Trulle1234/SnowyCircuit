extends Node2D

@onready var animation_player = $AnimationPlayer

func _on_button_2_on() -> void:
	animation_player.play("door1_open")

func _on_button_2_off() -> void:
	animation_player.play("door1_close")

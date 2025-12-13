extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_bear_start_sequence_done() -> void:
	animation_player.play("door1_close")

extends Area2D

@onready var ui: CanvasLayer = $%UI
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@warning_ignore("unused_parameter")
func _on_body_entered(body: Node2D) -> void:
	ui.update_coins(1)
	animation_player.play("pickup")

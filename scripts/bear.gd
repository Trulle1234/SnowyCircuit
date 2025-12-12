extends Node2D

@onready var anim_tree = $AnimationTree

func _ready() -> void:
	await get_tree().create_timer(3).timeout
	anim_tree.set("parameters/conditions/sleep", false)

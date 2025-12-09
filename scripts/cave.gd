extends Area2D

func _on_body_entered(body: Node2D) -> void:
	body.get_node("AnimatedSprite2D").material.set_shader_parameter("active", true)

func _on_body_exited(body: Node2D) -> void:
	if not body.is_dead:
		body.get_node("AnimatedSprite2D").material.set_shader_parameter("active", false)

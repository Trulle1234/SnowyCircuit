extends Area2D

@onready var timer: Timer = $Timer
@onready var death_sound: AudioStreamPlayer2D = $DeathSound

func _on_body_entered(body: Node2D) -> void:
	body.is_dead = true
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	body.get_node("AnimatedSprite2D").play("hurt")
	death_sound.play()
	timer.start()
	
func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()

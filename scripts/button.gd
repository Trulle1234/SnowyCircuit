extends Area2D

@onready var sprite: AnimatedSprite2D = $StaticBody2D/AnimatedSprite2D

@onready var collision_shape_on: CollisionShape2D = $StaticBody2D/CollisionShapeOn
@onready var collision_shape_off: CollisionShape2D = $StaticBody2D/CollisionShapeOff

signal on
signal off

var is_on: bool = false

var in_range: bool = false 

func _on_body_entered(_body: Node2D) -> void:
	in_range = true

func _on_body_exited(_body: Node2D) -> void:
	in_range = false
	
func _process(_delta: float) -> void:
	if in_range and Input.is_action_just_pressed("crouch"):
		is_on = !is_on
		
		if is_on:
			sprite.play("on")

			collision_shape_on.set_deferred("disabled", false)
			collision_shape_off.set_deferred("disabled", true)
			emit_signal("on")

		else:
			sprite.play("off")

			collision_shape_on.set_deferred("disabled", true)
			collision_shape_off.set_deferred("disabled", false)
			emit_signal("off")

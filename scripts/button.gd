extends Area2D

@onready var sprite: AnimatedSprite2D = $StaticBody2D/AnimatedSprite2D

@onready var collision_shape_on: CollisionShape2D = $StaticBody2D/CollisionShapeOn
@onready var collision_shape_off: CollisionShape2D = $StaticBody2D/CollisionShapeOff
@onready var collision_shape_on_body: CollisionShape2D = $CollisionShapeOn
@onready var collision_shape_off_body: CollisionShape2D = $CollisionShapeOff

var is_on := false

func _on_body_entered(_body: Node2D) -> void:
	is_on = !is_on
	
	if is_on:
		sprite.play("on")

		collision_shape_on.set_deferred("disabled", false)
		collision_shape_on_body.set_deferred("disabled", false)

		collision_shape_off.set_deferred("disabled", true)
		collision_shape_off_body.set_deferred("disabled", true)
	else:
		sprite.play("off")

		collision_shape_off.set_deferred("disabled", false)
		collision_shape_off_body.set_deferred("disabled", false)

		collision_shape_on.set_deferred("disabled", true)
		collision_shape_on_body.set_deferred("disabled", true)

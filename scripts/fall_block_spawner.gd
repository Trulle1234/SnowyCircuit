extends Area2D

@onready var shape = $CollisionShape2D.shape as RectangleShape2D
const FALL_BLOCK = preload("uid://q7b5vjywx2sn")

var pos_buffer_amount = 64
var pos_buffer = Vector2()

func _ready():
	add_to_group("fall_block_spawner")

func get_random_cord() -> Vector2:
	var extents = shape.extents
	var local_pos = Vector2(
		randf_range(0, extents.x * 2),
		randf_range(-extents.y, extents.y)
	)
	
	while local_pos.x in range(local_pos.x - pos_buffer_amount, local_pos.x + pos_buffer_amount):
		local_pos = Vector2(
			randf_range(0, extents.x * 2),
			randf_range(-extents.y, extents.y)
		)
	
	return global_position + local_pos

func spawn(amount: int) -> void:
	for i in range(amount):
		var instance = FALL_BLOCK.instantiate()
		instance.global_position = get_random_cord()
		get_tree().current_scene.add_child(instance)

func _on_bear_spawn_blocks() -> void:
	spawn(5)

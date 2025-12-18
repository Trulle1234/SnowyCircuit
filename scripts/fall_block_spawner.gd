extends Area2D

@onready var col = $CollisionShape2D
@onready var shape = col.shape as RectangleShape2D
const FALL_BLOCK = preload("uid://q7b5vjywx2sn")

var pos_buffer_amount = 32.0
var pos_buffer = Vector2.ZERO
var has_pos_buffer = false

func _ready() -> void:
	add_to_group("fall_block_spawner")
	assert(shape != null)

func get_random_cord() -> Vector2:
	var extents = shape.extents

	var local_pos := Vector2(
		randf_range(-extents.x, extents.x),
		randf_range(-extents.y, extents.y)
	)

	var tries = 0
	while has_pos_buffer and abs(local_pos.x - pos_buffer.x) < pos_buffer_amount and tries < 50:
		local_pos.x = randf_range(-extents.x, extents.x)
		tries += 1

	pos_buffer = local_pos
	has_pos_buffer = true

	var world_pos = to_global(col.position + local_pos)
	return world_pos.snapped(Vector2(16, 16))

func spawn(amount: int) -> void:
	for i in range(amount):
		var instance = FALL_BLOCK.instantiate()
		instance.global_position = get_random_cord()
		get_tree().current_scene.add_child(instance)

func _on_bear_spawn_blocks() -> void:
	spawn(8)

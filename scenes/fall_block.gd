extends RigidBody2D

@onready var ray_cast: RayCast2D = $RayCast2D

@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var killzone: Area2D = $Killzone

var draw_indicator = true

func _integrate_forces(state):
	var dt = state.step
	state.linear_velocity *= (1.0 - 0.75 * dt)
	
func _process(_delta: float) -> void:
	queue_redraw()

	if ray_cast.is_colliding():
		var dist := ray_cast.global_position.distance_to(ray_cast.get_collision_point())
		if dist <= 16.0:
			if killzone:
				killzone.queue_free()
			if timer.is_stopped():
				timer.start()

func _draw() -> void:
	if draw_indicator:
		var a = ray_cast.global_position
		var b = null
		
		if ray_cast.is_colliding():
			b = ray_cast.get_collision_point()
		else:
			b = ray_cast.global_position + ray_cast.target_position
		
		draw_line(to_local(a), to_local(b), Color("1b141ef5"), 16.0)

func _on_timer_timeout() -> void:
	z_index = -1
	draw_indicator = false
	if collision_shape_2d:
		collision_shape_2d.queue_free()

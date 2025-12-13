extends CharacterBody2D

const BASE_SPEED = 130.0
const CROUCH_SPEED = 1.0
const SLOW_SPEED = 60
const JUMP_VELOCITY = -300.0
const GRAVITY = Vector2(0, 980.0)
const KNOCKBACK_DURATION = 0.30

var speed = BASE_SPEED
var slow = false

var knockback_time = 0.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var coyote_timer: Timer = $CoyoteTimer
var coyote_time_active: bool = false

@onready var jump_buffer_timer: Timer = $JumpBufferTimer

var is_dead: bool = false

func _ready() -> void:
	animated_sprite.material.set_shader_parameter("active", false)
		
	if slow:
		speed = SLOW_SPEED
		
func _physics_process(delta: float) -> void:
	knockback_time = maxf(knockback_time - delta, 0.0)
	
	if not is_on_floor():
		velocity += GRAVITY * delta

	var direction := Input.get_axis("left", "right")
	
	if not is_dead:
		if direction != 0:
			GameManager.has_moved = true
		
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
		
		if is_on_floor():
			if Input.is_action_pressed("crouch"):
				animated_sprite.play("crouch")
				
				speed = CROUCH_SPEED
				position.y += 3
				
			else:
				if slow:
					speed = SLOW_SPEED
				else:
					speed = BASE_SPEED
				
				if direction == 0:
					animated_sprite.play("idle")
				
				else:
					animated_sprite.play("run")
			
			if coyote_time_active:
				coyote_time_active = false
				coyote_timer.stop()
		else:
			if Input.is_action_pressed("crouch"):
				animated_sprite.play("crouch")
				
				speed = CROUCH_SPEED
				position.y += 1
			else:
				if not coyote_time_active:
					coyote_timer.start()
					coyote_time_active = true
				animated_sprite.play("jump")
		
		if Input.is_action_just_pressed("jump"):
			jump_buffer_timer.start()
			
		if not jump_buffer_timer.is_stopped() and (not coyote_timer.is_stopped() or is_on_floor()):
			velocity.y = JUMP_VELOCITY
			coyote_timer.stop()
			coyote_time_active = true

		if knockback_time <= 0.0:
			if direction:
				velocity.x = direction * speed
			else:
				velocity.x = move_toward(velocity.x, 0, speed)
		else:
			velocity.x = move_toward(velocity.x, 0, 800 * delta)

		move_and_slide()

func apply_knockback(from_position: Vector2, strength_x, strength_y) -> void:
	var dir: float = sign(global_position.x - from_position.x)
	if dir == 0:
		dir = 1

	velocity.x = dir * strength_x
	velocity.y = -strength_y
	knockback_time = KNOCKBACK_DURATION

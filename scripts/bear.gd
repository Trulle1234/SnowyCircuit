extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var awake = false

var snoring = preload("res://assets/sfx/snoring.wav")
var roar = preload("res://assets/sfx/roar.wav")

signal start_sequence_done

func _ready() -> void:
	RandomMusicPlayer.play_fast_tracks = false
	RandomMusicPlayer.player.stop()
	RandomMusicPlayer.play_random_track(RandomMusicPlayer.calm_tracks)
	
	audio_player.stream = snoring
	audio_player.play()
	sprite.play("sleep")
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if awake:
		return

	awake = true

	audio_player.stop()

	sprite.play("wake_up")
	await sprite.animation_finished
	
	audio_player.stream = roar
	audio_player.play()
		
	RandomMusicPlayer.play_fast_tracks = true
	RandomMusicPlayer.player.stop()
	RandomMusicPlayer.play_random_track(RandomMusicPlayer.fast_tracks)
	
	body.slow = false
	get_tree().get_root().get_node("Level10/Slowzone/CollisionShape2D").set_deferred("disabled", true)
	
	body.apply_knockback(global_position, 800.0, 400.0)
	
	sprite.play("attack")
	await sprite.animation_finished
	
	emit_signal("start_sequence_done")
	
	sprite.play("idle")

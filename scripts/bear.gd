extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var awake = false

func _ready() -> void:
	RandomMusicPlayer.play_fast_tracks = false
	RandomMusicPlayer.player.stop()
	RandomMusicPlayer.play_random_track(RandomMusicPlayer.calm_tracks)
	
	audio_player.play()
	sprite.play("sleep")
	
func _on_area_2d_body_entered(body: Node2D) -> void:	
	if !awake:
		body.slow = false
		get_tree().get_root().get_node("Level10/Slowzone/CollisionShape2D").set_deferred("disabled", true)
		
		RandomMusicPlayer.play_fast_tracks = true
		RandomMusicPlayer.player.stop()
		RandomMusicPlayer.play_random_track(RandomMusicPlayer.fast_tracks)
			
		audio_player.stop()
		
		sprite.play("wake_up")
		
		awake = true

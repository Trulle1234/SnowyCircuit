extends Node

var coins: int = 0
var start_coins: int = 0

var has_moved = false

var fullscreen = false
var show_mouse = false

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if Input.is_anything_pressed():
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	if Input.is_action_just_pressed("fullscreen"):
		fullscreen = !fullscreen
		
		if fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func reset():
	coins = start_coins
	has_moved = false
	
func set_start_coins(value):
	start_coins = value

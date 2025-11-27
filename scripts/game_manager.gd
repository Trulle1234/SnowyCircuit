extends Node

var coins: int = 0
var start_coins: int = 0

var has_moved = false

func reset():
	coins = start_coins
	has_moved = false
	
func set_start_coins(value):
	start_coins = value

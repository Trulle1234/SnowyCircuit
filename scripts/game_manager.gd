extends Node

var coins: int = 0
var start_coins: int = 0

func reset():
	coins = start_coins
	
func set_start_coins(value):
	start_coins = value

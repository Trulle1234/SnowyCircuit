extends CanvasLayer

@onready var label: Label = %Label

var coins: int = 0

func _ready():
	coins = GameManager.coins
	update_coins_label()

func update_coins(value):
	coins += value
	GameManager.coins = coins
	update_coins_label()

func update_coins_label():
	label.text = str(coins)

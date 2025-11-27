extends MarginContainer

@onready var timer: Timer = $Timer
@onready var label: Label = $Label

var total_cs: int = 0

func _on_timer_timeout() -> void:
	if GameManager.has_moved:
		total_cs += 1

		@warning_ignore("integer_division")
		var minutes = total_cs / 6000
		@warning_ignore("integer_division")
		var seconds = (total_cs / 100) % 60
		@warning_ignore("integer_division")
		var tenths = (total_cs % 100) / 10

		label.text = "%02d:%02d.%01d" % [minutes, seconds, tenths]

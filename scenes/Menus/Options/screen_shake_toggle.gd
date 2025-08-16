extends CheckButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_pressed = GlobalSettings.is_screen_shake_enabled

func _on_toggled(toggled_on: bool) -> void:
	GlobalSettings.set_screen_shake(toggled_on)

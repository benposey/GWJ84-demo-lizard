extends Control

func _ready() -> void:
	Events.menus.paused.connect(_on_pause_button_pressed)

func _on_pause_button_pressed():
	show()
	get_tree().paused = true
	

func _on_unpause_pressed() -> void:
	hide()
	get_tree().paused = false

extends Control

@onready var options_menu: Control = $OptionsMenu

func _ready() -> void:
	options_menu.hide()
	Events.menus.paused.connect(_on_pause_button_pressed)

func _on_pause_button_pressed():
	show()
	get_tree().paused = true
	

func _on_unpause_pressed() -> void:
	hide()
	get_tree().paused = false


func _on_options_button_pressed() -> void:
	options_menu.show()

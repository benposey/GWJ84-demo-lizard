extends Control

@onready var options_menu: Control = $OptionsMenu

func _ready() -> void:
	options_menu.hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("back"):
		options_menu.hide()
	
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Cutscenes/exposition_scene.tscn")
	

func _on_options_button_pressed() -> void:
	options_menu.show()

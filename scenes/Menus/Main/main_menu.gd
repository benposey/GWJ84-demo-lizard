extends Control

@onready var play_button: Button = $VBoxContainer/ButtonsContainer/PlayButton

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Warehouse/Warehouse.tscn")
	

extends Node2D

func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()


func _on_pause_button_pressed() -> void:
	Events.menus.paused.emit()

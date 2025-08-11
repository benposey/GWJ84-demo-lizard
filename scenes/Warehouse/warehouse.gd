extends Node2D

func _input(event):
	if event.is_action_pressed("detonate"):
		for box in get_tree().get_nodes_in_group("destructable"):
			await get_tree().create_timer(1.0).timeout
			if box is Box:
				box.destroy()
	
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()


func _on_pause_button_pressed() -> void:
	Events.menus.paused.emit()

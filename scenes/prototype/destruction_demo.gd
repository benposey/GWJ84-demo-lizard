extends Node2D


@onready var objects: Node2D = $Objects

func _input(event):
	if event.is_action_pressed("detonate"):
		for box in get_tree().get_nodes_in_group("destructable"):
			if box is Box:
				box.destroy()
	
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

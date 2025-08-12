extends Node2D

@onready var object_holder: Node = $ObjectHolder
@onready var child_count = object_holder.get_child_count()
@onready var total_object_destroyed_count = 0

func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func _on_pause_button_pressed() -> void:
	Events.menus.paused.emit()

func _ready() -> void:
	Events.objects.object_destroyed.connect(_on_object_destroyed)
	

func _on_object_destroyed(point_value: int, spawn_position: Vector2) -> void:
	total_object_destroyed_count += 1	
	if total_object_destroyed_count == child_count:
		Events.level.level_ended.emit()
		print("level ended")

extends Node2D
@onready var combo_bar: ProgressBar = $FixedUI/ComboBar

const DEFAULT_COMBO = 1
const MAX_TIME_SEC = 5.0

func _ready() -> void:
	Events.objects.object_destroyed.connect(_on_object_destroyed)

func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func _on_object_destroyed(_point_value, _position):
	var time_remaining = combo_bar.time_left
	combo_bar.start(min(time_remaining + 1.5, MAX_TIME_SEC))
	

func _on_pause_button_pressed() -> void:
	Events.menus.paused.emit()

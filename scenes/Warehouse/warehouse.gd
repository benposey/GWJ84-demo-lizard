extends Node2D
@onready var combo_bar: ProgressBar = $FixedUI/ComboBar
@onready var total_object_destroyed_count = 0

const DEFAULT_COMBO = 1

func _ready() -> void:
	Events.objects.object_destroyed.connect(_on_object_destroyed)


func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()


func _on_object_destroyed(_point_value, _position):
	# Update Combo Bar
	var time_remaining = combo_bar.time_left
	combo_bar.start(time_remaining + 1.5)
	
	# Check level ending conditions
	#total_object_destroyed_count += 1	
	#if total_object_destroyed_count == child_count:
		#Events.level.level_ended.emit()
		#print("level ended")
	

func _on_pause_button_pressed() -> void:
	Events.menus.paused.emit()
	

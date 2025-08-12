extends Node2D
@onready var combo_bar: ProgressBar = $FixedUI/ComboBar
@onready var combo_timer: Timer = $FixedUI/ComboTimer

const DEFAULT_COMBO = 1

func _process(delta: float) -> void:
	combo_bar.value = combo_timer.time_left

func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func _on_pause_button_pressed() -> void:
	Events.menus.paused.emit()
	
func _on_combo_timer_expired() -> void:
	Events.combos.combo_changed.emit(DEFAULT_COMBO)

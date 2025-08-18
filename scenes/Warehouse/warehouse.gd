extends Node2D
@onready var combo_bar: ProgressBar = $FixedUI/ComboBar
@onready var stopwatch: Stopwatch = $FixedUI/Stopwatch
@onready var spawnables: TileMapLayer = $LayerHolder/Spawnables
@onready var point_counter: RichTextLabel = $FixedUI/PointCounter
@onready var eol_countdown: EOLCountdown = $FixedUI/EOLCountdown
@onready var objective_tracker: Label = $FixedUI/ObjectiveTracker
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


var objective_count = 0
var total_object_destroyed_count = 0
var objective_items_destroyed = 0
var horses_collected


const DEFAULT_COMBO = 1
var test = 0


func _ready() -> void:
	Events.objects.object_destroyed.connect(_on_object_destroyed)
	Events.objects.objective_item_destroyed.connect(_on_objective_item_destroyed)
	Events.level.level_end_countdown_completed.connect(_on_level_ended_timer_expired)
	await get_tree().process_frame
	
	# Allow mulitple lizard cages to be spawned without knowing where/manually placing them
	for child in spawnables.get_children():
		if child is Cage:
			objective_count += 1
	objective_tracker.set_required_objectives(objective_count)


func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()


func _on_object_destroyed(_point_value, _position):
	# Update Combo Bar
	var time_remaining = combo_bar.time_left
	combo_bar.start(time_remaining + ComboManager.Combo_IncreaseRate)
	total_object_destroyed_count += 1


func _on_player_enter_game_area() -> void:
	# game has started 
	stopwatch.start()


func _on_pause_button_pressed() -> void:
	Events.menus.paused.emit()


func _on_objective_item_destroyed() -> void:
	objective_items_destroyed += 1
	if objective_items_destroyed == objective_count:
		stopwatch.stop()
		eol_countdown.show()
		eol_countdown.start()


func _on_level_ended_timer_expired() -> void:
	stopwatch.hide()
	eol_countdown.stop()
	eol_countdown.hide()
	audio_stream_player.stop()
	Events.level.level_ended.emit(point_counter.current_points, stopwatch.timer, total_object_destroyed_count)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Events.level.player_entered_game_area.emit()
		stopwatch.start()

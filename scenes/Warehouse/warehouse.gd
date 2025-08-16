extends Node2D
@onready var combo_bar: ProgressBar = $FixedUI/ComboBar
@onready var stopwatch: Stopwatch = $FixedUI/Stopwatch
@onready var spawnables: TileMapLayer = $LayerHolder/Spawnables
@onready var point_counter: RichTextLabel = $FixedUI/PointCounter
@onready var main_objective_items: Node2D = $MainObjectiveItems

var destroyable_count = 0
var objective_count = 0
var total_object_destroyed_count = 0
var objective_items_destroyed = 0


const DEFAULT_COMBO = 1
var test = 0


func _ready() -> void:
	Events.objects.object_destroyed.connect(_on_object_destroyed)
	Events.objects.objective_item_destroyed.connect(_on_objective_item_destroyed)
	await get_tree().process_frame
	destroyable_count = spawnables.get_child_count()
	objective_count = main_objective_items.get_child_count()	


func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func _on_object_destroyed(_point_value, _position):
	stopwatch.start()
	# Update Combo Bar
	var time_remaining = combo_bar.time_left
	combo_bar.start(time_remaining + ComboManager.Combo_IncreaseRate)
	
	total_object_destroyed_count += 1
	

func _on_pause_button_pressed() -> void:
	Events.menus.paused.emit()


func _on_objective_item_destroyed() -> void:
	objective_items_destroyed += 1
	if objective_items_destroyed == objective_count:
		stopwatch.stop()
		stopwatch.hide()
		Events.level.level_ended.emit(point_counter.current_points, stopwatch.timer, total_object_destroyed_count) 
	

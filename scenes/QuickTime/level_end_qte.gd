extends Node2D

@onready var red_button: AnimatedSprite2D = $RedButton
@onready var lizard_qte: AnimatedSprite2D = $LizardQTE
@onready var lizard_sound: AudioStreamPlayer = $lizardSound
@onready var qte_timer: Timer = $QTE_Timer
@onready var instructions: RichTextLabel = $Instructions

var level_completion_time_sec = 0.0
var level_completion_objects_destroyed = 0
var player_score = 0

var buttonPressCount = 0
var quickEventTime = 5.0 #seconds
var incrementRate = 0.1
var qte_multiplier = 0.0

#todo implement quick time event popping up and timer starting
#func EndOfLevelTrigger(event):
	#display QTEd
	#var quickTimeEventTimer = get_tree().create_timer(quickEventTime)

func _on_end_of_level(score: int, level_complete_time_sec: float, objects_destoryed: int):
	# passthrough variables for end game statistics 
	player_score = score
	level_completion_time_sec = level_complete_time_sec
	level_completion_objects_destroyed = objects_destoryed
	
	# QTE logic
	self.show()	
	instructions.show()
	await get_tree().create_timer(3.0).timeout
	instructions.hide()
	buttonPressCount = 1
	qte_timer.start()
	await qte_timer.timeout
	
func _input(event):
	if event.is_action_pressed("detonate"):
		lizard_qte.play("LizardJump")
		red_button.play("RedButtonPressed")
		lizard_qte.speed_scale = buttonPressCount
		red_button.speed_scale = buttonPressCount
		buttonPressCount += incrementRate
		lizard_sound.play()
		
		qte_multiplier = 50.0 #todo increment score multiplier

func _ready():
	#listen for timer end signal
	Events.level.level_ended.connect(_on_end_of_level)
	

func _on_qte_timer_timeout() -> void:	
	Events.level.qte_ended.emit(player_score, level_completion_time_sec, level_completion_objects_destroyed, qte_multiplier)
	get_tree().change_scene_to_file("res://scenes/Summary/EndGameSummary.tscn")

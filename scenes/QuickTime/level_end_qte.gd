extends Node2D

@onready var red_button: AnimatedSprite2D = $RedButton
@onready var lizard_qte: AnimatedSprite2D = $LizardQTE
@onready var lizard_sound: AudioStreamPlayer = $lizardSound
@onready var qte_timer: Timer = $QTE_Timer
@onready var instructions: RichTextLabel = $Instructions
@onready var time_bar_for_qte: ProgressBar = $time_bar_for_qte
@onready var qte_multiplier_text: RichTextLabel = $QTE_multiplier_text

#const TEXT_FORMAT = "[shake rate=%d level=%d connected=1][color=%s]%s[/color][shake] "

var level_completion_time_sec = 0.0
var level_completion_objects_destroyed = 0
var player_score = 0
var button_press_count = 0.0
var incrementRate = 0.1
var qte_multiplier = 0.0
#var color_weight = 0.0

#var white = Color(1,1,1,1)
#var crimson = Color(0.862745, 0.0784314, 0.235294, 1)

func _process(delta: float) -> void:
	time_bar_for_qte.value = qte_timer.time_left
	print("time_bar_for_qte ", time_bar_for_qte.value)

func _on_end_of_level(score: int, level_complete_time_sec: float, objects_destoryed: int):
	AudioManager.start_qte()
	# passthrough variables for end game statistics 
	player_score = score
	level_completion_time_sec = level_complete_time_sec
	level_completion_objects_destroyed = objects_destoryed
	
	# QTE logic
	self.show()	
	instructions.show()
	await get_tree().create_timer(1.0).timeout
	instructions.hide()
	qte_multiplier_text.show()
	button_press_count = 1.0
	qte_timer.start()
	qte_multiplier_text.text = "10x"
	
	#todo add shake juice
	#todo add color juice, figure out LERP not working
	
func _input(event):
	if event.is_action_pressed("detonate"):
		lizard_qte.play("LizardJump")
		red_button.play("RedButtonPressed")
		lizard_qte.speed_scale = button_press_count
		red_button.speed_scale = button_press_count
		button_press_count += incrementRate
		lizard_sound.play()		
		qte_multiplier = 10*button_press_count
		#color_weight = button_press_count/10
		#color_weight = clampf(button_press_count, 0.0, 1.0)
		#qte_multiplier_text.push_color(white.lerp(crimson, color_weight))
		#qte_multiplier_text.pop()
		qte_multiplier_text.text = str(qte_multiplier) + "x"
		
func _ready():
	#listen for timer end signal
	Events.level.level_ended.connect(_on_end_of_level)
	qte_multiplier_text.hide()
	

func _on_qte_timer_timeout() -> void:	
	Events.level.qte_ended.emit(player_score, level_completion_time_sec, level_completion_objects_destroyed, qte_multiplier)
	get_tree().change_scene_to_file("res://scenes/Summary/EndGameSummary.tscn")

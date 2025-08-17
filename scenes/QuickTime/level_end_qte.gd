extends Node2D

@onready var red_button: AnimatedSprite2D = $RedButton
@onready var lizard_qte: AnimatedSprite2D = $LizardQTE
@onready var lizard_sound: AudioStreamPlayer = $lizardSound
@onready var qte_timer: Timer = $QTE_Timer
@onready var instructions: RichTextLabel = $Instructions
@onready var time_bar_for_qte: ProgressBar = $time_bar_for_qte
@onready var qte_multiplier_text: RichTextLabel = $QTE_multiplier_text

const TEXT_FORMAT = "[shake rate=%f level=%d connected=1][color=%s]%dx[/color][/shake]"

var level_completion_time_sec = 0.0
var level_completion_objects_destroyed = 0
var player_score = 0
var button_press_count = 0.0
var incrementRate = 0.1
var qte_multiplier = 0.0



func _process(delta: float) -> void:
	time_bar_for_qte.value = qte_timer.time_left


func _on_end_of_level(score: int, level_complete_time_sec: float, objects_destoryed: int):
	AudioManager.start_qte()
	# passthrough variables for end game statistics 
	player_score = score
	level_completion_time_sec = level_complete_time_sec
	level_completion_objects_destroyed = objects_destoryed
	
	# QTE logic
	self.show()	
	instructions.show()
	await get_tree().create_timer(2.0).timeout
	instructions.hide()
	qte_multiplier_text.show()
	button_press_count = 1.0
	qte_timer.start()
	qte_multiplier_text.text = "10x"
	
	
func _input(event):
	if event.is_action_pressed("detonate"):
		lizard_qte.play("LizardJump")
		red_button.play("RedButtonPressed")
		lizard_qte.speed_scale = button_press_count
		red_button.speed_scale = button_press_count
		button_press_count += incrementRate
		lizard_sound.play()
		qte_multiplier = ceil(10*button_press_count)
		
		var color_weight = clampf(button_press_count/10, 0.0, 1.0)
		var interpolated_color = Color.WHITE.lerp(Color.CRIMSON, color_weight)
		
		var shake_rate = lerp(0.0, 20.0, button_press_count/5.0)
		var shake_level = button_press_count*2
		qte_multiplier_text.text = TEXT_FORMAT % [shake_rate, shake_level, interpolated_color.to_html(), qte_multiplier]
		
func _ready():
	#listen for timer end signal
	Events.level.level_ended.connect(_on_end_of_level)
	qte_multiplier_text.hide()
	

func _on_qte_timer_timeout() -> void:	
	Events.level.qte_ended.emit(player_score, level_completion_time_sec, level_completion_objects_destroyed, qte_multiplier)
	get_tree().change_scene_to_file("res://scenes/Summary/EndGameSummary.tscn")

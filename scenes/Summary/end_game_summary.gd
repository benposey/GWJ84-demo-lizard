extends Control
@onready var score_label: RichTextLabel = $StatElements/ScoreLabel
@onready var rank_label: RichTextLabel = $StatElements/Rank
@onready var time_lable: RichTextLabel = $StatElements/Time
@onready var qte_multiplier_label: RichTextLabel = $StatElements/QTEMultiplier
@onready var objects_destroyed_count_label: RichTextLabel = $StatElements/ObjectDestroyedCount
@onready var horses_found_label: RichTextLabel = $StatElements/HorsesFound

var score := 0
var time := 0.0
var qte_multiplier := 0.0
var objects_destroyed := 0
var horses_found := 0

func _ready() -> void:
	AudioManager.sfx_play()
	score = GameStats.Stats_Score
	score_label.text = "SCORE: %s" % score
	
	time = GameStats.Stats_Time
	time_lable.text =  String.num(time, 3)
	
	qte_multiplier = GameStats.Stats_QTE_Multiplier
	qte_multiplier_label.text = "%sx" % str(qte_multiplier)
	
	objects_destroyed = GameStats.Stats_Objects_Destroyed
	objects_destroyed_count_label.text = str(objects_destroyed)
	
	horses_found = GameStats.Stats_Horses_Found
	horses_found_label.text = str(horses_found)
	

func _on_main_menu_button_pressed() -> void:
	AudioManager.music_play("Intro")
	get_tree().change_scene_to_file("res://scenes/Menus/Main/main_menu.tscn")

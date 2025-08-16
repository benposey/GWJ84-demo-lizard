extends Control
@onready var final_score_label: RichTextLabel = $StatElements/FinalScore
@onready var rank_label: RichTextLabel = $StatElements/Rank
@onready var base_score_label: RichTextLabel = $StatElements/BaseScore
@onready var time_lable: RichTextLabel = $StatElements/Time
@onready var qte_multiplier_label: RichTextLabel = $StatElements/QTEMultiplier
@onready var objects_destroyed_count_label: RichTextLabel = $StatElements/ObjectDestroyedCount
@onready var horses_found_label: RichTextLabel = $StatElements/HorsesFound

# Ranks
const RANKING_BASELINE := 150000
const QUIET_CHAMELEON = "QUIET CHAMELEON"
const MUNDANE_MONITOR = "MUNDANE MONITOR"
const KILLER_KOMODO = "KILLER KOMODO"
const INCENDIARY_IGUANA = "INCENDIARY IGUANA"
const DEMO_LIZARD = "DEMO LIZARD"


func _ready() -> void:
	var final_score = GameStats.Stats_Score * GameStats.Stats_QTE_Multiplier
	
	AudioManager.sfx_play()
	final_score_label.text = "FINAL SCORE: %d" % final_score
	rank_label.text = assign_rank(final_score)
	base_score_label.text = "%s" % str(GameStats.Stats_Score)
	time_lable.text =  String.num(GameStats.Stats_Time, 3)
	qte_multiplier_label.text = "%dx" % GameStats.Stats_QTE_Multiplier
	objects_destroyed_count_label.text = str(GameStats.Stats_Objects_Destroyed)	
	horses_found_label.text = str(GameStats.Stats_Horses_Found)
	
	await get_tree().create_timer(3.0).timeout
	AudioManager.music_play("End")
	
func assign_rank(score) -> String:
	if score <= RANKING_BASELINE:
		# Lmao do better
		return QUIET_CHAMELEON 
	elif score <= RANKING_BASELINE*4:
		# alright
		return MUNDANE_MONITOR
	elif score <= RANKING_BASELINE*8:
		# gettin pretty good
		return KILLER_KOMODO
	elif score <= RANKING_BASELINE*12:
		# almost there
		return INCENDIARY_IGUANA
	else:
		# good job
		return DEMO_LIZARD

func _on_main_menu_button_pressed() -> void:
	AudioManager.music_play("Intro")
	get_tree().change_scene_to_file("res://scenes/Menus/Main/main_menu.tscn")

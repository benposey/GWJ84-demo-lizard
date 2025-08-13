extends Control

var score := 0
var time := 0.0
var qte_multiplier := 0.0
var objects_destroyed := 0
var horses_found := 0

func _ready() -> void:
	score = GameStats.Stats_Score
	time = GameStats.Stats_Time
	qte_multiplier = GameStats.Stats_QTE_Multiplier
	objects_destroyed = GameStats.Stats_Objects_Destroyed
	horses_found = GameStats.Stats_Horses_Found
	
	


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Menus/Main/main_menu.tscn")

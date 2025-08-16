extends Node

var Stats_Score := 0
var Stats_Time := 0.0
var Stats_Objects_Destroyed := 0
var Stats_QTE_Multiplier := 0.0
var Stats_Horses_Found := 0

func _ready() -> void:
	Events.level.qte_ended.connect(_on_qte_ended)
	
func _on_qte_ended(score:int, stopwatch_time_sec: float, objects_destroyed: int, qte_multiplier: float):
	preload("res://scenes/Summary/EndGameSummary.tscn").instantiate()
	Stats_Score = score
	Stats_Time = stopwatch_time_sec
	Stats_Objects_Destroyed = objects_destroyed
	Stats_QTE_Multiplier = qte_multiplier
	Stats_Horses_Found = 7 # TODO: Implement horsin' around

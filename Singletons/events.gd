extends Node

var objects = ObjectEvents.new()
var menus = MenuEvents.new()
var camera = CameraEvents.new()
var level = LevelEvents.new()
var combos = ComboEvents.new()

class ObjectEvents:
	signal object_destroyed(point_value: int, position:Vector2)

class MenuEvents:
	signal paused()

class CameraEvents:
	signal add_trauma(amount: float)

class LevelEvents:
	signal level_ended(score: int, stopwatch_time_sec: float, objects_destroyed: int)
	signal qte_ended(score:int, stopwatch_time_sec: float, objects_destroyed: int, qte_multiplier: float)

class ComboEvents:
	signal combo_bar_expired()
	signal combo_bar_maxed()
	signal combo_changed(new_combo: int)

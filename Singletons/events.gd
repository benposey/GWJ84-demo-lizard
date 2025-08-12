extends Node

var objects = ObjectEvents.new()
var menus = MenuEvents.new()
var level = LevelEvents.new()
var combos = ComboEvents.new()

class ObjectEvents:
	signal object_destroyed(point_value: int, position:Vector2)

class MenuEvents:
	signal paused()


class LevelEvents:
	signal level_ended()

	
class ComboEvents:
	signal combo_changed(new_combo: int)


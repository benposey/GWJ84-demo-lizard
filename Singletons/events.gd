extends Node

var objects = ObjectEvents.new()
var menus = MenuEvents.new()
var level = LevelEvents.new()

class ObjectEvents:
	signal object_destroyed(point_value, position)

class MenuEvents:
	signal paused()

class LevelEvents:
	signal level_ended()

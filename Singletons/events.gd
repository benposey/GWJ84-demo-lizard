extends Node

var objects = ObjectEvents.new()
var menus = MenuEvents.new()

class ObjectEvents:
	signal object_destroyed(point_value, position)

class MenuEvents:
	signal paused()

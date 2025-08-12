extends Node

var objects = ObjectEvents.new()
var menus = MenuEvents.new()
var camera = CameraEvents.new()

class ObjectEvents:
	signal object_destroyed(point_value, position)

class MenuEvents:
	signal paused()

class CameraEvents:
	signal add_trauma(amount)

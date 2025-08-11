extends Node

var objects = ObjectEvents.new()

class ObjectEvents:
	signal object_destroyed(point_value)

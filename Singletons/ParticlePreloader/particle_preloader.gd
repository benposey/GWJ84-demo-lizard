extends Node2D
@onready var box: Box = $Box

func _ready() -> void:
	box.destroy()

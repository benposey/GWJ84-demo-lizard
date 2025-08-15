extends Node2D
@onready var box: Box = $CanvasLayer/Box

func _ready() -> void:
	
	box.destroy()

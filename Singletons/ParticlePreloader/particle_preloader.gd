extends Node2D
@onready var box: Box = $CanvasLayer/Box
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect

func _ready() -> void:
	
	box.destroy()

extends Node

var Multiplier_To_Color = {
	1: "#FFF", # 1x = white
	2: "#AD8", # 2x = Lime-ish green
	4: "#B04609", # 4x = Orangeish 
	8: "#B22" # 8x = Red
}
var ComboMultiplier = 1


func _ready() -> void:
	Events.combos.combo_changed.connect(_on_combo_changed)

func _on_combo_changed(new_multiplier) -> void:
	ComboMultiplier = new_multiplier

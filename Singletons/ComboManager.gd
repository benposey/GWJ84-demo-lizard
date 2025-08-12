extends Node

const DEFAULT_COMBO = 1
const MAX_COMBO = 8

var Multiplier_To_Color = {
	1: "#FFF", # 1x = white
	2: "#AD8", # 2x = Lime-ish green
	4: "#B04609", # 4x = Orangeish 
	8: "#B22" # 8x = Red
}

var Multiplier_To_DecayRate = {
	1: 1.0,
	2: 1.25,
	4: 1.5,
	8: 2.0
}
var Combo_Multiplier = 1
var Combo_DecayRate = Multiplier_To_DecayRate[1]

func _ready() -> void:
	Events.objects.object_destroyed.connect(_on_object_destroyed)

func update_combo_multiplier(new_multiplier):
	Combo_Multiplier = new_multiplier
	Combo_DecayRate = Multiplier_To_DecayRate[Combo_Multiplier]
	# Engine.time_scale = Multiplier_To_DecayRate[Combo_Multiplier] TODO: This could be real fun
	Events.combos.combo_changed.emit(Combo_Multiplier)

func reset_combo():
	update_combo_multiplier(DEFAULT_COMBO)

func _on_object_destroyed(_point_value: int, _spawn_position: Vector2) -> void:
	update_combo_multiplier(min(Combo_Multiplier*2, MAX_COMBO))
	

extends Node

const DEFAULT_COMBO := 1
const MAX_COMBO := 8

var multiplier_attribute_map = {
	1: {
		"Color": "#FFF", # 1x = white
		"DecayRate": 1.0,
		"ShakeRate": 5.0,
		"ShakeLevel": 5,
		"IncreaseRate": 1.0,
		"PlayerSpeed": 100.0 
	},
	2: {
		"Color": "#AD8", # 2x = Lime-ish green
		"DecayRate": 1.25,
		"ShakeRate": 10.0,
		"ShakeLevel": 10,
		"IncreaseRate": .75,
		"PlayerSpeed": 125.0
	},
	4: {
		"Color": "#B04609", # 4x = Orangeish 
		"DecayRate": 1.5,
		"ShakeRate": 15.0,
		"ShakeLevel": 15,
		"IncreaseRate": .5,
		"PlayerSpeed": 150.0
	},
	8: {
		"Color": "#B22", # 8x = Red 
		"DecayRate": 2.0,
		"ShakeRate": 20.0,
		"ShakeLevel": 20,
		"IncreaseRate": .45,
		"PlayerSpeed": 200.0
	},
}

var Combo_Multiplier: int  = 1
var Combo_Color: String = multiplier_attribute_map[1]["Color"]
var Combo_DecayRate: float = multiplier_attribute_map[1]["DecayRate"]
var Combo_ShakeRate: float = multiplier_attribute_map[1]["ShakeRate"]
var Combo_ShakeLevel: int  = multiplier_attribute_map[1]["ShakeLevel"]
var Combo_IncreaseRate: float = multiplier_attribute_map[1]["IncreaseRate"]
var Combo_PlayerSpeed: float = multiplier_attribute_map[1]["PlayerSpeed"]

func _ready() -> void:
	Events.combos.combo_bar_maxed.connect(_on_combo_bar_maxed)
	Events.combos.combo_bar_expired.connect(_on_combo_bar_expired)

func update_combo_multiplier(new_multiplier: int) -> void:
	Combo_Multiplier = new_multiplier
	Combo_Color = multiplier_attribute_map[Combo_Multiplier]["Color"] 
	Combo_DecayRate = multiplier_attribute_map[Combo_Multiplier]["DecayRate"]
	Combo_ShakeRate = multiplier_attribute_map[Combo_Multiplier]["ShakeRate"]
	Combo_ShakeLevel = multiplier_attribute_map[Combo_Multiplier]["ShakeLevel"]
	Combo_IncreaseRate = multiplier_attribute_map[Combo_Multiplier]["IncreaseRate"]
	#Engine.time_scale = multiplier_attribute_map[Combo_Multiplier]["DecayRate"] # TODO: This could be real fun
	Combo_PlayerSpeed = multiplier_attribute_map[Combo_Multiplier]["PlayerSpeed"]
	Events.combos.combo_changed.emit(Combo_Multiplier)

func _on_combo_bar_expired() -> void:
	update_combo_multiplier(DEFAULT_COMBO)

func _on_combo_bar_maxed() -> void:
	update_combo_multiplier(min(Combo_Multiplier*2, MAX_COMBO))
	

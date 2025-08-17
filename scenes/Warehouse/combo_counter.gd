extends RichTextLabel
@onready var demo_lizard_audio: AudioStreamPlayer2D = $"../../Audio/DemoLizardAudio"
@onready var high_combo: ColorRect = $"../HighCombo"


const TEXT_FORMAT = "[shake rate=%f level=%d connected=1][color=%s]%s[/color][shake] "


var current_combo = 1


func _ready() -> void:
	self.text = str(current_combo) + "x"
	Events.combos.combo_changed.connect(_on_combo_multiplier_changed)

func create_text_string(text: String, shake_rate: int, shake_level: int, color:String) -> String:
	return TEXT_FORMAT % [shake_rate, shake_level, color, text] 
	
func _on_combo_multiplier_changed(new_multiplier) -> void:
	if new_multiplier == 8:
		high_combo.show()
		if current_combo != 8:
			demo_lizard_audio.play()
	else:
		high_combo.hide()
		
	current_combo = new_multiplier
	self.text = create_text_string(
		str(current_combo) + "x", 
		ComboManager.Combo_ShakeRate, 
		ComboManager.Combo_ShakeLevel, 
		ComboManager.Combo_Color
	)
	

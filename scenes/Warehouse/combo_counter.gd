extends RichTextLabel


const TEXT_FORMAT = "[color=%s]%s[/color] "


var current_combo = 1


func _ready() -> void:
	self.text = str(current_combo) + "x"
	Events.combos.combo_changed.connect(_on_combo_multiplier_changed)


func _on_combo_multiplier_changed(new_multiplier) -> void:
	current_combo = new_multiplier
	self.text = TEXT_FORMAT % [ComboManager.Multiplier_To_Color[new_multiplier], str(current_combo) + "x"]

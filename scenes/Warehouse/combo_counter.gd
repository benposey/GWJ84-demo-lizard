extends RichTextLabel

var current_combo = 1
const TEXT_FORMAT = "[color=%s]%s[/color] "

func _ready() -> void:
	self.text = str(current_combo) + "x"
	Events.objects.object_destroyed.connect(_on_object_destroyed)
	Events.combos.combo_changed.connect(_on_combo_multiplier_changed)
	
func _on_object_destroyed(_point_value: int, _spawn_position: Vector2) -> void:
	if not current_combo >= 8:
		current_combo *= 2
		Events.combos.combo_changed.emit(current_combo)
		
func _on_combo_multiplier_changed(new_multiplier) -> void:	
	self.text = TEXT_FORMAT % [GlobalVars.Multiplier_To_Color[new_multiplier], str(new_multiplier) + "x"]
	

extends RichTextLabel

var current_combo = 1

func _ready() -> void:
	self.text = str(current_combo) + "x"
	Events.objects.object_destroyed.connect(_on_object_destroyed)
	
func _on_object_destroyed(_point_value: int, _spawn_position: Vector2) -> void:
	if not current_combo >= 8:
		current_combo *= 2
		self.text = str(current_combo) + "x"
		Events.combos.combo_changed.emit(current_combo)

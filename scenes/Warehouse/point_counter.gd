extends RichTextLabel

var current_points = 0

func _ready() -> void:
	self.text = str(current_points)
	Events.objects.object_destroyed.connect(_on_object_destroyed)
	
func _on_object_destroyed(point_value: int, spawn_position: Vector2) -> void:
	var mult_adjusted_points = point_value * GlobalVars.ComboMultiplier
	current_points += mult_adjusted_points
	self.text = str(current_points)
	DestroyedPointsDisplay.display_points(mult_adjusted_points, spawn_position)

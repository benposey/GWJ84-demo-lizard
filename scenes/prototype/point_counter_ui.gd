extends RichTextLabel

var current_points = 0

func _ready() -> void:
	self.text = str(current_points)
	Events.objects.object_destroyed.connect(_on_object_destroyed)
	
func _on_object_destroyed(point_value: int, spawn_position: Vector2) -> void:
	current_points += point_value
	self.text = str(current_points)
	DestroyedPointsDisplay.display_points(point_value, spawn_position)

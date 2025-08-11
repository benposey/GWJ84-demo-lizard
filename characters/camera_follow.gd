extends Camera2D

@export var look_ahead_active = true
@export_range(0.0, 0.5) var mouse_follow_amount: float = 0.25
@export_range(0.0, 0.5) var mouse_follow_speed: float = 0.05

func _process(_delta) -> void:
	if look_ahead_active:
		offset = lerp(offset, (get_local_mouse_position() - position) * mouse_follow_amount, mouse_follow_speed)
	else:
		offset = lerp(offset, Vector2.ZERO, mouse_follow_speed)
	
	position = position.round()

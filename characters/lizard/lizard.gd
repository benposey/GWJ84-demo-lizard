extends CharacterBody2D
@onready var sprite_2d: Sprite2D = $Sprite2D

const SPEED = 100.0

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED

	sprite_2d.look_at(get_global_mouse_position())
	move_and_slide()

extends CharacterBody2D
@onready var sprite_2d: Sprite2D = $Sprite2D

const SPEED = 100.0

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	

	sprite_2d.look_at(get_global_mouse_position())
	velocity = direction * SPEED
	move_and_slide()

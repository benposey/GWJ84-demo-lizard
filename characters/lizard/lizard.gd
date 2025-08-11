extends CharacterBody2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var body_parts: Node2D = $BodyParts
@onready var head: AnimatedSprite2D = $Head

const SPEED = 100.0

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	
	
	
	if direction == Vector2.ZERO:
		_play_body_animation("idle")
	else:
		_play_body_animation("walk")
		
	head.look_at(get_global_mouse_position())
	#body_parts.look_at(get_global_mouse_position())
	var angle = (get_global_mouse_position() - body_parts.global_position).angle()
	body_parts.global_rotation = lerp_angle(body_parts.global_rotation, angle, 5 * delta)
	velocity = direction * SPEED
	move_and_slide()

func _play_body_animation(animation_name: String):
	for part in body_parts.get_children():
		if part is AnimatedSprite2D:
			part.play(animation_name)

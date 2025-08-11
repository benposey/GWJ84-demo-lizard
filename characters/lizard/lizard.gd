extends CharacterBody2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var body_parts: Node2D = $BodyParts
@onready var arms: AnimatedSprite2D = $Arms
@onready var head: AnimatedSprite2D = $Head
@onready var attack_area: Area2D = $Arms/AttackArea

const SPEED = 100.0
var is_attacking: bool = false

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	
	#print(attack_area.get_overlapping_areas())
	#print(attack_area.get_overlapping_bodies())
	
	if direction == Vector2.ZERO:
		_play_body_animation("idle")
		if !is_attacking:
			arms.play("idle")
	else:
		_play_body_animation("walk")
		if !is_attacking:
			arms.play("walk")
	
	# Rotate sprites
	head.look_at(get_global_mouse_position())
	var angle = (get_global_mouse_position() - body_parts.global_position).angle()
	body_parts.global_rotation = lerp_angle(body_parts.global_rotation, angle, 5 * delta)
	arms.global_rotation = lerp_angle(body_parts.global_rotation, angle, 25 * delta)
	
	velocity = direction * SPEED
	move_and_slide()

func _input(event):
	if !is_attacking && event.is_action_pressed("attack"):
		attack()

func attack():
	is_attacking = true
	var animation_name = ["attack1", "attack2"].pick_random() # TODO: combo attack sequence
	arms.play(animation_name)
	_destroy_bodies_in_range()
	await(arms.animation_finished)
	is_attacking = false

func _play_body_animation(animation_name: String):
	for part in body_parts.get_children():
		if part is AnimatedSprite2D:
			part.play(animation_name)

func _destroy_bodies_in_range():
	for body in attack_area.get_overlapping_bodies():
		if body.is_in_group("destructable"):
			print(body)
			body.destroy()

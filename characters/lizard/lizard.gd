extends CharacterBody2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var body_parts: Node2D = $BodyParts
@onready var arms: AnimatedSprite2D = $Arms
@onready var head: AnimatedSprite2D = $Head
@onready var attack_area: Area2D = $Arms/AttackArea

const SPEED = 100.0
var is_attacking: bool = false
var is_grabbing: bool = false
var is_pulling: bool = false
var tongue_target = Vector2.ZERO

func _ready() -> void:
	head.play("default")

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
	
	if is_grabbing:
		tongue_target = lerp(tongue_target, get_local_mouse_position(), 30 * delta)
		queue_redraw()
	
	if is_pulling:
		print("pulling")
		tongue_target = lerp(tongue_target, Vector2.ZERO, 30 * delta)
		queue_redraw()
	
	# Rotate sprites
	head.look_at(get_global_mouse_position())
	var angle = (get_global_mouse_position() - body_parts.global_position).angle()
	body_parts.global_rotation = lerp_angle(body_parts.global_rotation, angle, 5 * delta)
	arms.global_rotation = lerp_angle(body_parts.global_rotation, angle, 25 * delta)
	
	velocity = direction * SPEED
	move_and_slide()

func _draw():
	print("drawing")
	if (is_grabbing):
		draw_line(Vector2(0,0), tongue_target, "#ac76a5", 2.0)
		draw_circle(tongue_target, 2, "#ac76a5")
			
func _input(event):
	if !is_grabbing && !is_attacking && event.is_action_pressed("attack"):
		attack()
	if !is_attacking && !is_pulling && event.is_action_pressed("grab"):
		grab()
	#if is_grabbing && event.is_action_released("grab"):
		#release()
		
func attack():
	is_attacking = true
	var animation_name = ["attack1", "attack2"].pick_random() # TODO: combo attack sequence
	arms.play(animation_name)
	_destroy_bodies_in_range()
	await(arms.animation_finished)
	is_attacking = false
	
func grab():
	is_grabbing = true
	head.play("grab_start")
	await(get_tree().create_timer(0.5).timeout)
	is_grabbing = false
	is_pulling = true
	head.play("default")
	await(get_tree().create_timer(0.1).timeout)
	is_pulling = false

func release():
	is_grabbing = false
	head.play("default")
	
func _play_body_animation(animation_name: String):
	for part in body_parts.get_children():
		if part is AnimatedSprite2D:
			part.play(animation_name)

func _destroy_bodies_in_range():
	for body in attack_area.get_overlapping_bodies():
		if body is DestructObject:
			#print(body)
			body.destroy()

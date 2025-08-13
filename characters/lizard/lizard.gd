extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var body_parts: Node2D = $BodyParts
@onready var arms: AnimatedSprite2D = $Arms
@onready var head: AnimatedSprite2D = $Head
@onready var attack_area: Area2D = $Arms/AttackArea
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var tongue_object_raycast: RayCast2D = $TongueObjectRaycast
@onready var tongue_wall_raycast: RayCast2D = $TongueWallRaycast
@onready var mouth_target: Marker2D = $Head/MouthTarget

enum TongueState {
	In,
	Retract,
	Out,
	PullingObject,
	PullingPlayer
}

const SPEED: float = 100.0
const THROW_FORCE: float = 800.0
const MAX_TONGUE_TIME: float = 0.5
const RETRACT_TONGUE_TIME: float = 0.1

var is_attacking: bool = false
var mouse_target = Vector2.ZERO
var tongue_target = Vector2.ZERO
var tongue_state: TongueState = TongueState.In
var grabbed_object: RigidBody2D = null
var tongue_timer: float = 0.0

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
	
	handle_tongue(delta)
	
	# Rotate sprites
	var angle = (get_global_mouse_position() - body_parts.global_position).angle()
	body_parts.global_rotation = lerp_angle(body_parts.global_rotation, angle, 5 * delta)
	arms.global_rotation = lerp_angle(body_parts.global_rotation, angle, 25 * delta)
	
	velocity = direction * SPEED
	move_and_slide()

func handle_tongue(delta: float) -> void:
	match (tongue_state):
		TongueState.In:
			tongue_target = Vector2.ZERO
			_set_tongue_raycast_target(tongue_target)
			head.look_at(get_global_mouse_position())
			head.play("default")
		
		TongueState.Out:
			tongue_timer += delta
			print(tongue_timer)
			# Retract tongue after max time
			if tongue_timer > MAX_TONGUE_TIME:
				tongue_state = TongueState.In
				tongue_timer = 0
				
			tongue_target = lerp(tongue_target, mouse_target, 30 * delta)
			_set_tongue_raycast_target(tongue_target)
			if tongue_object_raycast.is_colliding():
				tongue_state = TongueState.PullingObject
				tongue_target = tongue_object_raycast.get_collision_point() - global_position
				var collider = tongue_object_raycast.get_collider()
				object_grabbed(collider)
			elif tongue_wall_raycast.is_colliding():
				tongue_state = TongueState.PullingPlayer
				tongue_target = tongue_wall_raycast.get_collision_point() - global_position
			queue_redraw()
		TongueState.PullingObject:
			tongue_target = lerp(tongue_target, Vector2.ZERO, 24 * delta)
			_set_tongue_raycast_target(tongue_target)
			head.look_at(get_global_mouse_position())
			head.play("grab_hold")
			grabbed_object.global_position = lerp(grabbed_object.global_position, mouth_target.global_position, 24 * delta)
			queue_redraw()
		TongueState.PullingPlayer:
			head.look_at(tongue_target)
			head.play("default")
			# TODO

func object_grabbed(obj: RigidBody2D):
	grabbed_object = obj
	grabbed_object.freeze = true
	grabbed_object.lock_rotation = true

func _set_tongue_raycast_target(pos: Vector2) -> void:
	tongue_object_raycast.target_position = pos
	tongue_wall_raycast.target_position = pos

func _draw():
	if (tongue_state == TongueState.Out):
		draw_line(Vector2(0,0), tongue_target, "#ac76a5", 2.0)
		draw_circle(tongue_target, 2, "#ac76a5")
			
func _input(event):
	if !is_attacking && event.is_action_pressed("attack"):
		attack()
	if !is_attacking && tongue_state == TongueState.In && event.is_action_pressed("grab"):
		grab()
	if tongue_state == TongueState.PullingObject && event.is_action_released("grab"):
		shoot_grabbed_object()
		
func attack():
	print("here")
	is_attacking = true
	var animation_name = ["attack1", "attack2"].pick_random() # TODO: combo attack sequence
	arms.play(animation_name)
	_destroy_bodies_in_range()
	await(arms.animation_finished)
	is_attacking = false
	tongue_state = TongueState.In
	
func grab():
	audio_stream_player_2d.play()
	tongue_state = TongueState.Out
	mouse_target = get_local_mouse_position()
	head.play("grab_start")

func shoot_grabbed_object():
	# Disable player collision
	grabbed_object.set_collision_mask_value(1, false)
	grabbed_object.freeze = false
	grabbed_object.lock_rotation = false
	grabbed_object.thrown = true
	grabbed_object.linear_velocity = (get_global_mouse_position() - global_position).normalized() * THROW_FORCE
	grabbed_object = null
	tongue_state = TongueState.In

func _play_body_animation(animation_name: String):
	for part in body_parts.get_children():
		if part is AnimatedSprite2D:
			part.play(animation_name)

func _destroy_bodies_in_range():
	for body in attack_area.get_overlapping_bodies():
		if body is DestructObject:
			#print(body)
			body.destroy()

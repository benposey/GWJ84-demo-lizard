class_name Cage
extends DestructObject

@export var DEBUG_MODE: bool = false

@onready var cage_sprite: AnimatedSprite2D = $CageSprite
@onready var cage_destroyed_sprite: Sprite2D = $CageDestroyedSprite
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var debris_particles: GPUParticles2D = $DebrisParticles
@onready var debris_long_particles: GPUParticles2D = $DebrisLongParticles

@onready var explosion_sound: AudioStreamPlayer2D = $ExplosionSound
@onready var small_explosion: Explosion = $SmallExplosion
@onready var destructive_zone_collision: CollisionShape2D = $DestructiveZone/DestructiveZoneCollision

const SMALL_LIZARD = preload("res://characters/small_lizard.tscn")
const TRAUMA_FACTOR := 0.1
const CAGE_POINTS := 1000

var thrown = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	point_value = CAGE_POINTS # override the default point value
	small_explosion.hide()
	if DEBUG_MODE:
		explosion_sound.volume_db = -60

func destroy():
	if !is_destroyed:
		is_destroyed = true
		
		# Disable collision
		linear_damp = 0
		angular_damp = 0
		
		set_deferred("collision_shape_2d.disabled", true)
		if !thrown:
			set_deferred("destructive_zone_collision.disabled", true)
		
		# Screen effects
		Events.camera.add_trauma.emit(TRAUMA_FACTOR)
		Events.objects.object_destroyed.emit(point_value, self.global_position)
		Events.objects.objective_item_destroyed.emit()
		
		# Animation/Sound
		small_explosion.play_explosion()
		cage_sprite.hide()
		cage_destroyed_sprite.show()
		debris_particles.emitting = true
		debris_long_particles.emitting = true
		
		# Spawn lizard
		var small_lizard = SMALL_LIZARD.instantiate()
		small_lizard.global_position = global_position
		var root_node = get_tree().current_scene
		root_node.add_child(small_lizard)

func _on_destructive_zone_body_entered(body: Node2D) -> void:
	if thrown:
		if body is DestructObject:
			body.destroy()
		self.destroy()

class_name Box
extends DestructObject

@export var DEBUG_MODE: bool = false

@onready var explosion_sound: AudioStreamPlayer2D = $ExplosionSound
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var small_explosion: Explosion = $SmallExplosion
@onready var destructive_zone_collision: CollisionShape2D = $DestructiveZone/DestructiveZoneCollision

const TRAUMA_FACTOR := 0.1
const BOX_POINTS := 100

var thrown = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	point_value = BOX_POINTS # override the default point value
	if DEBUG_MODE:
		explosion_sound.volume_db = -60

func destroy():
	if !is_destroyed:
		if !thrown:
			set_deferred("destructive_zone_collision.disabled", true)
		
		is_destroyed = true
		Events.camera.add_trauma.emit(TRAUMA_FACTOR)
		Events.objects.object_destroyed.emit(point_value, self.global_position)
		animation_player.play("explode")
		small_explosion.play_explosion()
		await(animation_player.animation_finished)
		queue_free()

func _on_destructive_zone_body_entered(body: Node2D) -> void:
	if thrown:
		if body is DestructObject:
			body.destroy()
		self.destroy()

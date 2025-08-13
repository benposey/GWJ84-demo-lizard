class_name Box
extends DestructObject

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var small_explosion: Node2D = $SmallExplosion
@onready var destructive_zone_collision: CollisionShape2D = $DestructiveZone/DestructiveZoneCollision

const TRAUMA_FACTOR := 0.1
const BOX_POINTS := 100

var thrown = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	point_value = BOX_POINTS # override the default point value
	small_explosion.hide()
	get_colliding_bodies()

func destroy():
	if !is_destroyed:
		if !thrown:
			destructive_zone_collision.disabled = true
			
		is_destroyed = true
		Events.camera.add_trauma.emit(TRAUMA_FACTOR)
		Events.objects.object_destroyed.emit(point_value, self.global_position)
		animation_player.play("explode")
		await(animation_player.animation_finished)
		queue_free()

func play_small_explosion():
	var rand_scale = randf_range(.8, 1.2)
	small_explosion.scale = Vector2(rand_scale, rand_scale)
	small_explosion.show()
	for sprite in small_explosion.get_children():
		if sprite is AnimatedSprite2D:
			var rand_rotation = randi_range(0,6)
			sprite.rotate(rand_rotation)
			sprite.play("default")

func _on_destructive_zone_body_entered(body: Node2D) -> void:
	if thrown:
		if body is DestructObject:
			body.destroy()
		self.destroy()

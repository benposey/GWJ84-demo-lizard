class_name Box
extends DestructObject

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var small_explosion: Node2D = $SmallExplosion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	point_value = 100 # override the default point value
	small_explosion.hide()

func destroy():
	if !is_destroyed:
		is_destroyed = true
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

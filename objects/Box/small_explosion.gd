class_name Explosion
extends Node2D

@export var audio_stream_player: AudioStreamPlayer2D

func _ready() -> void:
	self.hide()

func play_explosion():
	var rand_scale = randf_range(.8, 1.2)
	self.scale = Vector2(rand_scale, rand_scale)
	self.show()
	audio_stream_player.play()
	for sprite in self.get_children():
		if sprite is AnimatedSprite2D:
			var rand_rotation = randi_range(0,6)
			sprite.rotate(rand_rotation)
			sprite.play("default")
	await get_tree().create_timer(5.0).timeout
	queue_free()

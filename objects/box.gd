class_name Box
extends RigidBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func destroy():
	animation_player.play("explode")
	await(animation_player.animation_finished)
	queue_free()

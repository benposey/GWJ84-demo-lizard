extends CanvasLayer
@onready var animation_player: AnimationPlayer = $RichTextLabel/AnimationPlayer
@onready var continue_button: RichTextLabel = $ContinueButton

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("detonate"):
		get_tree().change_scene_to_file("res://scenes/Warehouse/Warehouse.tscn")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	continue_button.show()

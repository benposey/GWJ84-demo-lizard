extends Node2D

@onready var red_button: AnimatedSprite2D = $RedButton
@onready var lizard_qte: AnimatedSprite2D = $LizardQTE
@onready var lizard_sound: AudioStreamPlayer = $lizardSound

var buttonPressCount = 1

func _input(event):
	if event.is_action_pressed("detonate"):
		lizard_qte.play("LizardJump")
		red_button.play("RedButtonPressed")
		lizard_qte.speed_scale = buttonPressCount
		red_button.speed_scale = buttonPressCount
		buttonPressCount += 0.5
		lizard_sound.play()
		#todo increment score multiplier

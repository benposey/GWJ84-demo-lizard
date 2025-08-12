extends Node2D

@onready var red_button: AnimatedSprite2D = $RedButton
@onready var lizard_qte: AnimatedSprite2D = $LizardQTE
@onready var lizard_sound: AudioStreamPlayer = $lizardSound

var buttonPressCount = 1
var quickEventTime = 5.0 #seconds
var incrementRate = 0.1

#todo implement quick time event popping up and timer starting
#func EndOfLevelTrigger(event):
	#display QTE
	#var quickTimeEventTimer = get_tree().create_timer(quickEventTime)

func _on_end_of_level():
	show()

func _input(event):
	if event.is_action_pressed("detonate"):
		lizard_qte.play("LizardJump")
		red_button.play("RedButtonPressed")
		lizard_qte.speed_scale = buttonPressCount
		red_button.speed_scale = buttonPressCount
		buttonPressCount += incrementRate
		lizard_sound.play()
		#todo increment score multiplier

func _ready():
	#listen for timer end signal
	Events.level.level_ended.connect(_on_end_of_level)
	print("level end")

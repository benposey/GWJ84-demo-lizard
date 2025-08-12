class_name CameraController
extends Camera2D

# Follow
@export_range(0.0, 0.5) var mouse_follow_amount: float = 0.25
@export_range(0.0, 0.5) var mouse_follow_speed: float = 0.05

# Shake
@export_range(0.0, 1.0) var decay: float = 0.8  # How quickly the shaking stops [0, 1].
@export var max_offset = Vector2(160, 90)  # Maximum hor/ver shake in pixels.
@export var max_roll = 0.1  # Maximum rotation in radians (use sparingly).
@export var noise: FastNoiseLite
@onready var trauma_label: Label = $DebugTraumaLabel
var trauma = 0.0  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].
var noise_y = 0

var follow_offset: Vector2 = Vector2.ZERO
var shake_offset: Vector2 = Vector2.ZERO

func _ready():
	Events.camera.add_trauma.connect(_add_trauma)
	randomize()
	noise.seed = 420
	noise.frequency = 0.25
	noise.fractal_octaves = 2

func _physics_process(delta: float) -> void:
	# Follow mouse
	follow_offset = _get_follow_offset()
	
	# Screen shake
	if trauma:
		# Debug
		trauma_label.text = str(trauma)
		
		trauma = max(trauma - decay * delta, 0)
		shake_offset = _get_shake_offset()
	else:
		shake_offset = Vector2.ZERO
	
	offset = follow_offset + shake_offset
	position = position.round()

func _add_trauma(amount):
	trauma = min(trauma + amount, 1.0)

func _get_follow_offset():
	return lerp(follow_offset, (get_local_mouse_position() - position) * mouse_follow_amount, mouse_follow_speed)

func _get_shake_offset():
	var amount = pow(trauma, trauma_power)
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	return Vector2(max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y), max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y))

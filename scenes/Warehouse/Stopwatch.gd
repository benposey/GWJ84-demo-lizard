class_name Stopwatch extends Label

var timer := 0.0
var is_started := false

func _process(delta: float) -> void:
	if is_started:
		timer += delta
		self.text = String.num(timer, 3)

func start() -> void:
	is_started = true

func stop() -> void:
	is_started = false
	
func reset() -> void:
	timer = 0.0
		

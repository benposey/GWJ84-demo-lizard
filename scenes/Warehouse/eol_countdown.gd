class_name EOLCountdown extends Label

var timer := 5.0
var is_started := false

func _process(delta: float) -> void:
	if is_started:
		self.timer -= delta
		self.text = String.num(self.timer, 3)
		if timer <= 0.0:
			Events.level.level_end_countdown_completed.emit()
			self.is_started = false

func start() -> void:
	self.is_started = true

func stop() -> void:
	self.is_started = false
	
func reset() -> void:
	self.timer = 5.0
		

extends ProgressBar

var duration := 5.0
var time_left := duration
var decay_rate := 1.0

func start(seconds: float):
	duration = seconds
	time_left = seconds
	set_process(true)
	
func _process(delta: float) -> void:
	time_left -= delta * ComboManager.Combo_DecayRate
	self.value = time_left
	if time_left <= 0:
		time_left = 0 
		set_process(false)
		ComboManager.reset_combo()

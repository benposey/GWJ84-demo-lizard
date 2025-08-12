extends ProgressBar

const MAX_DURATION := 5.0
var duration := 0.0
var time_left := duration
var decay_rate := 1.0

func start(seconds: float):
	duration = min(seconds, MAX_DURATION)
	time_left = duration
	if duration == MAX_DURATION:
		Events.combos.combo_bar_maxed.emit()
	set_process(true)
	
func _process(delta: float) -> void:
	time_left -= delta * ComboManager.Combo_DecayRate
	self.value = time_left
	if time_left <= 0:
		time_left = 0 
		set_process(false)
		Events.combos.combo_bar_expired.emit()

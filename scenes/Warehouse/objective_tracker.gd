extends Label

const FORMAT_STRING = "%d/%d Lizards Freed"
var objectives_completed = 0
var total_required_objectives = 0

func _ready() -> void:
	Events.objects.objective_item_destroyed.connect(_on_objective_completed)
	self.text = FORMAT_STRING % [objectives_completed, total_required_objectives]

func set_required_objectives(num_objectives):
	total_required_objectives = num_objectives
	self.text = FORMAT_STRING % [objectives_completed, total_required_objectives]
	
func _on_objective_completed() -> void:
	objectives_completed += 1
	self.text = FORMAT_STRING % [objectives_completed, total_required_objectives]

class_name Horse extends Node2D
@onready var horse_noises: AudioStreamPlayer2D = $HorseNoises

var collected: bool = false

func _on_horse_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Events.objects.horse_collected.emit()
		self.hide()
		
		if not self.collected:
			horse_noises.play()
			collected = true

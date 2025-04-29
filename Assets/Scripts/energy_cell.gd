extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		GameManager.add_energy_cell()
		queue_free() # remove energy cell from scene on pickup

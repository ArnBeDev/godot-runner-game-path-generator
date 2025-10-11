extends Area3D

func _on_area_entered(_area: Area3D) -> void:
	Globals.points += 5
	queue_free()

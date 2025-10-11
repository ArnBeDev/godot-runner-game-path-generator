extends Node3D

var collided:bool = false

func _process(delta: float) -> void:
	rotate_y(deg_to_rad(delta * 150))

func _on_base_area_area_entered(_area: Area3D) -> void:
	if !collided:
		Globals.points += 5
		collided = true
		queue_free()

func _on_area_3d_area_entered(_area: Area3D) -> void:
	if !collided:
		Globals.points -= 5
		collided = true
		queue_free()

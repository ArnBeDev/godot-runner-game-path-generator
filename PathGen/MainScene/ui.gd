extends Control

@onready var points_label: Label = $Label

func _process(delta: float) -> void:
	points_label.text = "Points: " +str(Globals.points)

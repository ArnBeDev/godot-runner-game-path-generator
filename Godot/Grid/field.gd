extends Node3D

class_name Field

@onready var obstacle_1:PackedScene = preload("res://Grid/obstacle_1.tscn")
@onready var obstacle_2:PackedScene = preload("res://Grid/obstacle_2.tscn")
@onready var incentive:PackedScene = preload("res://Grid/incentive.tscn")

var spawn_type:int

func _ready() -> void:
	spawn_object()

func spawn_object() -> void:
	match spawn_type:
		SpawnType.OBSTACLE_1:
			add_child(obstacle_1.instantiate())
		SpawnType.OBSTACLE_2:
			add_child(obstacle_2.instantiate())
		SpawnType.INCENTIVE:
			add_child(incentive.instantiate())
		_:
			pass

extends Node3D

class_name Row

@onready var field:PackedScene = preload("res://Grid/field.tscn")
var passed_fields:Array[FieldGenerated]
var fields:Array[Field] = []
var right_border:float
var left_border:float

func _ready() -> void:
	## create fields, set position and SpawnType
	for pf in passed_fields:
		var new_field:Field = field.instantiate() as Field
		## set position in row
		if pf.id_in_row % 2 == 1:
			if pf.id_in_row == 1:
				new_field.position.z = 1.0
				right_border = 1.5
			else:
				new_field.position.z = (pf.id_in_row +1) / 2
				right_border = maxf(right_border,new_field.position.z +0.5)
				
		else:
			if pf.id_in_row == 2:
				new_field.position.z = -1
				left_border = -1.5
			elif pf.id_in_row > 2:
				new_field.position.z = (pf.id_in_row / 2) -1
				left_border = minf(left_border,new_field.position.z - 0.5)
		fields.append(new_field)
		
		## map FieldGenerated-Class to Field-Class
		new_field.spawn_type = pf.spawn_type
		add_child(new_field)

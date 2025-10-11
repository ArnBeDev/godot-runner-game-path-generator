extends Node3D

class_name Grid

@onready var row_scene:PackedScene = preload("res://Grid/row.tscn")
@onready var rows_node:Node3D = $Rows

var path_generator:PathGenerator

const speed:float = 5.0

func _init() -> void:
	Globals.grid = self
	path_generator = PathGenerator.new()
	
func _ready() -> void:
	create_start()

func _process(delta: float) -> void:
	move_rows(delta)
	pass

func move_rows(delta: float)->void:
	var move_speed = delta * speed
	var reached_next_position:bool = false
	var rows:Array = rows_node.get_children()
	
	for i in rows.size():
		rows[i].global_position.x = move_toward(rows[i].global_position.x, i-5, move_speed)
		if rows[i].global_position.x == i-5:
			reached_next_position = true
			break
			
	if reached_next_position:
		for i in rows.size():
			rows[i].global_position.x = i-5
		create_next_row()
		
		### delete last row
		rows_node.get_children().front().queue_free()
		
func create_start()-> void:
	var segments:Array[RowGenerated] = path_generator.get_start_segments()
	for i in segments.size():
		## map RowGenerated-Class to Row-Class
		var new_row:Row = row_scene.instantiate() as Row
		new_row.position.x = -5 + i
		new_row.passed_fields = segments[i].fields
		rows_node.add_child(new_row)
	
	## Object type requires manual deletion!
	for row in segments:
		row.free_fields()
		row.free()

func create_next_row() -> void:
	var next = path_generator.get_new_row()
	var new_row:Row = row_scene.instantiate() as Row
	## map RowGenerated-Class to Row-Class
	
	new_row.passed_fields = next.fields
	new_row.position.x = rows_node.get_children().back().global_position.x + 1
	rows_node.add_child(new_row)
	
	## Object type requires manual deletion!
	next.free_fields()
	next.free()

## returns the row the player is on
func get_player_row() -> Row:
	return rows_node.get_children()[5]

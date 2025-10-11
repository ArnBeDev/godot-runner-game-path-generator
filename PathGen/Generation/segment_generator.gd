extends RefCounted
## generates segments
## a segment is an Array which has 10 following RowGenerated

class_name SegmentGenerator

var _row_number:int = 0
var last_barrier_right:bool = false

## returns enough rows to initally fill the grid
func create_start()-> Array[RowGenerated]:
	var start_segments:Array[RowGenerated] = []
	
	for i in range(35):
		var new_row:RowGenerated = RowGenerated.new()
		new_row.row_number = _row_number
		for j in range(3):
			var new_field:FieldGenerated = FieldGenerated.new()
			new_field.id_in_row = j
			new_row.fields.append(new_field)
		start_segments.append(new_row)
		_row_number += 1
		
	return start_segments


## creates a segment of 10 following RowGenerated, without any Objects
func create_empty_segment(row_width:int) -> Array[RowGenerated]:
	var segment:Array[RowGenerated] = []
	for i in range(10):
		var new_row:RowGenerated = RowGenerated.new()
		for j in row_width:
			var new_field:FieldGenerated = FieldGenerated.new()
			new_field.id_in_row = j
			new_row.fields.append(new_field)
		new_row.row_number = _row_number
		_row_number += 1
		segment.append(new_row)
	return segment

## return a segments, places obstacles in the middle of the segment which forces the player to jump regularly
func generate_barrier_obstacles(row_width:int) -> Array[RowGenerated]:
	var new_segment:Array[RowGenerated] =  create_empty_segment(row_width)
	
	for i in range(new_segment.size()):
		if i == 5: # place obstacles here
			for field in new_segment[i].fields:
				if randi_range(1,100) == 1:
					field.spawn_type = SpawnType.INCENTIVE
				elif randi_range(1,4) == 4:
					field.spawn_type = SpawnType.OBSTACLE_2
				else:
					field.spawn_type = SpawnType.OBSTACLE_1
		else:
			for field in new_segment[i].fields:
				if randi_range(1,150) == 1:
					field.spawn_type = SpawnType.INCENTIVE
	return new_segment

## returns a segment, places obstacle alternating left and right, which forces the player to side move regularly
func generate_evade_obstacles(row_width:int) -> Array[RowGenerated]:
	var new_segment:Array[RowGenerated] =  create_empty_segment(row_width)
	
	for i in range(new_segment.size()):
		if i == 5:
			if last_barrier_right: 
				## place obstacle on left side
				for field in new_segment[i].fields:
					if field.id_in_row % 2 == 0:
						if randi_range(1,4) == 1:
							field.spawn_type = SpawnType.OBSTACLE_2
						else:
							field.spawn_type = SpawnType.OBSTACLE_1
				last_barrier_right = false
				
			else:
				## place obstacle on right side
				for field in new_segment[i].fields:
					if field.id_in_row % 2 == 1:
						if randi_range(1,4) == 1:
							field.spawn_type = SpawnType.OBSTACLE_2
						else:
							field.spawn_type = SpawnType.OBSTACLE_1
				last_barrier_right = true
		
		else:
			for field in new_segment[i].fields:
				if randi_range(1,150) == 1:
					field.spawn_type = SpawnType.INCENTIVE
	return new_segment

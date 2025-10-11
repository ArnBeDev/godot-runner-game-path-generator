extends RefCounted

class_name PathGenerator

var _rows:Array[RowGenerated] = []
var segment_generator:SegmentGenerator = SegmentGenerator.new()
var _current_segment_type:segment_type
var next_type_change:int
var next_width_change:int 

var _current_width:int = 3:
	set(value):
		_current_width = clampi(value,1,11)

func _init() -> void:
	segment_generator = SegmentGenerator.new()
	_current_segment_type = segment_type.values().pick_random()
	next_type_change = randi_range(30,70)
	next_width_change = randi_range(20,80)
	
	create_new_segment()
func get_start_segments() -> Array[RowGenerated]:
	return segment_generator.create_start()
	
func create_new_segment() -> void:
	if _current_segment_type == segment_type.JUMP:
		_rows.append_array(segment_generator.generate_barrier_obstacles(_current_width))
	else:
		_rows.append_array(segment_generator.generate_evade_obstacles(_current_width))
	
	## update segment type and row width
	
	if _rows.back().row_number >= next_type_change:
		if _current_segment_type == segment_type.JUMP:
			_current_segment_type = segment_type.EVADE
		else:
			_current_segment_type = segment_type.JUMP
		next_type_change = _rows.back().row_number + randi_range(100,150)
		
	if _rows.back().row_number >= next_width_change:
		if _current_width == 1:
			_current_width = randi_range(3,10)
		else:
			_current_width = randi_range(1,10)
			if _current_width == 1:
				next_width_change = _rows.back().row_number + randi_range(10,20)
			else:
				next_width_change = _rows.back().row_number + randi_range(20,100)
		
func get_new_row() -> RowGenerated:
	var next_row = _rows.pop_front()
	
	if _rows.is_empty():
		create_new_segment()
	return next_row

enum segment_type{
	JUMP,
	EVADE
}

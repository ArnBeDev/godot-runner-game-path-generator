extends Area3D
## Simple Player class to demonstrate the project

class_name Player

var corner_markers:Array[Marker3D] = []
var move_right:bool
var move_left:bool
var is_jumping:bool

var side_speed:float = 5
var jump_power:float = 5.5
const my_gravity:float = -10
var current_upward_speed:float = 0

func _ready() -> void:
	corner_markers.append_array($Corners.get_children())
	
func _process(delta: float) -> void:
	handle_input()
	movement(delta)

func movement(delta) -> void:
	var current_row:Row = Globals.grid.get_player_row()
	
	if move_right:
		global_position.z += delta * side_speed
		
	elif move_left:
		global_position.z -= delta * side_speed
	
	if current_row.fields.size() == 1:
		global_position.z = 0.0
	else:
		global_position.z = clampf(global_position.z, current_row.left_border + 0.5, current_row.right_border-0.5)
	
	if is_jumping:
		current_upward_speed += my_gravity *delta
		global_position.y += current_upward_speed *delta
		var lowest_corner:float = corner_markers[0].global_position.y
		for corner in corner_markers:
			lowest_corner = minf(corner.global_position.y, lowest_corner)
		if lowest_corner <= 0.0:
			is_jumping = false
			global_position.y += abs(lowest_corner + global_position.y)
	else:
		global_position.y = clampf(global_position.y, 0.0, 100)
	
func handle_input() -> void:
	if Input.is_key_pressed(KEY_LEFT):
		set_side_movement(1)
	elif Input.is_key_pressed(KEY_RIGHT):
		set_side_movement(2)
	else:
		set_side_movement(0)
	if Input.is_key_pressed(KEY_SPACE) or Input.is_key_pressed(KEY_UP):
		if !is_jumping:
			is_jumping = true
			current_upward_speed = jump_power
			
func set_side_movement(type:int) -> void:
	move_right = false
	move_left = false
	if type == 1:
		move_left = true
	elif type == 2:
		move_right = true

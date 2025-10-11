extends Object
## used as generator output
## use type 'Object' to avoid [Node] overhead
## will be mapped in a [Row] Node for the grid

class_name RowGenerated

var fields:Array[FieldGenerated] = []

var row_number:int
var amount_right:int
var amount_left:int

## type Object requires manual deletion of fields
func free_fields()-> void:
	for field in fields:
		field.free()

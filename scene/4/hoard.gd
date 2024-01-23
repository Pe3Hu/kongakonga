extends MarginContainer


#region vars
@onready var vertex = $Icons/Vertex
@onready var edge = $Icons/Edge
@onready var face = $Icons/Face

var bureau = null
var type = null
var subtype = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	bureau = input_.bureau
	type = input_.type
	subtype = input_.subtype
	
	init_basic_setting()


func init_basic_setting() -> void:
	for hierarchy in Global.arr.hierarchy:
		var icon = get(hierarchy)
		var input = {}
		input.type = "number"
		input.subtype = 0
		
		if subtype == "icon":
			input.type = "hoard"
			input.subtype = type + " " + hierarchy
		
		icon.set_attributes(input)
#endregion

extends MarginContainer


#region vars
@onready var vertex = $Icons/Vertex
@onready var edge = $Icons/Edge
@onready var face = $Icons/Face

var bureau = null
var kind = null
var type = null
var subtype = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	bureau = input_.bureau
	kind = input_.kind
	type = input_.type
	subtype = input_.subtype
	
	init_basic_setting()


func init_basic_setting() -> void:
	for hierarchy in Global.arr.hierarchy:
		var icon = get(hierarchy)
		var input = {}
		input.type = "number"
		input.subtype = 0
		
		var style = StyleBoxFlat.new()
		icon.bg.set("theme_override_styles/panel", style)
		style.bg_color = Global.color.kind[kind]
		
		if subtype == "icon":
			input.type = "hierarchy"
			input.subtype = type + " " + hierarchy
			icon.bg.visible = false
		
		icon.set_attributes(input)
		
#endregion


func apply_cheveron(cheveron_: MarginContainer) -> void:
	var icon = get(cheveron_.type)
	var value = cheveron_.value.get_number()
	icon.change_number(value)

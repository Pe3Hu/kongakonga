extends MarginContainer


#region vars
@onready var bg = $BG
@onready var trigger = $HBox/Trigger
@onready var marker = $HBox/Marker
@onready var value = $HBox/Value

var card = null
var kind = null
var type = null
var subtype = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	card = input_.card
	kind = input_.kind
	type = input_.type
	subtype = input_.subtype
	
	init_basic_setting(input_)


func init_basic_setting(input_: Dictionary) -> void:
	var types = {}
	types.hoard = [""]
	var input = {}
	input.type = "number"
	input.subtype = input_.value
	value.set_attributes(input)
	
	if Global.arr.face.has(kind):
		input.type = "hierarchy"
	
	if Global.arr.element.has(kind):
		input.type = "time"
	
	input.subtype = subtype + " " + type
	marker.set_attributes(input)
	
	input.type = "trigger"
	input.subtype = "none"
	trigger.set_attributes(input)
	
	var style = StyleBoxFlat.new()
	marker.bg.set("theme_override_styles/panel", style)
	style.bg_color = Global.color.kind[kind]
#endregion

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
var weight = 0
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
	calc_weight()


func calc_weight() -> void:
	var data = get_data()
	weight = Global.dict.conversion.weight[data] * value.get_number()
#endregion


func get_data() -> Dictionary:
	var data = {}
	data.kind = kind
	data.type = type
	data.subtype = subtype
	return data


func employ_method(method_: String) -> void:
	var before = get(method_)
	
	if method_ != "value":
		set(method_, Global.dict.chain[method_][before])
		
		if method_ == "kind":
			var style = marker.bg.get("theme_override_styles/panel")
			style.bg_color = Global.color.kind[kind]
		else:
			marker.subtype = subtype + " " + type
			marker.set_image()
	else:
		before.change_number(1)
	
	calc_weight()



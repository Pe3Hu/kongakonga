extends MarginContainer


#region vars
@onready var before = $HBox/Before
@onready var method = $HBox/Icons/Method
@onready var step = $HBox/Icons/Step
@onready var price = $HBox/Icons/Price
@onready var after = $HBox/After

var workshop = null
var chevron = null
var limit = null
var end = false
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	workshop = input_.workshop
	chevron = input_.chevron
	limit = input_.limit
	
	init_basic_setting(input_)


func init_basic_setting(input_: Dictionary) -> void:
	init_icons(input_)
	
	var data = chevron.get_data()
	data.card = null
	data.value = chevron.value.get_number()
	
	for stage in Global.arr.stage:
		fill_chevron(stage, data)
	
	while !end:
		calc_next_step()
	
	print([method.subtype, after.weight])
	


func init_icons(input_: Dictionary) -> void:
	var input = {}
	input.type = "method"
	input.subtype = input_.method
	method.set_attributes(input)
	
	input.type = "number"
	input.subtype = 0
	step.set_attributes(input)
	
	input.type = "number"
	input.subtype = 0
	price.set_attributes(input)


func fill_chevron(stage_: String, data_: Dictionary) -> void:
	var chevron = get(stage_)
	chevron.set_attributes(data_)


func calc_next_step() -> void:
	var data = after.get_data()
	
	if Global.dict.conversion.method[data].has(method.subtype):
		var index = Global.dict.conversion.method[data][method.subtype]
		var description = Global.dict.conversion.index[index]
		var tax = description.price + after.weight
		
		print([description.price, after.weight, price.get_number()])
		if price.get_number() + tax <= limit:
			step.change_number(1)
			price.change_number(tax)
			after.employ_method(method.subtype)
		else:
			end = true
	else:
		end = true
	
#endregion

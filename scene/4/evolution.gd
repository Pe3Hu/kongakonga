extends MarginContainer


#region vars
@onready var level = $HBox/Level
@onready var experience = $HBox/Experience

var gambler = null
var value = {}
var state = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	gambler = input_.gambler
	
	init_basic_setting(input_)


func init_basic_setting(input_: Dictionary) -> void:
	var input = {}
	input.type = "number"
	input.subtype = 1
	level.set_attributes(input)
	
	input.evolution = self
	experience.set_attributes(input)
#endregion


func get_experience(experience_: int) -> void:
	experience.update_value("current", experience_)


func next_level() -> void:
	experience.bar.value -= experience.bar.max_value
	level.change_number(1)
	experience.recalc_max_value()

extends MarginContainer


#region vars
@onready var bar = $ProgressBar
@onready var value = $Value

var evolution = null
#endregion


func set_attributes(input_: Dictionary) -> void:
	evolution = input_.evolution
	
	init_basic_setting()


func init_basic_setting() -> void:
	recalc_max_value()
	set_colors()
	update_value("current", 0)
	custom_minimum_size = Vector2(Global.vec.size.bar)


func recalc_max_value() -> void:
	var base = 9 + evolution.level.get_number()
	var value = pow(base, 2)
	update_value("maximum", value)


func set_colors() -> void:
	var keys = ["fill", "background"]
	
	for key in keys:
		var style_box = StyleBoxFlat.new()
		style_box.bg_color = Global.color.bar.experience[key]
		var path = "theme_override_styles/" + key
		bar.set(path, style_box)


func update_value(value_: String, shift_: int) -> void:
	match value_:
		"current":
			bar.value += shift_
			
			while bar.value >= bar.max_value:
				evolution.next_level()
			
			value.text = str(bar.value) + "/" + str(bar.max_value)
		"maximum":
			bar.max_value = shift_


func get_percentage() -> int:
	return floor(bar.value * 100 / bar.max_value)


func reset() -> void:
	bar.value = bar.max_value

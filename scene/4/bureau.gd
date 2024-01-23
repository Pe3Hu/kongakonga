extends MarginContainer


#region vars
@onready var head = $VBox/Head
@onready var trigon = $VBox/Trigon
@onready var tetragon = $VBox/Tetragon
@onready var pentagon = $VBox/Pentagon

var gambler = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	gambler = input_.gambler
	
	init_basic_setting()


func init_basic_setting() -> void:
	init_hoards()


func init_hoards() -> void:
	var keys = ["head"]
	keys.append_array(Global.dict.face.count.keys())
	var subtypes = {}
	subtypes[true] = "icon"
	subtypes[false] = "value"
	
	for key in keys:
		var flag = key == "head"
		var hbox = get(key)
		
		for child in hbox.get_children():
			var appellation = child.name.to_lower()
			
			if appellation == "icon":
				var input = {}
				input.type = "gon"
				input.subtype = key
				child.set_attributes(input)
			else:
				var input = {}
				input.bureau = "self"
				input.type = appellation
				input.subtype = subtypes[flag]
				child.set_attributes(input)
#endregion

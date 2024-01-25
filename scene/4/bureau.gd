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
			var input = {}
			input.bureau = self
			input.kind = key
			
			if appellation == "icon":
				input.type = "gon"
				input.subtype = key
				child.set_attributes(input)
			else:
				input.type = appellation
				input.subtype = subtypes[flag]
				child.set_attributes(input)
#endregion


func get_hoard(kind_: String, subtype_: String) -> Variant:
	var hbox = get(kind_)
	
	for child in hbox.get_children():
		if child.type == subtype_:
			return child
	
	return null


func apply_cheveron(cheveron_: MarginContainer) -> void:
	var hoard = get_hoard(cheveron_.kind, cheveron_.subtype)
	hoard.apply_cheveron(cheveron_)


func end_of_turn() -> void:
	face_assembly()
	waste_treatment()


func face_assembly() -> void:
	for face in Global.arr.face:
		var count = Global.dict.face.count[face]
		var limits = {}
		limits.vertex = 0
		limits.edge = 0
		
		for status in Global.arr.status:
			var hoard = get_hoard(face, status)
			
			for hierarchy in limits:
				var icon = hoard.get(hierarchy)
				limits[hierarchy] += icon.get_number()
		
		while limits.edge >= count and limits.vertex >= count:
			limits.vertex -= count
			limits.edge -= count
			var status = "temporarily"
			add_face(face, status)


func add_face(face_: String, status_: String) -> void:
	var count = -Global.dict.face.count[face_]
	var hoard = get_hoard(face_, status_)
	var icon = hoard.get("face")
	icon.change_number(1)
	
	for hierarchy in Global.arr.hierarchy:
		if hierarchy != "face":
			icon = hoard.get(hierarchy)
			icon.change_number(count)


func waste_treatment() -> void:
	for face in Global.arr.face:
		for status in Global.arr.status:
			var hoard = get_hoard(face, status)
			
			for hierarchy in Global.arr.hierarchy:
				if hierarchy != "face":
					var icon = hoard.get(hierarchy)
					var experience = icon.get_number() * Global.num.experience[hierarchy]
					gambler.evolution.get_experience(experience)
					icon.set_number(0)

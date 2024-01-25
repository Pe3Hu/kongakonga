extends Node


var rng = RandomNumberGenerator.new()
var arr = {}
var num = {}
var vec = {}
var color = {}
var dict = {}
var flag = {}
var node = {}
var scene = {}


func _ready() -> void:
	init_arr()
	init_num()
	init_vec()
	init_color()
	init_dict()
	init_node()
	init_scene()


func init_arr() -> void:
	arr.rank = [1, 2, 3, 4, 5]#, 6]
	arr.side = ["left", "right"]
	arr.state = ["vigor", "standard", "fatigue"]
	arr.medal = ["winner", "loser"]
	arr.phase = ["dawn", "noon", "dusk"]
	arr.hierarchy = ["vertex", "edge", "face"]
	arr.face = ["trigon", "tetragon", "pentagon"]
	arr.element = ["aqua", "wind", "fire", "earth"]
	arr.status = ["temporarily", "permanently"]


func init_num() -> void:
	num.index = {}
	num.index.card = 0
	num.index.gambler = 0
	
	num.apotheosis = {}
	num.apotheosis.amount = 24
	
	num.weight = {}
	num.weight.vertex = 1
	num.weight.edge = 2
	
	num.experience = {}
	num.experience.vertex = 5
	num.experience.edge = 9


func init_dict() -> void:
	init_chain()
	init_neighbor()
	init_card()
	init_polyhedron()
	init_deck()


func init_chain() -> void:
	dict.chain = {}
	dict.chain.area = {}
	dict.chain.area[null] = "discharged"
	dict.chain.area["discharged"] = "available"
	dict.chain.area["available"] = "hand"
	dict.chain.area["hand"] = "discharged"
	dict.chain.area["broken"] = "discharged"
	
	dict.chain.side = {}
	dict.chain.side["right"] = "left"
	dict.chain.side["left"] = "right"
	
	dict.donor = {}
	dict.donor.area = {}
	dict.donor.area["available"] = "discharged"
	dict.donor.area["hand"] = "available"
	
	dict.donor.state = {}
	dict.donor.state["vigor"] = "standard"
	dict.donor.state["standard"] = "fatigue"
	dict.donor.state["fatigue"] = null
	
	dict.chain.state = {}
	dict.chain.state["fatigue"] = "standard"
	dict.chain.state["standard"] = "vigor"
	dict.chain.state["vigor"] = null
	
	dict.chain.phase = {}
	dict.chain.phase["dawn"] = "noon"
	dict.chain.phase["noon"] = "dusk"
	dict.chain.phase["dusk"] = "dawn"
	
	dict.phase = {}
	dict.phase.stage = {}
	dict.phase.stage["dawn"] = ["preparing"]
	dict.phase.stage["noon"] = ["balancing"]
	dict.phase.stage["dusk"] = ["reckoning"]


func init_neighbor() -> void:
	dict.neighbor = {}
	dict.neighbor.linear3 = [
		Vector3( 0, 0, -1),
		Vector3( 1, 0,  0),
		Vector3( 0, 0,  1),
		Vector3(-1, 0,  0)
	]
	dict.neighbor.linear2 = [
		Vector2( 0,-1),
		Vector2( 1, 0),
		Vector2( 0, 1),
		Vector2(-1, 0)
	]
	dict.neighbor.diagonal = [
		Vector2( 1,-1),
		Vector2( 1, 1),
		Vector2(-1, 1),
		Vector2(-1,-1)
	]
	dict.neighbor.zero = [
		Vector2( 0, 0),
		Vector2( 1, 0),
		Vector2( 1, 1),
		Vector2( 0, 1)
	]
	dict.neighbor.hex = [
		[
			Vector2( 1,-1), 
			Vector2( 1, 0), 
			Vector2( 0, 1), 
			Vector2(-1, 0), 
			Vector2(-1,-1),
			Vector2( 0,-1)
		],
		[
			Vector2( 1, 0),
			Vector2( 1, 1),
			Vector2( 0, 1),
			Vector2(-1, 1),
			Vector2(-1, 0),
			Vector2( 0,-1)
		]
	]


func init_card() -> void:
	arr.rank = [3, 4, 6, 8, 12]
	dict.card = {}
	dict.card.count = {}
	arr.suit = ["spades"]#["clubs", "diamonds", "hearts", "spades"]
	
	for rank in arr.rank:
		dict.card.count[rank] = num.apotheosis.amount / rank


func init_polyhedron() -> void:
	dict.polyhedron = {}
	dict.polyhedron.title = {}
	
	var path = "res://asset/json/kongakonga_polyhedron.json"
	var array = load_data(path)
	var exceptions = ["title"]
	
	for polyhedron in array:
		var data = {}
		data.count = {}
		
		for key in polyhedron:
			if !exceptions.has(key):
				var words = key.split(" ")
				
				if words.has("count"):
					data.count[words[0]] = polyhedron[key]
				else:
					data[key] = polyhedron[key]
		
		dict.polyhedron.title[polyhedron.title] = data
	
	dict.face = {}
	dict.face.count = {}
	dict.face.count["trigon"] = 3
	dict.face.count["tetragon"] = 4
	dict.face.count["pentagon"] = 5
	dict.face.weight = {}
	
	for face in dict.face.count:
		var count = dict.face.count[face]
		dict.face.weight[face] = count * (num.weight.vertex + num.weight.edge)


func init_deck() -> void:
	dict.deck = {}
	dict.deck.starter = []
	
	var path = "res://asset/json/kongakonga_deck.json"
	var array = load_data(path)
	dict.deck.starter.append_array(array)


func init_node() -> void:
	node.game = get_node("/root/Game")


func init_scene() -> void:
	scene.gambler = load("res://scene/1/gambler.tscn")
	
	scene.table = load("res://scene/2/table.tscn")
	
	scene.card = load("res://scene/3/card.tscn")
	scene.chevron = load("res://scene/3/chevron.tscn")


func init_vec():
	vec.size = {}
	vec.size.sixteen = Vector2(16, 16)
	vec.size.suit = Vector2(32, 32)
	
	vec.size.rank = Vector2(vec.size.sixteen)
	vec.size.combo = Vector2(vec.size.sixteen) * 2
	vec.size.gambler = Vector2(vec.size.sixteen) * 2.5
	vec.size.libra = Vector2(vec.size.sixteen) * 4
	
	vec.size.bar = Vector2(128, 16)
	#vec.size.tick = Vector2(5, 12)
	#vec.size.stage = Vector2(vec.size.tick)
	vec.size.number = Vector2(vec.size.sixteen) * 2.5
	vec.size.gon = Vector2(vec.size.number)
	vec.size.hierarchy = Vector2(vec.size.number)
	vec.size.time = Vector2(vec.size.number)
	vec.size.trigger = Vector2(vec.size.number)
	
	init_window_size()


func init_window_size():
	vec.size.window = {}
	vec.size.window.width = ProjectSettings.get_setting("display/window/size/viewport_width")
	vec.size.window.height = ProjectSettings.get_setting("display/window/size/viewport_height")
	vec.size.window.center = Vector2(vec.size.window.width/2, vec.size.window.height/2)


func init_color():
	var h = 360.0
	
	color.card = {}
	color.card.selected = Color.from_hsv(160 / h, 0.6, 0.7)
	color.card.unselected = Color.from_hsv(0 / h, 0.4, 0.9)
	
	color.bar = {}
	color.bar.vigor = {}
	color.bar.vigor.fill = Color.from_hsv(120 / h, 1, 0.9)
	color.bar.vigor.background = Color.from_hsv(120 / h, 0.25, 0.9)
	color.bar.standard = {}
	color.bar.standard.fill = Color.from_hsv(30 / h, 1, 0.9)
	color.bar.standard.background = Color.from_hsv(30 / h, 0.25, 0.9)
	color.bar.fatigue = {}
	color.bar.fatigue.fill = Color.from_hsv(0, 1, 0.9)
	color.bar.fatigue.background = Color.from_hsv(0, 0.25, 0.9)
	color.bar.experience = {}
	color.bar.experience.fill = Color.from_hsv(210 / h, 1, 0.9)
	color.bar.experience.background = Color.from_hsv(210 / h, 0.25, 0.9)
	
	color.kind = {}
	color.kind.head = Color.from_hsv(0 / h, 0.0, 0.0)
	color.kind.trigon = Color.from_hsv(120 / h, 0.4, 0.9)
	color.kind.tetragon = Color.from_hsv(180 / h, 0.4, 0.9)
	color.kind.pentagon = Color.from_hsv(60 / h, 0.4, 0.9)
	color.kind.aqua = Color.from_hsv(210 / h, 0.4, 0.9)
	color.kind.wind = Color.from_hsv(270 / h, 0.4, 0.9)
	color.kind.fire = Color.from_hsv(0 / h, 0.4, 0.9)
	color.kind.earth = Color.from_hsv(30 / h, 0.4, 0.9)



func save(path_: String, data_: String):
	var path = path_ + ".json"
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(data_)


func load_data(path_: String):
	var file = FileAccess.open(path_, FileAccess.READ)
	var text = file.get_as_text()
	var json_object = JSON.new()
	var parse_err = json_object.parse(text)
	return json_object.get_data()


func get_random_key(dict_: Dictionary):
	if dict_.keys().size() == 0:
		print("!bug! empty array in get_random_key func")
		return null
	
	var total = 0
	
	for key in dict_.keys():
		total += dict_[key]
	
	rng.randomize()
	var index_r = rng.randf_range(0, 1)
	var index = 0
	
	for key in dict_.keys():
		var weight = float(dict_[key])
		index += weight/total
		
		if index > index_r:
			return key
	
	print("!bug! index_r error in get_random_key func")
	return null

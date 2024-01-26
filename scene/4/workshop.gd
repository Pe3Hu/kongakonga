extends MarginContainer


#region vars
@onready var augmentations = $Augmentations

var gambler = null
#endregion


func set_attributes(input_: Dictionary) -> void:
	gambler = input_.gambler


func augment_card() -> void:
	var card = gambler.gameboard.hand.cards.get_child(0)
	var chevron = card.chevrons.get_child(0)
	var data = chevron.get_data()
	var methods = Global.dict.conversion.method[data]
	#print([chevron.kind, chevron.type, chevron.subtype, chevron.value.get_number()])
	var limit = 13
	
	for method in methods:
		add_augmentation(chevron, method, limit)


func add_augmentation(chevron_: MarginContainer, method_: String, limit_: int) -> void:
	var data = chevron_.get_data()
	var index = Global.dict.conversion.method[data][method_]
	var description = Global.dict.conversion.index[index]
	
	if limit_ >= description.price:
		var input = {}
		input.workshop = self
		input.chevron = chevron_
		input.method = method_
		input.limit = limit_
		
		var augmentation = Global.scene.augmentation.instantiate()
		augmentations.add_child(augmentation)
		augmentation.set_attributes(input)

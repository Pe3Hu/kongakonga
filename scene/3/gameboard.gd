extends MarginContainer


#region vars
@onready var available = $VBox/Cards/Available
@onready var discharged = $VBox/Cards/Discharged
@onready var broken = $VBox/Cards/Broken
@onready var hand = $VBox/Cards/Hand

var gambler = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	gambler = input_.gambler
	input_.gameboard = self
	
	init_basic_setting(input_)


func init_basic_setting(input_: Dictionary) -> void:
	init_starter_kit_cards()
	
	for key in Global.dict.chain.area:
		if key != null:
			input_.type = key
			var cardstack = get(key)
			cardstack.set_attributes(input_)


func init_starter_kit_cards() -> void:
	for description in Global.dict.deck.starter:
		for _i in description.count:
			add_card(description)


func add_card(description_: Dictionary) -> void:
	var input = {}
	input.gameboard = self
	
	var card = Global.scene.card.instantiate()
	discharged.cards.add_child(card)
	card.set_attributes(input)
	card.gameboard = self
	card.advance_area()
	card.add_chevron(description_)
#endregion

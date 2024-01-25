extends MarginContainer


#region vars
@onready var bg = $BG
@onready var chevrons = $Chevrons

var area = null
var gameboard = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	gameboard = input_.gameboard
	
	init_basic_setting(input_)


func init_basic_setting(input_: Dictionary) -> void:
	var style = StyleBoxFlat.new()
	bg.set("theme_override_styles/panel", style)
	#set_selected(false)
#endregion


func set_selected(selected_: bool) -> void:
	var style = bg.get("theme_override_styles/panel")
	
	match selected_:
		true:
			style.bg_color = Global.color.card.selected
			pass
		false:
			style.bg_color = Global.color.card.unselected


func advance_area() -> void:
	var cardstack = null
	
	if area == null:
		area = Global.dict.chain.area[area]
		advance_area()
	else:
		cardstack = gameboard.get(area)
		cardstack.cards.remove_child(self)
	
		area = Global.dict.chain.area[area]
		cardstack = gameboard.get(area)
		cardstack.cards.add_child(self)
	
	if area == "hand":# and gameboard.gambler.combo != null:
		for cheveron in chevrons.get_children():
			gameboard.gambler.bureau.apply_cheveron(cheveron)


func add_chevron(description_: Dictionary) -> void:
	var input = Dictionary(description_)
	input.card = self
	
	var chevron = Global.scene.chevron.instantiate()
	chevrons.add_child(chevron)
	chevron.set_attributes(input)

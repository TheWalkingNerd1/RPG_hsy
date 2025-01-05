class_name InventorySlotUI extends Button

var slot_data : SlotData : set = set_slot_data

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label

func _ready() -> void:
	texture_rect.texture = null
	label.text = ""
	focus_entered.connect(item_focused)
	focus_exited.connect(item_clear)
	pressed.connect(item_pressed)
	
func set_slot_data(value : SlotData) -> void:
	slot_data = value
	if slot_data == null:
		return 
	texture_rect.texture =  slot_data.item_data.texture
	label.text = str(slot_data.quantity)

func item_focused() -> void:
	if slot_data != null:
		if slot_data.item_data != null:
			Pause.update_item_descrip(slot_data.item_data.description)
	pass
	
func item_clear() -> void:
	Pause.update_item_descrip("")
	pass
	
func item_pressed() -> void:
	if slot_data:
		if slot_data.item_data:
			var was_used = slot_data.item_data.use()
			if was_used == false:
				return
			slot_data.quantity -= 1
			label.text = str(slot_data.quantity)
			

class_name SlotData extends Resource

@export var item_data : Item
@export var quantity : int = 0 : set = set_quantity

func set_quantity(v : int) -> void:
	quantity = v
	if quantity < 1:
		emit_changed()

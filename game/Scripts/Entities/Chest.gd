@tool
class_name Chest extends Node2D

@export var item : Item : set = _set_item_data
@export var quantity : int = 1 : set = _set_quantity

var isOpen : bool = false
@onready var item_s: Sprite2D = $ItemS
@onready var label: Label = $ItemS/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var area_2d: Area2D = $Area2D
@onready var open_status: DataManager = $OpenStatus


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	area_2d.area_entered.connect(_on_area_entered)
	area_2d.area_exited.connect(_on_area_exited)
	open_status.dataLoaded.connect(set_chestStatus)
	_update_label()
	_update_texture()
	set_chestStatus()

func _set_item_data(_item : Item) -> void:
	item = _item
	_update_texture()
	pass

func _set_quantity(_quantity : int) -> void:
	quantity = _quantity
	_update_label()
	pass

func _on_area_entered(_a : Area2D) -> void:
	GloablePlayerManager.Interaction.connect(player_interact)
	pass
	
func _on_area_exited(_a : Area2D) -> void:
	GloablePlayerManager.Interaction.disconnect(player_interact)
	pass
	
func player_interact() -> void:
	if isOpen == true:
		return
	isOpen = true
	open_status.set_value()
	animation_player.play("opening")
	if item and quantity > 0:
		GloablePlayerManager.PLAYER_INVENTORY.add_item(item, quantity)
	else:
		return
	pass
	
func _update_texture() -> void:
	if item and item_s:
		item_s.texture = item.texture
		
func _update_label() -> void:
	if label:
		if quantity <= 1:
			label.text = ""
		else:
			label.text = "x" + str(quantity)

func set_chestStatus() -> void:
	isOpen = open_status.value
	if isOpen:
		animation_player.play("opened")
	else:
		animation_player.play("closed")

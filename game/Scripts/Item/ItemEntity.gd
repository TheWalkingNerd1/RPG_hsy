@tool
class_name ItemEntity extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D

@export var item : Item : set = _set_item_data

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_texture()
	if Engine.is_editor_hint():
		return
	area_2d.body_entered.connect(_on_body_entered)
	
func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	velocity -= velocity * delta * 4
	
func _set_item_data(value : Item) -> void:
	item = value
	_update_texture()

func _on_body_entered(b) -> void:
	if b is Player:
		if item:
			if GloablePlayerManager.PLAYER_INVENTORY.add_item(item) == true:
				item_picked_up()
	pass
	
func item_picked_up() -> void:
	area_2d.body_entered.disconnect(_on_body_entered)
	visible = false
	queue_free()
	pass
	
func _update_texture() -> void:
	if item and sprite_2d:
		sprite_2d.texture = item.texture
	pass
	

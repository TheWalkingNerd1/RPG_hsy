extends Node

const PLAYER = preload("res://Scenes/Player/player.tscn")
const PLAYER_INVENTORY =preload("res://Scenes/UI/Inventory/Inventory.tres")

signal Interaction

var player : Player
var player_spawaned : bool = false

func _ready() -> void:
	add_player_instance()
	await get_tree().create_timer(0.2).timeout
	player_spawaned = true

func add_player_instance() -> void:
	player = PLAYER.instantiate()
	add_child(player)

func set_player_position(_new_pos : Vector2) -> void:
	player.global_position = _new_pos
	
func set_as_parent(_p : Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	_p.add_child(player)

func unparent_player(_p : Node2D) -> void:
	_p.remove_child(player)
	
func set_health(hp : int, max_hp : int) -> void:
	player.maxHp = max_hp
	player.hp = hp
	player.update_hp(0)

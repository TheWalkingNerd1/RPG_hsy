extends Node2D

func _ready() -> void:
	visible = false
	if GloablePlayerManager.player_spawaned == false:
		GloablePlayerManager.set_player_position(global_position)
		GloablePlayerManager.player_spawaned = true

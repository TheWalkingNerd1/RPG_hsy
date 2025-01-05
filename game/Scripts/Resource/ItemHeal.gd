class_name ItemHeal extends ItemEffect

@export var healNum : int = 1

func use() -> void:
	GloablePlayerManager.player.update_hp(healNum)
	

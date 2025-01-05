extends Node

const SAVE_PATH = "user://"

signal game_loaded
signal game_saved

var current_save : Dictionary = {
	scenePath = "",
	player = {
		hp = 1,
		max_hp = 1,
		pos_x = 0,
		pos_y = 0
	},
	items = [],
	persistence = [],
	quests = []
}

func saveGame() -> void:
	update_player_data()
	update_scene_path()
	update_item_data()
	
	var file := FileAccess.open(SAVE_PATH + "save", FileAccess.WRITE)
	var save_json = JSON.stringify(current_save)
	
	file.store_line(save_json)
	game_saved.emit()

func loadGame() -> void:
	var file := FileAccess.open(SAVE_PATH + "save", FileAccess.READ)
	var json = JSON.new()
	json.parse(file.get_line())
	var save_dict : Dictionary = json.data as Dictionary
	current_save = save_dict
	
	LevelManager.loadNewLevel( current_save.scene_path, "", Vector2.ZERO)
	await LevelManager.level_load_started
	
	GloablePlayerManager.set_player_position(Vector2(current_save.player.pos_x, current_save.player.pos_y))
	GloablePlayerManager.set_health(current_save.player.hp, current_save.player.max_hp)
	GloablePlayerManager.PLAYER_INVENTORY.parse_save_data(current_save.items)
	
	await LevelManager.level_loaded
	
	game_loaded.emit()
	
func update_player_data() -> void:
	var p : Player = GloablePlayerManager.player
	current_save.player.hp = p.hp
	current_save.player.max_hp = p.maxHp
	current_save.player.pos_x = p.global_position.x
	current_save.player.pos_y = p.global_position.y

func update_scene_path() -> void:
	var p : String = ""
	for c in get_tree().root.get_children():
		if c is Level:
			p = c.scene_file_path
	current_save.scene_path = p

func update_item_data() -> void:
	current_save.items = GloablePlayerManager.PLAYER_INVENTORY.get_save_data()
	
func add_persistent_data(value : String) -> void:
	if check_psersistent_value(value) == false:
		current_save.persistence.append(value)
	pass
	

func check_psersistent_value(value : String) -> bool:
	var p = current_save.persistence as Array
	return p.has(value)

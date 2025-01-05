extends CanvasLayer

@onready var saveB: Button = $Control/HBoxContainer/Save
@onready var loadB: Button = $Control/HBoxContainer/Load
@onready var description: Label = $Control/Description

signal Shown
signal Hidden

var isPaused : bool = false

func _ready() -> void:
	hide_pause_menu()
	saveB.pressed.connect(_on_save_pressed)
	loadB.pressed.connect(_on_load_pressed)
	pass 

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if isPaused == false:
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled()

func show_pause_menu() -> void:
	get_tree().paused = true
	visible = true
	isPaused = true
	Shown.emit()

func hide_pause_menu() -> void:
	get_tree().paused = false
	visible = false
	isPaused = false
	Hidden.emit()

func _on_save_pressed() -> void:
	if isPaused == false:
		return
	ProgressManager.saveGame()
	hide_pause_menu()
	
func _on_load_pressed() -> void:
	if isPaused == false:
		return
	ProgressManager.loadGame()
	await LevelManager.level_load_started
	hide_pause_menu()
	
func update_item_descrip(_text : String) -> void:
	description.text = _text

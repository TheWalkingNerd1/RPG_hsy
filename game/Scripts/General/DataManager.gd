class_name DataManager extends Node

signal dataLoaded()

var value : bool = false

func _ready() -> void:
	get_value()
	pass
	
func set_value() -> void:
	ProgressManager.add_persistent_data(_get_name())
	pass
	
func get_value() -> void:
	value = ProgressManager.check_psersistent_value(_get_name())
	dataLoaded.emit(value)
	pass

func _get_name() -> String:
	return get_tree().current_scene.scene_file_path + "/" + get_parent().name + "/" + name

class_name DropItem extends Resource

@export var item : Item
@export_range(0, 100, 1, "suffix:%") var probablity : float = 100
@export_range(1, 10, 1, "suffix:items") var minNum : int = 1 
@export_range(1, 10, 1, "suffix:items") var maxNum : int = 1 

func get_drop_count() -> int:
	if randf_range(0, 100) >= probablity:
		return 0
	
	return randi_range(minNum, maxNum)

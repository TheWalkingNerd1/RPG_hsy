class_name HeartGui extends Control

@onready var sprite_2d: Sprite2D = $Sprite2D

var frameNumber : int = 2:
	set(_frameNumber):
		frameNumber = _frameNumber
		update_sprite()

func update_sprite() -> void:
	sprite_2d.frame = frameNumber

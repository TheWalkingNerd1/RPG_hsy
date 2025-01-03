class_name StateMac_walk extends StateMac

@export var move_speed : float = 100.0

@onready var idle: StateMac_idle = $"../idle"
@onready var attack: StateMac_attack = $"../attack"


func enter() -> void:
	player.updateAnimation("walk")
	

func exit() -> void:
	pass
	
func process(_delta : float) -> StateMac:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	
	if player.setDirection():
		player.updateAnimation("walk") 
	
	return null
	
func physics_process(_delta : float) -> StateMac:
	return null
	
func handle_input(_event : InputEvent) -> StateMac:
	if _event.is_action_pressed("attack"):
		return attack
	return null

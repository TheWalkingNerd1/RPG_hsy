class_name EnemyStateWander extends EnemyState

@export var anim_name : String = "walk"
@export var next_state : EnemyState 
@export var walk_speed : float = 20.0

@export_category("AI")
@export var state_duration : float = 0.7
@export var state_cycles_min : int = 1
@export var state_cycles_max : int = 3

var _timer : float = 0.0
var _direction : Vector2

func init() -> void:
	pass

func enter() -> void:
	_timer = randi_range(state_cycles_min, state_cycles_max) * state_duration
	var rand = randi_range(0, 3)
	_direction = enemy.DIR_4[rand]
	enemy.velocity =  _direction * walk_speed
	enemy.setDirection(_direction)
	enemy.updateAnimation(anim_name)
	pass

func exit() -> void:
	pass
	
func process(_delta : float) -> EnemyState:
	_timer -= _delta
	if _timer <= 0:
		return next_state
	return null
	
func physics_process(_delta : float) -> EnemyState:
	return null
	
func handle_input(_event : InputEvent) -> EnemyState:
	return null
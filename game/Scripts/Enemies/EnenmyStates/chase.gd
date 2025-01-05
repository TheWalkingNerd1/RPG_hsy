class_name EnemyStateChase extends EnemyState

@export var anim_name : String = "chase"
@export var next_state : EnemyState 
@export var chase_speed : float = 40.0
@export var turn_rate : float = 0.25

@export_category("AI")
@export var state_duration : float = 0.5
@export var attack_area : HurtBox
@export var vision_area : Vision

var _timer : float = 0.0
var _direction : Vector2
var _peak_player : bool = false

func init() -> void:
	if vision_area:
		vision_area.player_entered.connect(_on_player_entered)
		vision_area.player_exited.connect(_on_player_exited)
	pass

func enter() -> void:
	_timer = state_duration
	enemy.updateAnimation(anim_name)
	
	if attack_area:
		attack_area.monitoring = true
	
	pass

func exit() -> void:
	if attack_area:
		attack_area.monitoring = false
	_peak_player = false
	pass
	
func process(_delta : float) -> EnemyState:
	var new_direction : Vector2 = enemy.global_position.direction_to(GloablePlayerManager.player.global_position)
	_direction = lerp(_direction, new_direction, turn_rate)
	enemy.velocity = _direction * chase_speed
	if enemy.setDirection(_direction):
		enemy.updateAnimation(anim_name)
	
	if _peak_player == false:
		_timer -= _delta
		if _timer <= 0:
			return next_state
	else:
		_timer = state_duration
	return null
	
func physics_process(_delta : float) -> EnemyState:
	return null
	
func handle_input(_event : InputEvent) -> EnemyState:
	return null

func _on_player_entered() -> void:
	_peak_player = true
	if state_machine.current_state is EnemyStateStun:
		return
	state_machine.changeState(self)
	pass
	
func _on_player_exited() -> void:
	_peak_player = false
	pass

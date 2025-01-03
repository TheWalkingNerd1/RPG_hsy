class_name EnemyStateStun extends EnemyState

@export var anim_name : String = "stun"
@export var knockBack_speed : float = 200.0
@export var decelerate_speed : float = 10.0
@export var duration : float = 1.0
@export var next_state : EnemyState 

@export_category("AI")

var _damage_postion : Vector2
var _direction : Vector2
var _animation_finished : bool 

func init() -> void:
	enemy.enemyDamaged.connect(_on_enemy_damaged)
	pass

func enter() -> void:
	_animation_finished = false
	
	_direction = enemy.global_position.direction_to(_damage_postion)
	
	enemy.setDirection(_direction)
	enemy.velocity =  _direction * -knockBack_speed

	enemy.updateAnimation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animatino_finished)
	enemy.make_invulnerable(duration)
	pass

func exit() -> void:
	enemy.animation_player.animation_finished.disconnect(_on_animatino_finished)
	pass
	
func process(_delta : float) -> EnemyState:
	if _animation_finished == true:
		return next_state
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null
	
func physics_process(_delta : float) -> EnemyState:
	return null
	
func handle_input(_event : InputEvent) -> EnemyState:
	return null
	
func _on_enemy_damaged(hurtBox : HurtBox) -> void:
	_damage_postion = hurtBox.global_position
	state_machine.changeState(self)
	
func _on_animatino_finished(_a : String) -> void:
	_animation_finished = true

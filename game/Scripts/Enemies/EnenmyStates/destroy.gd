class_name EnemyStateDestroy extends EnemyState

@export var anim_name : String = "destroy"
@export var knockBack_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")

var _damage_postion : Vector2
var _direction : Vector2

func init() -> void:
	enemy.enemyDestroyed.connect(_on_enemy_destroyed)
	pass

func enter() -> void:
	enemy.invulnerable = true
	
	_direction = enemy.global_position.direction_to(_damage_postion)
	
	enemy.setDirection(_direction)
	enemy.velocity =  _direction * -knockBack_speed

	enemy.updateAnimation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animatino_finished)
	pass

func exit() -> void:
	pass
	
func process(_delta : float) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null
	
func physics_process(_delta : float) -> EnemyState:
	return null
	
func handle_input(_event : InputEvent) -> EnemyState:
	return null
	
func _on_enemy_destroyed(hurtBox : HurtBox) -> void:
	_damage_postion = hurtBox.global_position
	state_machine.changeState(self)
	
func _on_animatino_finished(_a : String) -> void:
	enemy.queue_free()

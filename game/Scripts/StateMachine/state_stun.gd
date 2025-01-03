class_name StateMac_stun extends StateMac

@export var knockBack_speed : float = 200.0
@export var decelerate_speed : float = 10.0
@export var invulnerable_duration : float = 1.0
@export var next_state : EnemyState 

@onready var idle: StateMac_idle = $"../idle"
@onready var attack: StateMac_attack = $"../attack"
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

var hurtBox : HurtBox
var direction : Vector2
var nextState : StateMac = null

func init() -> void:
	player.PlayerDamaged.connect(_player_damaged)

func enter() -> void:
	player.sprite.animation_finished.connect(_animation_finished)
	
	direction = player.global_position.direction_to(hurtBox.global_position)
	player.velocity = direction * -knockBack_speed
	player.setDirection()
	player.updateAnimation("stun")
	
	player.make_invulnerable(invulnerable_duration)
	pass
	
func exit() -> void:
	nextState = null
	player.sprite.animation_finished.disconnect(_animation_finished)
	pass
	
func process(_delta : float) -> StateMac:
	player.velocity -= player.velocity * decelerate_speed * _delta	
	return nextState
	
func physics_process(_delta : float) -> StateMac:
	return null
	
func handle_input(_event : InputEvent) -> StateMac:
	return null
	
func _player_damaged(_hurtBox : HurtBox) -> void:
	hurtBox = _hurtBox
	stateMachine.changeState(self)
	
func _animation_finished() -> void:
	nextState = idle

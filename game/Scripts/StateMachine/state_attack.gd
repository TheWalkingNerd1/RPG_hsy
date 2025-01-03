class_name StateMac_attack extends StateMac

@onready var sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var idle: StateMac_idle = $"../idle"
@onready var walk: StateMac_walk = $"../walk"
@onready var hurt_box: HurtBox = %AttackHurtBox


@export_range(1,20,0.5) var decelerate_speed  : float = 5.0

var attacking : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func enter() -> void:
	player.updateAnimation("attack")
	sprite.animation_finished.connect(endAttack)
	
	attacking = true
	
	await get_tree().create_timer(0.1).timeout
	hurt_box.monitoring = true

func exit() -> void:
	sprite.animation_finished.disconnect(endAttack)
	attacking = false
	hurt_box.monitoring = false
	pass
	
func process(_delta : float) -> StateMac:
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null
	
func physics_process(_delta : float) -> StateMac:
	return null
	
func handle_input(_event : InputEvent) -> StateMac:
	return null

func endAttack() -> void:
	attacking = false

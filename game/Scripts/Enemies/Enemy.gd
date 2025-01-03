class_name Enemy extends CharacterBody2D

signal directionChanged(new_direction : Vector2)
signal enemyDamaged(hurtBox : HurtBox)
signal enemyDestroyed(hurtBox : HurtBox)

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@export var hp : int = 3

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var player : Player
var invulnerable : bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var state_machine: EnemyStateMac = $EnemyStateMachine
@onready var hitbox: HitBox = $Hitbox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.initialize(self)
	player = GloablePlayerManager.player
	hitbox.Damaged.connect(_take_damage)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	move_and_slide()
	
func setDirection(_new_direction : Vector2) -> bool:
	direction = _new_direction
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_direction = DIR_4[direction_id]
	
	if new_direction == cardinal_direction:
		return false
	
	cardinal_direction = new_direction
	directionChanged.emit(new_direction)
	sprite_2d.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func updateAnimation(state : String) -> void:
	animation_player.play(state + "_" + animDirection())

func animDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
		
func _take_damage(hurtBox : HurtBox) -> void:
	if invulnerable == true:
		return
	hp -= hurtBox.damage
	if hp > 0:
		enemyDamaged.emit(hurtBox)
	else:
		enemyDestroyed.emit(hurtBox)
		
func make_invulnerable(_duration : float) -> void:
	invulnerable = true
	hitbox.monitoring = false
	
	await get_tree().create_timer(_duration).timeout
	invulnerable = false
	hitbox.monitoring = true
	pass

class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: HitBox = $Hitbox
@onready var state_machine: PlayerStateMac = $StateMachine


signal DirectionChange(new_direction : Vector2)
signal PlayerDamaged(hurtBox : HurtBox)

var invulnerable : bool = false
var hp : int = 6
var maxHp : int = 6

func _ready() -> void:
	GloablePlayerManager.player = self
	state_machine.initialize(self)	
	hitbox.Damaged.connect(_take_damage)
	update_hp(99)
	
func _process(_delta: float) -> void:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
	
func _physics_process(_delta: float) -> void:
	move_and_slide()

func setDirection() -> bool:
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_direction = DIR_4[direction_id]
	
	if new_direction == cardinal_direction:
		return false
	
	cardinal_direction = new_direction
	DirectionChange.emit(new_direction)
	return true
	
func updateAnimation(state : String) -> void:
	sprite.play(state + "_" + animDirection())

func animDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	elif cardinal_direction == Vector2.RIGHT:
		return "right"
	else:
		return "left"
		
func _take_damage(hurtBox : HurtBox) -> void:
	if invulnerable == true:
		return
	update_hp(-hurtBox.damage)
	if hp > 0:
		PlayerDamaged.emit(hurtBox)
	else:
		PlayerDamaged.emit(hurtBox)
		update_hp(99)
	pass
	
func update_hp(_hp : int) -> void:
	hp = clampi(hp + _hp, 0, maxHp)
	pass
	
func make_invulnerable(_duration : float = 1.0) ->void:
	invulnerable = true
	hitbox.monitoring = false
	
	await get_tree().create_timer(_duration).timeout
	invulnerable = false
	hitbox.monitoring = true
	pass

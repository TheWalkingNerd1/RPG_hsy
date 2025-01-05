class_name StateMac_idle extends StateMac


@onready var attack: StateMac_attack = $"../attack"
@onready var walk: StateMac_walk = $"../walk"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func enter() -> void:
	player.updateAnimation("idle")

func exit() -> void:
	pass
	
func process(_delta : float) -> StateMac:
	if player.direction != Vector2.ZERO:
		return walk;
	player.velocity = Vector2.ZERO
	return null
	
func physics_process(_delta : float) -> StateMac:
	return null
	
func handle_input(_event : InputEvent) -> StateMac:
	if _event.is_action_pressed("attack"):
		return attack
	if _event.is_action_pressed("interaction"):
		GloablePlayerManager.Interaction.emit()
	return null

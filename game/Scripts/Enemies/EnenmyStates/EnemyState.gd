class_name EnemyState extends Node

var enemy : Enemy
var state_machine : EnemyStateMac

func init() -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass
	
func process(_delta : float) -> EnemyState:
	return null
	
func physics_process(_delta : float) -> EnemyState:
	return null
	
func handle_input(_event : InputEvent) -> EnemyState:
	return null
class_name PlayerStateMac extends Node

var states : Array[StateMac]
var prev_state : StateMac
var current_state : StateMac

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	changeState(current_state.process(delta))
	
func _physics_process(delta: float) -> void:
	changeState(current_state.physics_process(delta))
	
func _unhandled_input(event: InputEvent) -> void:
	changeState(current_state.handle_input(event))
	

func changeState(new_state : StateMac) -> void:
	if new_state == null || new_state == current_state:
		return
	if current_state:
		current_state.exit()
		
	prev_state = current_state
	current_state = new_state
	current_state.enter()
	
func initialize(_player : Player) -> void:
	states = []
	for c in get_children():
		if c is StateMac:
			states.append(c)
	
	if states.size() == 0:
		return
		
	states[0].player = _player
	states[0].stateMachine = self
	
	for state in states:
		state.init()
	
	changeState(states[0])
	process_mode = Node.PROCESS_MODE_INHERIT

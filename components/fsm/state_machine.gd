class_name StateMachine
extends Node

# Emitted when the state changes
signal transitioned(state_name)

@export var initial_state: State

@onready var state: State = initial_state

func _ready() -> void:
	await owner.ready
	# Assign state machine and entity references to all children states
	for child in get_children():
		if child is State:
			child.state_machine = self
			child.entity = owner
	
	if state:
		state.enter()

func _unhandled_input(event: InputEvent) -> void:
	if state:
		state.handle_input(event)

func _process(delta: float) -> void:
	if state:
		state.update(delta)

func _physics_process(delta: float) -> void:
	if state:
		state.physics_update(delta)

# Call this to change the active state
func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_name):
		push_error("StateMachine: State not found: " + target_state_name)
		return
	
	var new_state = get_node(target_state_name)
	if not new_state is State:
		return

	if state:
		state.exit()
	
	state = new_state
	state.enter(msg)
	emit_signal("transitioned", state.name)

class_name State
extends Node

# Reference to the state machine that owns this state
var state_machine: StateMachine
# Reference to the entity (e.g., Player, Enemy) that this state belongs to
var entity: Node

# Called when the state is entered
func enter(_msg := {}) -> void:
	pass

# Called when the state is exited
func exit() -> void:
	pass

# Called every physics frame
func physics_update(_delta: float) -> void:
	pass

# Called every process frame
func update(_delta: float) -> void:
	pass

# Called when an input event is received
func handle_input(_event: InputEvent) -> void:
	pass

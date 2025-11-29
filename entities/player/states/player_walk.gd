class_name PlayerWalk
extends PlayerMoveState

func enter(_msg := {}) -> void:
	super.enter(_msg)
	player.animation_player.play("walk")

func physics_update(delta: float) -> void:
	# 1. Only leader handles input and state switching
	if not player.is_leader:
		# Teammates should be in Follow state, not Walk.
		# If they accidentally enter Walk, force them to Idle.
		state_machine.transition_to("Idle")
		return

	super.physics_update(delta) # Call parent to handle movement
	
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Attack")
		return

	# If no input, switch to Idle
	if Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") == Vector2.ZERO:
		state_machine.transition_to("Idle")

class_name PlayerWalk
extends PlayerMoveState

func enter(_msg := {}) -> void:
	super.enter(_msg)
	# player.animation_player.play("walk") # Uncomment when animation exists

func physics_update(delta: float) -> void:
	super.physics_update(delta)
	
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Attack")
		return

	if Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") == Vector2.ZERO:
		state_machine.transition_to("Idle")

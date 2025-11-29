class_name PlayerIdle
extends PlayerMoveState

func enter(_msg := {}) -> void:
	super.enter(_msg)
	player.animation_player.play("idle")

func physics_update(delta: float) -> void:
	super.physics_update(delta)
	
	if not player.is_leader:
		if player.target_to_follow:
			state_machine.transition_to("Follow")
		return
	
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Attack")
		return

	if Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") != Vector2.ZERO:
		state_machine.transition_to("Walk")

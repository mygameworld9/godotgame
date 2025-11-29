class_name PlayerMoveState
extends State

var player: Player
var velocity_component: VelocityComponent

func enter(_msg := {}) -> void:
	player = entity as Player
	velocity_component = player.velocity_component

func physics_update(delta: float) -> void:
	# 1. If not leader, decelerate and return (no input handling)
	if not player.is_leader:
		velocity_component.decelerate(delta)
		velocity_component.move(player)
		return

	# 2. Only leader handles input
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input_direction != Vector2.ZERO:
		velocity_component.accelerate_in_direction(input_direction, delta)
		# Flip sprite
		if input_direction.x != 0:
			player.sprite.flip_h = input_direction.x < 0
	else:
		velocity_component.decelerate(delta)
	
	velocity_component.move(player)

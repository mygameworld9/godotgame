class_name PlayerFollowState
extends State

var player: Player

func enter(_msg := {}) -> void:
	player = entity as Player
	player.animation_player.play("walk")

func physics_update(delta: float) -> void:
	# If we became leader, switch to Idle
	if player.is_leader:
		state_machine.transition_to("Idle")
		return

	if not player.target_to_follow:
		state_machine.transition_to("Idle")
		return
		
	var distance = player.global_position.distance_to(player.target_to_follow.global_position)
	
	if distance > 60.0: # Follow distance
		var direction = (player.target_to_follow.global_position - player.global_position).normalized()
		player.velocity_component.accelerate_in_direction(direction, delta)
		player.velocity_component.move(player)
		
		# Flip sprite
		if player.velocity.x != 0:
			player.sprite.flip_h = player.velocity.x < 0
	else:
		# Close enough, stop and idle (but stay in Follow state or switch to Idle?)
		# Switching to Idle might cause immediate transition back if logic isn't careful.
		# Let's just decelerate here.
		player.velocity_component.decelerate(delta)
		if player.velocity.length() < 10:
			player.animation_player.play("idle")
		else:
			player.animation_player.play("walk")

class_name OrcChase
extends State

var orc: Orc

func enter(_msg := {}) -> void:
	orc = entity as Orc
	orc.animation_player.play("walk")

func physics_update(delta: float) -> void:
	if not orc.target:
		state_machine.transition_to("Idle")
		return

	var direction = (orc.target.global_position - orc.global_position).normalized()
	var distance = orc.global_position.distance_to(orc.target.global_position)

	if distance < 20.0: # Attack range
		state_machine.transition_to("Attack")
	elif distance > 150.0: # Lost aggro
		state_machine.transition_to("Idle")
	else:
		orc.velocity_component.accelerate_in_direction(direction, delta)
		orc.velocity_component.move(orc)
		
		# Flip sprite
		if direction.x != 0:
			orc.sprite.flip_h = direction.x < 0

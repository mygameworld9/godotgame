class_name OrcAttack
extends State

var orc: Orc

func enter(_msg := {}) -> void:
	orc = entity as Orc
	orc.animation_player.play("attack")
	orc.velocity_component.decelerate(0.1)
	
	# Wait for animation to finish
	await orc.animation_player.animation_finished
	state_machine.transition_to("Idle")

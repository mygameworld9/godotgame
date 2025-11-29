extends State

var orc: CharacterBody2D

func enter(_msg := {}) -> void:
	orc = entity as CharacterBody2D
	orc.velocity_component.decelerate(0.1)
	orc.animation_player.play("hurt")
	
	await orc.animation_player.animation_finished
	state_machine.transition_to("Idle")

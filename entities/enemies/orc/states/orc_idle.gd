class_name OrcIdle
extends State

var orc: Orc
var move_timer: float = 0.0

func enter(_msg := {}) -> void:
	orc = entity as Orc
	orc.animation_player.play("idle")
	orc.velocity_component.decelerate(0.1) # Stop moving

func physics_update(delta: float) -> void:
	if orc.target:
		var distance = orc.global_position.distance_to(orc.target.global_position)
		if distance < 100.0: # Chase range
			state_machine.transition_to("Chase")

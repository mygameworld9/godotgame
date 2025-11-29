extends State

var archer: Archer

func enter(_msg := {}) -> void:
	archer = entity as Archer
	archer.velocity_component.decelerate(0.1)
	archer.animation_player.play("idle")

func physics_update(delta: float) -> void:
	if not archer.target:
		return
		
	var distance = archer.global_position.distance_to(archer.target.global_position)
	
	if distance < 200.0 and distance > 100.0: # Keep distance
		state_machine.transition_to("Attack")
	elif distance <= 100.0: # Too close, maybe flee or just attack
		state_machine.transition_to("Attack")
	elif distance < 300.0: # Chase
		state_machine.transition_to("Chase")

extends State

var archer: Archer

func enter(_msg := {}) -> void:
	archer = entity as Archer
	archer.animation_player.play("walk")

func physics_update(delta: float) -> void:
	if not archer.target:
		state_machine.transition_to("Idle")
		return
		
	var direction = (archer.target.global_position - archer.global_position).normalized()
	archer.velocity_component.accelerate_to_player(direction)
	archer.velocity_component.move(archer)
	
	var distance = archer.global_position.distance_to(archer.target.global_position)
	
	if distance < 200.0:
		state_machine.transition_to("Attack")
	elif distance > 400.0:
		state_machine.transition_to("Idle")

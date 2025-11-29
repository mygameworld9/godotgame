extends State

var archer: Archer

func enter(_msg := {}) -> void:
	archer = entity as Archer
	archer.animation_player.play("walk")

func physics_update(delta: float) -> void:
	if not archer.target or not is_instance_valid(archer.target) or archer.target.state_machine.state.name == "Downed":
		archer.target = _find_nearest_player()
		
	if not archer.target:
		state_machine.transition_to("Idle")
		return
		
	var direction = (archer.target.global_position - archer.global_position).normalized()
	archer.velocity_component.accelerate_in_direction(direction, delta)
	archer.velocity_component.move(archer)
	
	var distance = archer.global_position.distance_to(archer.target.global_position)
	
	if distance < 200.0:
		state_machine.transition_to("Attack")
	elif distance > 400.0:
		state_machine.transition_to("Idle")

func _find_nearest_player() -> Node2D:
	var players = get_tree().get_nodes_in_group("player")
	var nearest: Node2D = null
	var min_dist = INF
	
	for p in players:
		if p.state_machine.state.name == "Downed":
			continue
		var dist = archer.global_position.distance_to(p.global_position)
		if dist < min_dist:
			min_dist = dist
			nearest = p
	return nearest

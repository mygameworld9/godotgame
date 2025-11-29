class_name OrcChase
extends State

var orc: Orc

func enter(_msg := {}) -> void:
	orc = entity as Orc
	orc.animation_player.play("walk")

func physics_update(delta: float) -> void:
	if not orc.target or not is_instance_valid(orc.target) or orc.target.state_machine.state.name == "Downed":
		orc.target = _find_nearest_player()
		
	if not orc.target:
		state_machine.transition_to("Idle")
		return
		
	var direction = (orc.target.global_position - orc.global_position).normalized()
	var distance = orc.global_position.distance_to(orc.target.global_position)

	if distance < 30.0: # Attack range
		state_machine.transition_to("Attack")
	elif distance > 300.0: # Lost aggro
		state_machine.transition_to("Idle")
	else:
		orc.velocity_component.accelerate_in_direction(direction, delta)
		orc.velocity_component.move(orc)
		
		# Flip sprite
		if direction.x != 0:
			orc.sprite.flip_h = direction.x < 0

func _find_nearest_player() -> Node2D:
	var players = get_tree().get_nodes_in_group("player")
	var nearest: Node2D = null
	var min_dist = INF
	
	for p in players:
		if p.state_machine.state.name == "Downed":
			continue
		var dist = orc.global_position.distance_to(p.global_position)
		if dist < min_dist:
			min_dist = dist
			nearest = p
	return nearest

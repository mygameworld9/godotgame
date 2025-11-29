extends State

var archer: Archer
var arrow_scene = preload("res://entities/projectiles/arrow.tscn")

func enter(_msg := {}) -> void:
	archer = entity as Archer
	archer.velocity_component.decelerate(0.1)
	archer.animation_player.play("attack")
	
	# Wait for the frame where the arrow should be fired (e.g., 0.3s)
	await get_tree().create_timer(0.3).timeout
	
	if archer.target:
		var arrow = arrow_scene.instantiate()
		arrow.global_position = archer.global_position
		var direction = (archer.target.global_position - archer.global_position).normalized()
		arrow.direction = direction
		arrow.rotation = direction.angle()
		# Add to the main scene, not the archer, so it moves independently
		archer.get_parent().add_child(arrow)
	
	await archer.animation_player.animation_finished
	state_machine.transition_to("Idle")

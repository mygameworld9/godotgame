class_name PlayerAttack
extends State

var player: Player

func enter(_msg := {}) -> void:
	player = entity as Player
	player.animation_player.play("attack")
	
	# Small forward step
	var direction = Vector2.RIGHT if not player.sprite.flip_h else Vector2.LEFT
	player.velocity_component.velocity = direction * 100.0 # Lunging speed
	player.velocity_component.move(player)
	
	player.velocity_component.decelerate(0.1)
	
	await player.animation_player.animation_finished
	state_machine.transition_to("Idle")

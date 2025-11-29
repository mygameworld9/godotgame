extends State

var priest: Priest
var target: CharacterBody2D

func enter(msg := {}) -> void:
	priest = entity as Priest
	if msg.has("target"):
		target = msg.target
	
	priest.velocity_component.decelerate(0.1)
	# Play cast animation (using attack for now if no specific cast anim)
	priest.animation_player.play("attack") 
	
	# Wait for cast
	await get_tree().create_timer(0.5).timeout
	
	if target and is_instance_valid(target):
		target.health_component.heal(10.0) # Heal amount
		# Visual effect?
		print("Priest healed ", target.name)
		
	priest.heal_cooldown = priest.HEAL_COOLDOWN_MAX
	
	await priest.animation_player.animation_finished
	state_machine.transition_to("Idle")

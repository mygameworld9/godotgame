class_name Priest
extends Player

# Inherits from Player to share movement, FSM, etc.
# But we will override some AI logic or add new states.

var heal_cooldown: float = 0.0
const HEAL_COOLDOWN_MAX: float = 5.0

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	if heal_cooldown > 0:
		heal_cooldown -= delta
	
	if not is_leader:
		_check_for_healing()

func _check_for_healing() -> void:
	if heal_cooldown > 0:
		return
		
	# Check squad members
	for member in SquadManager.squad:
		if member == self:
			continue
			
		var health_pct = member.health_component.current_health / member.health_component.max_health
		if health_pct < 0.4 and member.state_machine.state.name != "Downed":
			# Found injured teammate
			# Transition to Heal state (we need to pass the target)
			state_machine.transition_to("Heal", {target = member})
			return

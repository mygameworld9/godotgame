class_name Player
extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var state_machine = $StateMachine
@onready var velocity_component = $VelocityComponent
@onready var health_component = $HealthComponent

var is_leader: bool = false
var target_to_follow: Node2D

func _ready() -> void:
	if health_component:
		health_component.connect("died", _on_died)
	else:
		push_error("HealthComponent missing in " + name)
		
	var hurtbox = get_node_or_null("HurtboxComponent")
	if hurtbox:
		hurtbox.connect("hit", _on_hit)
	else:
		push_error("HurtboxComponent missing in " + name)

var revive_timer: float = 0.0
var revive_target: Player = null
const REVIVE_DURATION: float = 3.0

func _physics_process(delta: float) -> void:
	if is_leader:
		_handle_revive_input(delta)

func _on_hit(damage, source_pos, knockback) -> void:
	if state_machine.state.name == "Downed":
		return
		
	if state_machine.state.name != "Attack":
		animation_player.play("hurt")
		await animation_player.animation_finished
		if state_machine.state.name != "Attack" and state_machine.state.name != "Downed":
			state_machine.transition_to("Idle")

func _on_died() -> void:
	state_machine.transition_to("Downed")

func revive() -> void:
	health_component.current_health = health_component.max_health * 0.5 # Restore 50%
	health_component.emit_signal("health_changed", health_component.current_health, health_component.max_health)
	state_machine.transition_to("Idle")

func _handle_revive_input(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"): # Using Space/Enter for now, or map 'E'
		# Check for nearby downed players
		if not revive_target:
			revive_target = _find_downed_teammate()
		
		if revive_target:
			revive_timer += delta
			print("Reviving: ", revive_timer) # Debug feedback
			if revive_timer >= REVIVE_DURATION:
				revive_target.revive()
				revive_timer = 0.0
				revive_target = null
	else:
		revive_timer = 0.0
		revive_target = null

func _find_downed_teammate() -> Player:
	# FIX: Safety check for InteractionArea to prevent crash if node is missing
	if not has_node("InteractionArea"):
		return null

	var bodies = $InteractionArea.get_overlapping_bodies()
	for body in bodies:
		if body is Player and body != self:
			if body.state_machine.state.name == "Downed":
				return body
	return null

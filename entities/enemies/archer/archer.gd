class_name Archer
extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var state_machine = $StateMachine
@onready var velocity_component = $VelocityComponent
@onready var health_component = $HealthComponent

var target: Node2D

func _ready() -> void:
	target = get_tree().get_first_node_in_group("player")
	
	health_component.connect("died", _on_died)
	$HurtboxComponent.connect("hit", _on_hit)

func _physics_process(delta: float) -> void:
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0

func _on_died() -> void:
	set_physics_process(false)
	velocity_component.velocity = Vector2.ZERO
	animation_player.play("death")
	await animation_player.animation_finished
	queue_free()

func _on_hit(damage, source_pos, knockback) -> void:
	if state_machine.state.name != "Attack":
		animation_player.play("hurt")
		await animation_player.animation_finished
		if state_machine.state.name != "Attack":
			state_machine.transition_to("Idle")

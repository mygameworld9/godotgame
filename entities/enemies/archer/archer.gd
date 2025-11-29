class_name Archer
extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var state_machine = $StateMachine
@onready var velocity_component = $VelocityComponent
@onready var health_component = $HealthComponent

var target: Node2D
var death_effect_scene = preload("res://vfx/death_effect.tscn")

func _ready() -> void:
	target = get_tree().get_first_node_in_group("player")
	
	if health_component:
		health_component.connect("died", _on_died)
	
	var hurtbox = get_node_or_null("HurtboxComponent")
	if hurtbox:
		hurtbox.connect("hit", _on_hit)

func _physics_process(delta: float) -> void:
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0

func _on_died() -> void:
	var effect = death_effect_scene.instantiate()
	get_tree().current_scene.add_child(effect)
	effect.global_position = global_position
	
	queue_free()

func _on_hit(damage, source_pos, knockback) -> void:
	if state_machine.state.name != "Attack":
		animation_player.play("hurt")
		await animation_player.animation_finished
		if state_machine.state.name != "Attack":
			state_machine.transition_to("Idle")

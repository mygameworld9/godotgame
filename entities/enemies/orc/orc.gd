class_name Orc
extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var state_machine = $StateMachine
@onready var velocity_component = $VelocityComponent
@onready var health_component = $HealthComponent
@onready var hitbox_component = $HitboxComponent

# Target to chase (usually the player)
var target: Node2D

func _ready() -> void:
	# For now, find the player in the scene tree. 
	# In a real game, use a detection area or the EventBus to find targets.
	target = get_tree().get_first_node_in_group("player")

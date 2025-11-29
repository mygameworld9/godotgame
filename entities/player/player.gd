class_name Player
extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var state_machine = $StateMachine
@onready var velocity_component = $VelocityComponent
@onready var health_component = $HealthComponent

func _ready() -> void:
	# Initialize components if needed
	pass

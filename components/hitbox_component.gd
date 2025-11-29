class_name HitboxComponent
extends Area2D

@export var damage: float = 10.0
@export var knockback_force: float = 300.0
@export var team: String = "enemy"

func _init() -> void:
	collision_layer = 2
	collision_mask = 0

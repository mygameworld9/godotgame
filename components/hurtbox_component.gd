class_name HurtboxComponent
extends Area2D

signal hit(damage)

@export var health_component: HealthComponent

func _init() -> void:
	collision_layer = 0
	collision_mask = 2

func _ready() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		if health_component:
			health_component.damage(area.damage)
		emit_signal("hit", area.damage)

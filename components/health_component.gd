class_name HealthComponent
extends Node

signal health_changed(new_health, max_health)
signal died

@export var max_health: float = 100.0
var current_health: float

func _ready() -> void:
	current_health = max_health

func damage(amount: float) -> void:
	current_health = max(current_health - amount, 0)
	emit_signal("health_changed", current_health, max_health)
	
	if current_health <= 0:
		emit_signal("died")

func heal(amount: float) -> void:
	current_health = min(current_health + amount, max_health)
	emit_signal("health_changed", current_health, max_health)

class_name HurtboxComponent
extends Area2D

signal hit(damage, source_position, knockback_force)

@export var health_component: HealthComponent
@export var velocity_component: VelocityComponent

func _init() -> void:
	collision_layer = 0
	collision_mask = 2

func _ready() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		if health_component:
			health_component.damage(area.damage)
		
		# Trigger Game Feel
		GameFeel.hit_stop(0.1, 0.1)
		GameFeel.camera_shake(2.0, 0.2)
		
		# Apply Knockback
		if velocity_component:
			var direction = (global_position - area.global_position).normalized()
			velocity_component.velocity = direction * area.knockback_force
			
		emit_signal("hit", area.damage, area.global_position, area.knockback_force)

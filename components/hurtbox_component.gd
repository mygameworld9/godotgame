class_name HurtboxComponent
extends Area2D

signal hit(damage: float, source_pos: Vector2, knockback: float)

@export var health_component: HealthComponent
@export var velocity_component: VelocityComponent
@export var team: String = "player"
var hit_effect_scene = preload("res://vfx/hit_effect.tscn")

func _init() -> void:
	collision_layer = 0
	collision_mask = 2

func _ready() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		if area.team == team:
			return
			
		if health_component:
			health_component.take_damage(area.damage)
		
		emit_signal("hit", area.damage, area.global_position, area.knockback_force)
		
		# Spawn Hit Effect
		var effect = hit_effect_scene.instantiate()
		get_tree().current_scene.add_child(effect)
		effect.global_position = global_position # Or area.global_position for impact point
		
		if velocity_component:
			var direction = (global_position - area.global_position).normalized()
			velocity_component.velocity = direction * area.knockback_force
			
		# GameFeel
		GameFeel.hit_stop(0.1, 0.5)
		GameFeel.shake_camera(2.0)

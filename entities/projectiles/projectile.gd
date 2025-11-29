class_name Projectile
extends Area2D

@export var speed: float = 300.0
@export var damage: float = 5.0
@export var lifetime: float = 3.0

var direction: Vector2 = Vector2.RIGHT

func _ready() -> void:
	# Auto-destroy after lifetime
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	# Destroy on hitting walls (if we had walls with collision)
	# For now, just ignore or destroy
	pass

func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		# Deal damage via the hurtbox
		# The hurtbox handles the hit signal and damage logic
		# We just need to ensure we have a HitboxComponent or similar logic
		# Actually, let's make the projectile contain a HitboxComponent
		queue_free()

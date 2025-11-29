class_name VelocityComponent
extends Node

@export var max_speed: float = 100.0
@export var acceleration: float = 10.0
@export var friction: float = 10.0

var velocity: Vector2 = Vector2.ZERO

func accelerate_to_velocity(target_velocity: Vector2, delta: float) -> void:
	velocity = velocity.lerp(target_velocity, 1.0 - exp(-acceleration * delta))

func accelerate_in_direction(direction: Vector2, delta: float) -> void:
	accelerate_to_velocity(direction * max_speed, delta)

func decelerate(delta: float) -> void:
	accelerate_to_velocity(Vector2.ZERO, delta)

func move(character_body: CharacterBody2D) -> void:
	character_body.velocity = velocity
	character_body.move_and_slide()

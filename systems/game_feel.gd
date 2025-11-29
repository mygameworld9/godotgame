extends Node

# Game Feel System (Juice)
# Handles screen shake, hit stop (freeze frame), and other global effects.

var camera: Camera2D

func _ready() -> void:
	# Find the active camera
	# In a real game, the camera might register itself with this system
	pass

func register_camera(cam: Camera2D) -> void:
	camera = cam

func hit_stop(time_scale: float, duration: float) -> void:
	Engine.time_scale = time_scale
	await get_tree().create_timer(duration * time_scale, true, false, true).timeout
	Engine.time_scale = 1.0

func camera_shake(intensity: float, duration: float) -> void:
	if not camera:
		return
	
	var original_offset = camera.offset
	var elapsed = 0.0
	
	while elapsed < duration:
		var offset_x = randf_range(-intensity, intensity)
		var offset_y = randf_range(-intensity, intensity)
		camera.offset = original_offset + Vector2(offset_x, offset_y)
		
		elapsed += get_process_delta_time()
		await get_tree().process_frame
	
	camera.offset = original_offset

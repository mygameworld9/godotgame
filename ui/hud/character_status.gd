extends Control

@onready var health_bar = $ProgressBar
@onready var highlight = $Highlight
@onready var portrait = $Portrait

var character: CharacterBody2D

func setup(char_node: CharacterBody2D) -> void:
	character = char_node
	character.health_component.connect("health_changed", _on_health_changed)
	
	# Initial update
	health_bar.max_value = character.health_component.max_health
	health_bar.value = character.health_component.current_health
	
	# Connect to SquadManager to check leader status? 
	# Or check in process?
	# Let's check in process for simplicity or use a signal from SquadManager if we added one.

func _process(delta: float) -> void:
	if character and is_instance_valid(character):
		highlight.visible = character.is_leader
	else:
		# Character might be freed?
		pass

func _on_health_changed(current, max_h) -> void:
	health_bar.value = current

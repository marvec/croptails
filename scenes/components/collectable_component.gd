class_name CollectableComponent
extends Area2D

@export var collectable_name: String

@export var bounce_height: float = 20   # How high the log jumps
@export var bounce_duration: float = 0.2  # Time to reach the peak
@export var bounce_damping: float = 0.5   # Damping for the second bounce
@export var sideways_bounce: float = 5  # How far it moves sideways
@export var should_bounce: bool = false

var is_collectible = true
var original_position: Vector2

func _ready():
	if should_bounce:
		bounce_effect()

func bounce_effect():
	is_collectible = false

	var parent = get_parent()
	original_position = parent.position
	
	# Determine bounce direction (left or right)
	var direction = sign(original_position.x - PlayerManager.position.x)
	if direction == 0:
		direction = 1  # Default to right if perfectly aligned
	
	# Calculate target horizontal position (full sideways movement spread across both phases)
	var target_x = original_position.x + (sideways_bounce * direction)
	
	var tween = parent.create_tween().set_parallel(true)
	# First jump (upwards and sideways)
	tween.tween_property(parent, "position:y", original_position.y - bounce_height, bounce_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(parent, "position:x", original_position.x + (sideways_bounce * 0.5 * direction), bounce_duration)	.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	# Fall back down
	tween.chain().tween_property(parent, "position:y", original_position.y, bounce_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(parent, "position:x", target_x, bounce_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	# Smaller bounce
	tween.chain().tween_property(parent, "position:y", original_position.y - (bounce_height * bounce_damping), bounce_duration * 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	# Settle back down
	tween.chain().tween_property(parent, "position:y", original_position.y, bounce_duration * 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

	is_collectible = true


func _on_body_entered(body: Node2D) -> void:
	if body is Player && is_collectible:
		InventoryManager.add_collectable(collectable_name)
		#print("Collected: " + collectable_name)
		get_parent().queue_free()

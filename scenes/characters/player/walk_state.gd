extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 50

func _unhandled_input(event: InputEvent) -> void:
	player.walk_direction = GameInputEvents.get_movement_input(event)

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	if player.walk_direction != Vector2.ZERO:
		player.player_direction = player.walk_direction

	PlayerAnimations.play_animation(player, animated_sprite_2d, "walk")
			
	player.velocity = player.walk_direction * speed
	player.move_and_slide()

func _on_next_transitions() -> void:
	if player.walk_direction == Vector2.ZERO:
		transition.emit("Idle")

func _on_enter() -> void:
	pass

func _on_exit() -> void:
	animated_sprite_2d.stop()

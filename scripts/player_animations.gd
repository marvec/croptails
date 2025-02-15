class_name PlayerAnimations

static func play_animation(player: Player, sprite: AnimatedSprite2D, prefix: String):
	match player.player_direction:
		Vector2.LEFT:
			sprite.play(prefix + "_left")
		Vector2.RIGHT:
			sprite.play(prefix + "_right")
		Vector2.UP:
			sprite.play(prefix + "_back")
		Vector2.DOWN, _:
			sprite.play(prefix + "_front")	

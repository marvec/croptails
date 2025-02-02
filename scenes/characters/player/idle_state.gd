extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@onready var hit_component: HitComponent = $"../../HitComponent"

var next_transition: String = ""

func _unhandled_input(event: InputEvent) -> void:
	if GameInputEvents.is_use_tool(event):
		match hit_component.current_tool:
			DataTypes.Tools.AxeWood:
				next_transition = "Chopping"
			DataTypes.Tools.TillGround:
				next_transition = "Tilling"
			DataTypes.Tools.WaterCrops:
				next_transition = "Watering"

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	player.walk_direction = GameInputEvents.movement_input()
	PlayerAnimations.play_animation(player, animated_sprite_2d, "idle")

func _on_next_transitions() -> void:
	if player.walk_direction != Vector2.ZERO:
		transition.emit("Walk")

	if next_transition != "":
		transition.emit(next_transition)

func _on_enter() -> void:
	next_transition = ""

func _on_exit() -> void:
	next_transition = ""
	animated_sprite_2d.stop()

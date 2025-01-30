extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@onready var hit_component: HitComponent = $"../../HitComponent"

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	PlayerAnimations.play_animation(player, animated_sprite_2d, "idle")


func _on_next_transitions() -> void:
	GameInputEvents.movement_input()
	
	if GameInputEvents.is_movement_input():
		transition.emit("Walk")

	if player.is_use_tool(): #GameInputEvents.use_tool():
		match hit_component.current_tool:
			DataTypes.Tools.AxeWood:
				transition.emit("Chopping")
			DataTypes.Tools.TillGround:
				transition.emit("Tilling")
			DataTypes.Tools.WaterCrops:
				transition.emit("Watering")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()

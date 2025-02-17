class_name Player
extends CharacterBody2D

@onready var hit_component: HitComponent = $HitComponent
@onready var hit_component_collision_shape_2d: CollisionShape2D = $HitComponent/HitComponentCollisionShape2D
@export var current_tool: DataTypes.Tools = DataTypes.Tools.None

var player_direction: Vector2
var walk_direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	ToolManager.tool_selected.connect(on_tool_selected)
	
func on_tool_selected(tool: DataTypes.Tools) -> void:
	current_tool = tool
	hit_component.current_tool = tool
	
func _process(delta: float) -> void:
	PlayerManager.position = position

class_name Player
extends CharacterBody2D

@onready var hit_component: HitComponent = $HitComponent

@export var current_tool: DataTypes.Tools = DataTypes.Tools.None

var player_direction: Vector2

var use_tool: bool = false

func _ready() -> void:
	ToolManager.tool_selected.connect(on_tool_selected)
	
func on_tool_selected(tool: DataTypes.Tools) -> void:
	current_tool = tool
	hit_component.current_tool = tool

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("hit"):
		use_tool = true

func is_use_tool() -> bool:
	var cache = use_tool
	use_tool = false
	return cache

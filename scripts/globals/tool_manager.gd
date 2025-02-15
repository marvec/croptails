extends Node

var selected_tool: DataTypes.Tools = DataTypes.Tools.None

signal tool_selected(tool: DataTypes.Tools)

func select_tool(tool: DataTypes.Tools) -> void:
	tool_selected.emit(tool)
	selected_tool = tool

func tool_position(direction: Vector2) -> Vector2:
	match direction:
		Vector2.RIGHT:
			return Vector2(9, 0)
		Vector2.LEFT:
			return Vector2(-9, 0)
		Vector2.DOWN:
			return Vector2(0, 3)
		Vector2.UP:
			return Vector2(0, -18)
	
	return Vector2.ZERO

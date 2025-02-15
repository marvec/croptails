extends PanelContainer

@onready var tool_axe: Button = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_tilling: Button = $MarginContainer/HBoxContainer/ToolTilling
@onready var tool_watering_can: Button = $MarginContainer/HBoxContainer/ToolWateringCan
@onready var tool_corn: Button = $MarginContainer/HBoxContainer/ToolCorn
@onready var tool_tomato: Button = $MarginContainer/HBoxContainer/ToolTomato

var buttons: Array[Button]

func _ready() -> void:
	buttons = [ tool_axe, tool_tilling, tool_watering_can, tool_corn, tool_tomato ]


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("unselect_tool"):
		ToolManager.select_tool(DataTypes.Tools.None)
		_on_tool_toggled(false, -1)
		
	if event.is_action_pressed("select_tool_axe"):
		_on_tool_toggled(true, 0)
		buttons[0].button_pressed = true
	elif event.is_action_pressed("select_tool_tilling"):
		_on_tool_toggled(true, 1)
		buttons[1].button_pressed = true
	elif event.is_action_pressed("select_tool_watering"):
		_on_tool_toggled(true, 2)
		buttons[2].button_pressed = true


func _on_tool_toggled(toggled_on: bool, index: int) -> void:
	if toggled_on:
		ToolManager.select_tool(DataTypes.Tools.values()[index + 1])
	elif DataTypes.Tools.values().find(ToolManager.selected_tool) - 1 == index:
		ToolManager.select_tool(DataTypes.Tools.None)

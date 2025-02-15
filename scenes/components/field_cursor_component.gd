class_name FieldCursorComponent
extends Node

@export var grass_tilemap_layer: TileMapLayer
@export var soil_tilemap_layer: TileMapLayer
@export var terrain_set: int = 0
@export var terrain: int = 1

@onready var player: Player = get_tree().get_first_node_in_group("player")

var mouse_position: Vector2
var cell_position: Vector2i
var cell_source_id: int
var local_cell_position: Vector2
var distance: float

func _unhandled_input(event: InputEvent) -> void:
	if ToolManager.selected_tool == DataTypes.Tools.TillGround && event.is_action_pressed("hit"):
		if event is InputEventKey:
			till_ground_under_player()
		else:
			till_ground_under_mouse()


func till_ground_under_player() -> void:
	cell_position = grass_tilemap_layer.local_to_map(player.global_position + ToolManager.tool_position(player.player_direction))
	cell_source_id = grass_tilemap_layer.get_cell_source_id(cell_position)
	local_cell_position = grass_tilemap_layer.map_to_local(cell_position)

	if cell_source_id != -1:
		soil_tilemap_layer.set_cells_terrain_connect([cell_position], terrain_set, terrain, true)

func till_ground_under_mouse() -> void:
	mouse_position = grass_tilemap_layer.get_local_mouse_position()
	cell_position = grass_tilemap_layer.local_to_map(mouse_position)
	cell_source_id = grass_tilemap_layer.get_cell_source_id(cell_position)
	local_cell_position = grass_tilemap_layer.map_to_local(cell_position)
	distance = player.global_position.distance_to(local_cell_position)

	if distance < 20.0 && cell_source_id != -1:
		soil_tilemap_layer.set_cells_terrain_connect([cell_position], terrain_set, terrain, true)

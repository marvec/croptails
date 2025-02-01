extends PanelContainer

@onready var log_label: Label = $MarginContainer/VBoxContainer/Logs/LogLabel
@onready var stone_label: Label = $MarginContainer/VBoxContainer/Stone/StoneLabel
@onready var corn_label: Label = $MarginContainer/VBoxContainer/Corn/CornLabel
@onready var tomato_label: Label = $MarginContainer/VBoxContainer/Tomato/TomatoLabel
@onready var egg_label: Label = $MarginContainer/VBoxContainer/Egg/EggLabel
@onready var milk_label: Label = $MarginContainer/VBoxContainer/Milk/MilkLabel

var labels: Dictionary

func _ready() -> void:
	labels = { 
		"log": log_label, "stone": stone_label, "corn": corn_label, "tomato": tomato_label,
		"egg": egg_label, "milk": milk_label
		}
	InventoryManager.inventory_changed.connect(on_inventory_changed)

func on_inventory_changed() -> void:
	var inventory: Dictionary = InventoryManager.inventory
	
	for item in labels:
		check_inventory(inventory, item, labels[item])
	

func check_inventory(inventory: Dictionary, name: String, label: Label) -> void:
	if inventory.has(name):
		label.text = str(inventory[name])

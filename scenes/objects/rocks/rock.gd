extends Sprite2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent
@onready var spark_effect: CPUParticles2D = $SparkEffect

var stone_scene = preload("res://scenes/objects/rocks/stone.tscn")

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)
	
func on_hurt(hit_damage: int) -> void:
	damage_component.apply_damage(hit_damage)
	await get_tree().create_timer(0.5).timeout
	spark_effect.emitting = true
	
func on_max_damage_reached() -> void:
	await get_tree().create_timer(0.5).timeout
	call_deferred("add_stone_scene")
	queue_free()
	
func add_stone_scene() -> void:
	var stone_instance = stone_scene.instantiate() as Node2D
	stone_instance.global_position = global_position + Vector2(0, 3)
	get_parent().add_child(stone_instance)

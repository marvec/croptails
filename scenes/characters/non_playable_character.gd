class_name NonPlayableCharacter
extends CharacterBody2D

@export var min_walk_cycle: int = 2
@export var max_walk_cycle: int = 6
@export var min_idle_cycle: float = 2.0
@export var max_idle_cycle: float = 6.0

var walk_cycles: int
var current_walk_cycle: int

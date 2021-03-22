extends Node2D

export var enemies = []
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func on_timer():
	if !enemies.size(): return
	var enemy = enemies[rng.randi_range(0, enemies.size() - 1)].instance()
	get_node("..").add_child(enemy)
	enemy.position = position
	enemy.z_index = position.y

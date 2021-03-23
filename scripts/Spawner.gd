extends Node2D
class_name Spawner

export var enemies = []
export (float) var interval = 5
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var timer = Timer.new()
	add_child(timer)
	timer.start(interval)
	timer.connect("timeout", self, "_on_timer")

func _on_timer():
	if !enemies.size(): return
	var enemy = enemies[rng.randi_range(0, enemies.size() - 1)].instance()
	get_node("..").add_child(enemy)
	enemy.position = position
	enemy.z_index = position.y

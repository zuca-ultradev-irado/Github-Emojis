extends Node2D

@export var coin_scene: PackedScene
@export var playtime: int = 30

var level: int = 1
var score: int = 0
var time_left: int = 0
var screensize: Vector2 = Vector2.ZERO

var playing: bool = false

func _ready() -> void:
	screensize = get_viewport().get_visible_rect().size
	$Player.screensize = screensize
	new_game()

func new_game() -> void:
	playing = true
	level = 1
	score = 0
	time_left = playtime
	
	$Player.start()
	$Player.show()
	$Timer.start()
	
	spawn_coins()

func spawn_coins() -> void:
	for i in range(level + 4):
		var c = coin_scene.instantiate()
		add_child(c)
		c.screensize = screensize
		c.position = Vector2(
			randi_range(0, int(screensize.x)),
			randi_range(0, int(screensize.y))
		)

func _process(_delta: float) -> void:
	if playing and get_tree().get_nodes_in_group("coins").size() == 0:
		level += 1
		time_left += 5
		spawn_coins()

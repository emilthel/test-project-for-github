extends Sprite2D

@onready var player: Player = $Player
@onready var spawn_timer = $SpawnTimer2

var t = 0
var is_waiting_on_reload = false

const ENEMY_SCENE = preload("res://enemy.tscn")

func _ready():
	if not visible:
		set_process(false)
	else:
		spawn_timer.start()
		
func random_pixel():
	var screensize = get_viewport().get_visible_rect().size
	var x = screensize.x 
	var y = screensize.y
	return Vector2(randi_range(0,x), randi_range(0,y))
	
func spawn_enemy():
	var enemy2 = ENEMY_SCENE.instantiate()
	enemy2.global_position = random_pixel()
	enemy2.player = player
	add_child(enemy2)
	return enemy2
	


func _on_spawn_timer_timeout() -> void:
	print("Spawn timeout")
	var enemy = spawn_enemy()

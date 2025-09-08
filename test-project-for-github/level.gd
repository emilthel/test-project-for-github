extends Sprite2D

@onready var player: Player = $Player
@onready var gibble = $Gibble
var t = 0
var is_waiting_on_reload = false

const ENEMY_SCENE = preload("res://enemy.tscn")

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
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.connect("dead",_on_player_dead)
	#var enemy = spawn_enemy()
	#enemy.connect("despawn", _on_enemy_despawn)
	
#func _on_enemy_despawn():
	#var enemy = spawn_enemy()
	#enemy.connect("despawn", _on_eney_despawn)
	#print(enemy.position)
	
#Problem: Impossible to connect to spawned enemies
#func _on_player_dead() -> void:
	#pass # Replace with function body.

func _process(delta: float) -> void:
	if is_waiting_on_reload:
		t += delta
		if 0.5 <= t:
			get_tree().reload_current_scene() 
		
			
#Lyssna på dead-signalen från player
func _on_player_dead() -> void:
	#Method 1: Wait new timer
	#await get_tree().create_timer(0.5).timeout 
	#get_tree().reload_current_scene() 
	
	#Method 2: Start premade timer
	$RestartTimer.start()
	
	#Method 3: Manual
	#is_waiting_on_reload = true
	
func _on_restart_timer_timeout() -> void: #If pause
	get_tree().reload_current_scene() 


func _on_spawn_timer_timeout() -> void:
	print("Spawn timeout")
	var enemy = spawn_enemy()

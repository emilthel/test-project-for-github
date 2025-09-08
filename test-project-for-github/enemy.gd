extends CharacterBody2D #Ta aldrig bort!
class_name Enemy

const MAX_SPEED = 200
const ACC = 1500

var t: float = 0
var t_max = 3

var invincible = true

signal despawn

#Kommer definieras av förälder som har åtkomst till sina barn. 
#Syskon ska inte styra varandra
var player

func _ready() -> void:
	if not visible:
		set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	t += 1*delta
	if t_max < t:
		emit_signal("Despawn")
		queue_free()
				
	if player: #if player exists
		var direction_to_player = global_position.direction_to(player.global_position)
		velocity = velocity.move_toward(direction_to_player*MAX_SPEED, ACC*delta)
		move_and_slide()
		

#Anropas automatiskt när en kollisionskropp (Player) overlappar arean
func _on_player_detect_area_body_entered(body) -> void:
	if body is Player and not invincible:
		body.die()


#Invincibility runs out
func _on_inv_timer_timeout() -> void:
	invincible = false
	modulate = Color(1, 0, 0, 1)
	

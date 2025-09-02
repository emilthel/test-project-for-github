extends CharacterBody2D #Ta aldrig bort!
class_name Enemy

const MAX_SPEED = 400
const ACC = 1500

#Kommer definieras av förälder som har åtkomst till sina barn. 
#Syskon ska inte styra varandra
var player

func _ready() -> void:
	if not visible:
		set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if player: #if player exists
		var direction_to_player = global_position.direction_to(player.global_position)
		velocity = velocity.move_toward(direction_to_player*MAX_SPEED, ACC*delta)
		move_and_slide()


#Anropas automatiskt när en kollisionskropp (Player) overlappar arean
func _on_player_detect_area_body_entered(body) -> void:
	if body is Player:
		print("Dead")
		body.die()

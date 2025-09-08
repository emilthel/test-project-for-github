extends CharacterBody2D
class_name Player

signal dead

var exploding = false

const MAX_SPEED = 400
const ACC = 1500


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not visible:
		set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
	# _physics_process = constant fps. with process
	# process = often faster
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	#velocity är fördefinierad av godot och är knuten till noden CharacterBody
	velocity = velocity.move_toward(direction*MAX_SPEED, ACC*delta)
	
	#Rör spelobjektet enligt velocity-vektorn och hanterar kollision
	move_and_slide()
	
	if exploding:
		scale.x += 10*delta
		scale.y += 10*delta
		print(scale.x)
		modulate *= Color(1.1,1.1,1.1,0.9)


func die():
	emit_signal("dead")
	exploding = true

extends Area2D
class_name Gibble

@onready var level = get_parent()
var child

#Movement
@export var speed: float = 400
var angle = 0

func move(delta: float):
	var direction = Vector2(cos(angle),sin(angle))
	var velocity = speed*direction
	position += velocity * delta

func softmax(x, cap: float):
	if cap < x:
		return x
	else:
		return cap
		
var mutation_rate = 0.2

func spawn():
		var child = duplicate()
		child.angle = angle+PI*randf_range(0.8,1.2)
		child.level = level
		child.max_mass = softmax(max_mass + randf_range(-mutation_rate,mutation_rate),0.2)
		#child.mutation_rate = abs(mutation_rate + randf_range(-mutation_rate,mutation_rate))
		level.add_child(child)
		return child
	
@export var max_mass: float = 0.4
var mass = max_mass / 2
var scale_factor = 1
@export var fertile = false

func _physics_process(delta: float) -> void:
	var delta2 = delta * 0.5
	move(delta2)
	mass += 1 * delta2
	scale = Vector2(1,1)*scale_factor*mass
	if max_mass < mass:
		mass = max_mass/2
		if fertile:
			child = spawn()
	var screensize = get_viewport().size
	#Despawns if not on screen
	if position.x < 0 or screensize.x < position.x:
		queue_free()
	if position.y < 0 or screensize.y < position.y:
		queue_free() 

	
	

#Eats gibbles smaller than self, which are not parents or children. Predator gains prey's mass
func _on_area_entered(area: Area2D) -> void:
	if area == child or area.child == self:
		pass
	else:
		if mass < area.mass:
			queue_free()
			area.mass += mass/2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not visible:
		set_process(false)
	modulate.h = (0.4+max_mass)/3
	print(modulate.h)
	modulate.s = 1

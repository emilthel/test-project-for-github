extends Area2D

#var velocity = Vector2(100,0)
#var rng = RandomNumberGenerator.new()

#var mass = 100
#var max_mass = mass*2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var scalefactor = mass/100
	#scale = Vector2(scalefactor,scalefactor)
	
	#position += velocity * delta
	#mass += 100 * delta
	#if max_mass < mass:
		#mass -= (max_mass/2)
		#var child = duplicate()
		#child.velocity *= -1
	pass

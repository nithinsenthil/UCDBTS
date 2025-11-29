@abstract
class_name Sensor
extends RayCast2D

var _brain : Brain
var _sensitivity : float = 1.0


func _ready() -> void:
	_brain = $"../Brain"
	self.enabled = false
	self.exclude_parent = true
	self.collide_with_areas = false
	self.collide_with_bodies = true


# To be invoked on signals
func _on_sense(source: Vector2, strength: float) -> void:
	var distanceSq = global_position.distance_squared_to(source)
	distanceSq = distanceSq / 1000 # TODO scale by some other unit
	
	# Intensity decays with the inverse square of distance
	var new_suspicion: float = strength / distanceSq
	
	self.target_position = source
	self.force_raycast_update()
	
	# TODO: perhaps implement half-effective obstacles? e.g. a tree, a low wall
	# TODO: get a reference to the player via SceneManager and add it to the exclude list
	if self.is_colliding() and not self.get_collider().to_string().contains("Player"):
		new_suspicion = 0.0
	
	# The intensity is proportional to the sensor's sensitivity
	_brain.suspicion += new_suspicion * _sensitivity

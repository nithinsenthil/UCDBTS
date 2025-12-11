class_name Mouth
extends CollisionObject2D

const MAX_SENS: float = 1.0
const MIN_SENS: float = 0.0
const MEAN_SENS: float = 0.5
const STDEV_SENS: float = 0.2

var _sensitivity: float = 1.0
var _brain: Brain
var _npc: NPC


func _ready() -> void:
	var c: CollisionShape2D = get_node("CollisionShape2D")
	c.apply_scale(_sensitivity * Vector2.ONE)
	_brain = $"../Brain"
	_npc = $".."


# Talk to nearby NPCs if suspicious. Sharing suspicion reduces an NPC's own
func _on_body_entered(body: Node2D) -> void:
	if body is not NPC:
		return
	
	# Don't talk if not suspicious
	if _brain.suspicion < 0.5 * _brain._maximum_suspicion:
		return
	
	# Chance to avoid speaking proportional to the npcs' joint sensitivity
	if randf() < _sensitivity * (body.get_node("Mouth") as Mouth)._sensitivity:
		return
	
	_brain.suspicion -= (0.25 * _sensitivity) * _brain.suspicion
	
	# Only spread suspicion to NPCs with less suspicion to prevent runaway gossip
	if (body.get_node("Brain").suspicion < 0.5 * _brain.suspicion):
		body.get_node("Brain").suspicion += (0.5 * _sensitivity) * _brain.suspicion
	
	_npc._on_talk(body)

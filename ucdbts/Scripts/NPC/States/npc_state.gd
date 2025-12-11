@abstract
class_name NPCState
extends Node

var expired: bool = false

var _timeout: float = 5.0
var _timer: float = 0.0
var _npc: NPC


@abstract
func _on_talk(npc: NPC) -> NPCState


@abstract
func _on_tired(npc: NPC) -> NPCState


@abstract
func _on_recovered(npc: NPC) -> NPCState


func _init(npc: NPC) -> void:
	_npc = npc


func _physics_process(delta: float) -> void:
	_timer += delta
	if _timer > _timeout:
		expired = true

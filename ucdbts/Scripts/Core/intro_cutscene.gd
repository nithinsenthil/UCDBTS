extends Node

const _radius: float = 160.0
const _angular_velocity: float = 0.02 * PI

var _apparitions: Array[Node2D]
var _angle: float = 0.0
var _elapsed: float = 0.0
var _exited: bool = false
var _exiting: bool = false
var _monologue_text: Array[String] = [
	"The same day again.",
	"The same faces.",
	"This feels like heaven!"
]
@onready var _monologue: Label = $Monologue


func _ready() -> void:
	for c in get_children():
		if c is Camera2D \
			or c is AnimatedSprite2D \
			or c is Label \
			or c is AudioManager \
			or "Background" in c.to_string():
			continue
		
		_apparitions.append(c)
	
	_apparitions.shuffle()
	
	_monologue.text = _monologue_text[0]


func _process(delta: float) -> void:
	if not _exited and (_exiting or Input.is_anything_pressed()):
		SceneManager.load_new_scene("res://Scenes/level_1.tscn", "fade_to_black")
		_exited = true
	
	_elapsed += delta
	
	# Text timing
	if _elapsed > 20.0:
		_exiting = true
	elif _elapsed > 12.0:
		_monologue.text = _monologue_text[2]
	elif _elapsed > 10.0:
		_monologue.text = ""
	elif _elapsed > 6.0:
		_monologue.text = _monologue_text[1]
	elif _elapsed > 4.0:
		_monologue.text = ""
	
	# Rotate apparitions
	var i = 0
	for apparition in _apparitions:
		var a = _angle + (2 * PI * i / (_apparitions.size() as float))
		apparition.global_position = _radius * Vector2(cos(a), sin(a))
		i += 1
	
	_angle += delta * _angular_velocity

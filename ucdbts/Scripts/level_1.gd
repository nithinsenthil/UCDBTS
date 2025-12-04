extends Node

var timer: Timer
@onready var audio_manager: AudioManager = $AudioManager
@onready var player: AudioStreamPlayer2D = $AudioManager/Background/Level

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = 0.5
	timer.one_shot = true
	timer.timeout.connect(_check_music)
	add_child(timer)
	timer.start()
	player.playing = false


func _check_music():
	#var audio_manager: AudioManager = $AudioManager
	#var player: AudioStreamPlayer2D = $AudioManager/Background/TitleScreen
	if player == null:
		return
	elif !player.playing:
		audio_manager.fade_music_in(player, -10)
	
	timer.start()

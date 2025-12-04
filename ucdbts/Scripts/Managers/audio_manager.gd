class_name AudioManager
extends Node2D

const mute_db := -80.0 # To mute the audio player
const default_music_db := 0.0 # This is for normal volume
const fade_time := 2.0 # The time it takes to fade in/out in seconds

var current_music_player : AudioStreamPlayer2D # the current player


func _ready() -> void:
	signals.player_step.connect(_on_player_step)
	signals.button_click.connect(_on_button_click)
	current_music_player = $Background/TitleScreen


func fade_music_in(track: AudioStreamPlayer2D, default_db: float) -> void:
	current_music_player = track # Specify the song
	current_music_player.volume_db = mute_db # Mute the player
	current_music_player.play() # Start playing
	# Use tweens for transition:
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(current_music_player, "volume_db", default_db, fade_time)


func fade_music_out() -> void:
	if current_music_player != null:
		print("EASING OUT")
		var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
		tween.tween_property(current_music_player, "volume_db", mute_db, fade_time)
# func _ready() -> void:

	#audio_manager = $AudioManager
	#if audio_manager == null:
		#audio_manager = load("res://Scripts/Managers/audio_manager.gd")
		#add_child(audio_manager)


func _on_player_step():
	$Player/PlayerStep.play()

func _on_button_click():
	$Effects/MenuButtonClick.play()

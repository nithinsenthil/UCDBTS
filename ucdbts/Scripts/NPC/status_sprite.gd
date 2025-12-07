extends Sprite2D


var exclamation_fx = preload("res://Assets/particles/exclamation_particle.png")
var question_fx = preload("res://Assets/particles/question_particle.png")
var current_timeout: float = 0


func _show_fx(duration: float, image: Resource) -> void:
	texture = image
	current_timeout = duration


func show_exclamation() -> void:
	_show_fx(3, exclamation_fx)
	

func show_question() -> void:
	_show_fx(3, question_fx)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_timeout > 0:
		current_timeout -= delta
		if current_timeout <= 0:
			texture = null

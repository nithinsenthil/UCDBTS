extends CanvasGroup

@onready var exit_button: TextureButton = $TextureButton

func _ready():
	visible = true

func _process(_delta):
	if Input.is_action_just_pressed("ControlMenu"):
		visible = !visible

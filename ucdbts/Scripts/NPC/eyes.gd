class_name Eyes
extends Sensor

const MAX_SENS: float = 1.0
const MIN_SENS: float = 0.0
const MEAN_SENS: float = 0.8
const STDEV_SENS: float = 0.1

# Assume 120-degree viewing angle (calculate 60 degrees from center)
var dot_product_of_max_viewing_angle: float = Vector2.from_angle(0).dot(Vector2.from_angle(PI / 3.0))
@onready var npc: Character = get_node("..")


func _ready() -> void:
	signals.player_visually_sus.connect(_on_sense)
	super()


func _on_sense(source: Vector2, strength: float) -> void:
	# Only sense if source is within viewing angle
	var facing: Vector2
	
	match npc._facing:
		npc.Facing.LEFT:
			facing = Vector2.LEFT
		npc.Facing.RIGHT:
			facing = Vector2.RIGHT
		npc.Facing.UP:
			facing = Vector2.UP
		npc.Facing.DOWN:
			facing = Vector2.DOWN
		
	var dot_product_to_source = facing.dot(source - global_position)
	if (dot_product_to_source > dot_product_of_max_viewing_angle):
		super(source, strength)

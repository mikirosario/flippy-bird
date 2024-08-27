extends Node

const MAXHEIGHT = -280.0
const MINHEIGHT = 165

var rng = RandomNumberGenerator.new()

func _ready():
	rng.seed = Time.get_unix_time_from_system()

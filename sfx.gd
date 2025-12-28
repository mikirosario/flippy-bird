extends Node
class_name SFXPlayer

@export var pop_sfx: AudioStream

var pool_size: int = Constants.MAX_BALLOONS
var players: Array[AudioStreamPlayer] = []
var index = 0

func _ready():
	for i in pool_size:
		var p := AudioStreamPlayer.new()
		p.stream = pop_sfx
		p.bus = "SFX"
		add_child(p)
		players.append(p)

func play_pop():
	var p := players[index]
	index = (index + 1) % players.size()
	p.play()

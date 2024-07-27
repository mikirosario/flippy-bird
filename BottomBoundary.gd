#This used to go on a collider that followed the player, but it's deprecated.
#Leaving it in case I reuse it elsewhere.
#If the mechanic doesn't come back, remove.
extends StaticBody2D

@export var player: Node2D
var collision_shape: SegmentShape2D

func _ready():
	collision_shape = get_node("CollisionShape2D").shape

 # Positions the collider at half of the collision shape's width behind the player
func _process(_delta):
	if player:
		position.x = player.position.x - (collision_shape.b.x - collision_shape.b.x * 0.5)

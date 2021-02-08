extends Area

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = get_node("/root/MainScene/Player")
var entered : bool = false 
var open : bool = false 
var locked : bool = true 
# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Door_body_entered (body):
	# did the player enter our collider?
	# if so give the stats and destroy the pickup
	if body.name == "Player":
		entered=true

func _on_Door_body_exited (body):
	# did the player enter our collider?
	# if so give the stats and destroy the pickup
	if body.name == "Player":
		entered=false



func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		if entered:
			if open:
				$rotpoint.rotate_y(rad2deg(90))
				open=false
			elif !open:
				if locked:
					if player.keys>0:
						player.add_keys(-1)
						$rotpoint.rotate_y(rad2deg(-90))
						open = true
						locked=false
				elif !locked:
					$rotpoint.rotate_y(rad2deg(-90))
					open = true









extends Area

enum PickupType {
	Health,
	Ammo,
	Coins,
	Keys
}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# stats
export(PickupType) var type = PickupType.Health
export var amount : int = 10
 
# bobbing
onready var startYPos : float = translation.y
onready var pickedkeytext : Label = get_node("/root/MainScene/CanvasLayer/UI/PickedKey")
onready var pickedcointext : Label = get_node("/root/MainScene/CanvasLayer/UI/PickedCoin")

var bobHeight : float = 1.0
var bobSpeed : float = 1.0
var bobbingUp : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process (delta):
 
	# move us up or down
	translation.y += (bobSpeed if bobbingUp else -bobSpeed) * delta
 
	# if we're at the top, start moving downwards
	if bobbingUp and translation.y > startYPos + bobHeight:
		bobbingUp = false
	# if we're at the bottom, start moving up
	elif !bobbingUp and translation.y < startYPos:
		bobbingUp = true
		
		
		# called when another body enters our collider
func _on_Pickup_body_entered (body):

	# did the player enter our collider?
	# if so give the stats and destroy the pickup
	if body.name == "Player":
		if type == PickupType.Keys:
			if body.keys < 2:
				pickup(body)
				queue_free()
			else :
				print("Can't hold more than 2 keys.")
		elif type == PickupType.Coins:
			pickup(body)
			queue_free()

		
		
		
		
		# called when the player enters the pickup
# give them the appropriate stat
func pickup (player):
 
	if type == PickupType.Health:
		player.add_health(amount)
	elif type == PickupType.Ammo:
		player.add_ammo(amount)
	elif type == PickupType.Coins:
		player.add_coins(amount)
		pickedcointext.visible =true
	elif type == PickupType.Keys:
		player.add_keys(amount)
		pickedkeytext.visible =true
	
		
		
		
		
		
		
		
		

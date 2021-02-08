extends Control

onready var coinsText : Label = get_node("CoinsText")
onready var keysText : Label = get_node("KeysText")
onready var pickedKey : Label = get_node("PickedKey")
onready var pickedCoin : Label = get_node("PickedCoin")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_coins_text (coins):
	coinsText.text = "Coins : " + str(coins)

func update_keys_text (keys):
	keysText.text = "Keys : " + str(keys) + " / 2"
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_KeyTimer_timeout():
	pickedKey.visible =false
func _on_CoinTimer_timeout():
	pickedCoin.visible =false

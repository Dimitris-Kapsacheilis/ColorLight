extends Area


#onready var whiteLight = get_node("/root/MainScene/Lights/WhiteLight")
#onready var blueLight = get_node("/root/MainScene/Lights/BlueLight")
#onready var redLight = get_node("/root/MainScene/Lights/RedLight")
#onready var greenLight = get_node("/root/MainScene/Lights/GreenLight")

onready var light = get_parent().get_parent().get_parent().get_node("Lights/WhiteLight")

onready var entered =false



func _on_Switch_body_entered (body):
	# did the player enter our collider?
	# if so give the stats and destroy the pickup
	if body.name == "Player":
		entered=true

func _on_Switch_body_exited (body):
	# did the player enter our collider?
	# if so give the stats and destroy the pickup
	if body.name == "Player":
		entered=false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
		if Input.is_action_just_pressed("interact"):
			if entered:
				if get_parent().name == "WhiteSwitch":
					light.light_color = Color(1,1,1)
				elif get_parent().name == "BlueSwitch":
					light.light_color = Color(0.03,0.43,0.96)
				elif get_parent().name == "RedSwitch":
					light.light_color = Color(0.96,0.03,0.27)
				elif get_parent().name == "GreenSwitch":
					light.light_color = Color(0.22,0.8,0.09)
				#whiteLight.visible = false
#				blueLight.visible = false
#				redLight.visible = false
#				greenLight.visible = false
#
#				if get_parent().name == "WhiteSwitch":
#					whiteLight.visible =true
#				elif get_parent().name == "BlueSwitch":
#					blueLight.visible =true
#				elif get_parent().name == "RedSwitch":
#					redLight.visible =true
#				elif get_parent().name == "GreenSwitch":
#					greenLight.visible =true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



extends KinematicBody

onready var boxscene = preload("res://Scenes/PickableBox.tscn")

var pickedbox : bool =false
var enteredbox : bool =false
var tempbox 

var crouched : bool = false

# stats
var curHp : int = 10
var maxHp : int = 10
var ammo : int = 15
var score : int = 0
var coins : int = 0
var keys : int = 0

# physics
var moveSpeed : float = 4.0
var jumpForce : float = 5.0
var gravity : float = 12.0
 
# cam look
var minLookAngle : float = -90.0
var maxLookAngle : float = 90.0
var lookSensitivity : float = 0.4
 
# vectors
var vel : Vector3 = Vector3()
var mouseDelta : Vector2 = Vector2()
 
# player components
onready var camera = get_node("Camera")
onready var ui : Node = get_node("/root/MainScene/CanvasLayer/UI")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	ui.update_coins_text(coins)


func add_coins (amount):
	coins += amount
	ui.update_coins_text(coins)

func add_keys (amount):
	keys += amount
	ui.update_keys_text(keys)


# called when an input is detected
func _input (event):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	# did the mouse move?
	if event is InputEventMouseMotion:
		mouseDelta = event.relative
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
# called every frame
func _process (delta):
 
	# rotate camera along X axis
	camera.rotation_degrees -= Vector3(rad2deg(mouseDelta.y), 0, 0) * lookSensitivity * delta
 
	# clamp the vertical camera rotation
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, minLookAngle, maxLookAngle)
 
	# rotate player along Y axis
	rotation_degrees -= Vector3(0, rad2deg(mouseDelta.x), 0) * lookSensitivity * delta
 
	# reset the mouse delta vector
	mouseDelta = Vector2()
	
	

# called every physics step
func _physics_process (delta):
	# reset the x and z velocity
	vel.x = 0
	vel.z = 0

	var input = Vector2()

	# movement inputs
	if Input.is_action_pressed("move_forward"):
		input.y -= 1
	if Input.is_action_pressed("move_backward"):
		input.y += 1
	if Input.is_action_pressed("move_left"):
		input.x -= 1
	if Input.is_action_pressed("move_right"):
		input.x += 1
	
	# normalize the input so we can't move faster diagonally
	input = input.normalized()
		
	# get our forward and right directions
	var forward = global_transform.basis.z
	var right = global_transform.basis.x
	
	# set the velocity
	vel.z = (forward * input.y + right * input.x).z * moveSpeed
	vel.x = (forward * input.y + right * input.x).x * moveSpeed
	 
	# apply gravity
	vel.y -= gravity * delta
	 
	# move the player
	vel = move_and_slide(vel, Vector3.UP)
	
		# jump if we press the jump button and are standing on the floor
	if Input.is_action_pressed("sprint") and is_on_floor():
		moveSpeed = 8
	elif Input.is_action_just_released("sprint"):
		moveSpeed = 4		
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y = jumpForce
	if Input.is_action_just_pressed("crouch") and is_on_floor():
		if !crouched:
			scale.y=0.4
		elif crouched:
			scale.y=1
		crouched = !crouched
	
	if Input.is_action_just_pressed("interact"): #and boxcode.get_script().picked:
		if !pickedbox:
			if enteredbox:
				tempbox = boxscene.instance()
						#var rotation = tempbox.global_transform.basis.get_euler()
				camera.add_child(tempbox)
						#rotation = tempbox.global_transform.basis.get_euler()
						#tempbox.rotation_degrees = Vector3(1,0,0)
				tempbox.translate(Vector3(0,1.4,-5))
				pickedbox=true
		elif pickedbox:
			if is_instance_valid(tempbox):
				if  tempbox.canbeplaced:
					var temppos 
							#tempbox.translate(Vector3(0,-1.1,0))
					temppos = tempbox.global_transform.origin
					camera.remove_child(tempbox)
					get_node("/root/MainScene").add_child(tempbox)
					tempbox.translate(temppos)
					tempbox.translate(Vector3(0,0,5))
					pickedbox=false
					enteredbox=false
					tempbox.connect("body_entered",self,"_on_PickableBox_body_entered")
					tempbox.connect("body_exited",self,"_on_PickableBox_body_exited")
				else:
					print("Can't place there")
					
	
	



func _on_PickableBox_body_entered(body):
	if body.name == "Player":
		enteredbox = true
	
	


func _on_PickableBox_body_exited(body):
	if body.name == "Player":
		enteredbox = false # Replace with function body.

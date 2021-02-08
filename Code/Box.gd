extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var boxscene = preload("../Scenes/PickableBox.tscn")

onready var player = get_node("/root/MainScene/Player")
onready var main = get_node("/root/MainScene")
var entered : bool = false 
var picked : bool = false 
onready var canbeplaced : bool =true

var vel : Vector3 = Vector3()
var gravityforce : float = 3.0

func _physics_process (delta):
	vel.x=0
	vel.z=0
	vel.y -= gravityforce * delta
	if translation.y >0.6:
		translation.y += vel.y * delta
	

func _on_PickableBox_body_entered (body):
	if body.get_parent() != self:
		print(body.name)
		canbeplaced =false
	# did the player enter our collider?
	# if so give the stats and destroy the pickup
	if body.name == "Player":
		entered=true

func _on_PickableBox_body_exited (body):
	canbeplaced = true
	# did the player enter our collider?
	# if so give the stats and destroy the pickup
	if body.name == "Player":
		entered=false


func _process(_delta):
	if entered:
		if Input.is_action_just_pressed("interact"):
			#print("delte")
			queue_free()
	#print(get_parent().get_parent().translation)
	#print("player:")
	#print(player.translation)
	#if Input.is_action_just_pressed("interact"):
		#if picked:

			#var oldpos = get_parent().translation
			#print(get_parent().translation)
			
			
			#box.get_parent().remove_child(box)
			#main.add_child(box)
			#box.set_owner(main)
			
			
			#print(get_parent().translation)
			#get_parent().position =oldpos
			#picked=false
			#entered =false
		#if entered:
			#var tempbox
			#print(box.get_global_transform().get_translation())
			#box.get_parent().remove_child(box)
			#player.add_child(box)
			#ox.set_owner(player)
			#get_parent().remove_child(self)
			#get_node("/root/MainScene/Player").add_child(self)
			#get_parent().remove_child(self)
			#set_owner(player)
			#queue_free()
			#tempbox = boxscene.instance()
			
			
			#picked=true
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

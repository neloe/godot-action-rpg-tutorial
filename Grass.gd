extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _process(_delta):
#	if Input.is_action_just_pressed("attack"):
#		var GrassEffect = load("res://GrassEffect.tscn")
#		var grassEffect = GrassEffect.instance()
#		var world = get_tree().current_scene
#		world.add_child(grassEffect)
#		grassEffect.global_position = global_position
#		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func create_grass_effect():
	var GrassEffect = load("res://GrassEffect.tscn")
	var grassEffect = GrassEffect.instance()
	var world = get_tree().current_scene
	world.add_child(grassEffect)
	grassEffect.global_position = global_position

func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()

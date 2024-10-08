extends Area2D

@export var weapon_scene: PackedScene
@onready var label = $Label
var player = null
var ref


func _ready() -> void:
	label.visible = false
	$Sprite2D.visible = false
	add_child(weapon_scene.instantiate())
	
func _process(delta):
	if player != null and Input.is_action_just_pressed("interact"):
		player.weapon_manager.on_weapon_picked_up(weapon_scene)
		queue_free()
	
func _on_body_entered(body):
	if not body.is_in_group("Player"):
		return
	player = body
	label.visible = true

func _on_body_exited(body):
	if not body.is_in_group("Player"):
		return
	player = null
	label.visible = false

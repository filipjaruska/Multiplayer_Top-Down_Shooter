extends CharacterBody2D

@export var speed: float = 200.0
var sync_position  = Vector2(0,0) #alternative way to synchorinze movement, not currently used

func _ready():
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())

func _process(delta):
	if $MultiplayerSynchronizer.get_multiplayer_authority() != multiplayer.get_unique_id():
		global_position = global_position.lerp(sync_position , 0.2)
	
	sync_position  = global_position
	
	var input_vector = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized() * speed
	velocity = input_vector
	move_and_slide()
	
func set_player_name(player_name: String):
	$Label.text = player_name

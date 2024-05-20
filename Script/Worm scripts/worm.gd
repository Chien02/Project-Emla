extends CharacterBody2D
# worm
class_name Worm

# Compositions section
@export var info : Worm_info
@export var health : Health_Composition
@export var movement_composition : Movement_Composition
@export var anim_composition : Animations
# Audio section
@export var explode_audio : AudioStreamPlayer2D
@export var select_audio : AudioStreamPlayer2D
# Hitbox section
@export var hitbox : Area2D
# Properties section
@export var timer : Timer
@export var biting : bool
@onready var bitting_flag : bool = false
var target

func _ready():
	set_target(get_tree().get_first_node_in_group("Flower"))
	health.init_health()
	anim_composition.moving() # move when spawned

func _process(delta):
	if (biting):
		bite()
	movement_composition.movement(delta, info.speed)
	if !health.is_connected("dead", die):
		health.connect("dead", die)

func die():
	# Stop bite animation
	stop_bite()
	# Play dead animation
	process_mode = Node.PROCESS_MODE_ALWAYS
	anim_composition.dead()
	explode_audio.play()  # play audio
	await get_tree().create_timer(1.5).timeout
	queue_free()

# Collide with player touch or cursor's click
func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton and event.pressed) or (event is InputEventScreenTouch and event.pressed):
		if (!select_audio.playing):
			select_audio.play() # play audio
		health.decrease_health(100) # target damage

func set_target(_target):
	target = _target

func set_active_bite(flag: bool):
	biting = flag

func bite():
	if (bitting_flag): return
	bitting_flag = true
	anim_composition.bite()
	
	# Turn off hitbox 'till animation finished
	hitbox.set_collision_layer_value(1, false)
	timer.start() # Start bite loop
	
func stop_bite():
	timer.paused = true # Stop time loop
	set_active_bite(false)

func continue_bite():
	timer.paused = false
	set_active_bite(true)

func _on_timer_timeout():
	# Turn on again to the next bite after animation finished..
	hitbox.set_collision_layer_value(1, true)
	bitting_flag = false
	

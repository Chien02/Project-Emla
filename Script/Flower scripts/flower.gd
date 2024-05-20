extends Area2D

@export var health : Health_Composition
@export var level : Level_Composition
@export var info : Resource
@export var animation : Animations
@export var skills : Skills_Composition
@export var absorb_sound : AudioStreamPlayer2D
@export var becrunch_audio : AudioStreamPlayer2D

func _ready():
	health.init_health()
	if animation:
		animation.idle()

func _process(_delta):
	# Update current level to Global level
	Global.level = level.current_level
	
	# Skill section
	if (skills):
		skills.get_skill("Synthesis")
		if (level.current_level == 3):
			skills.get_skill("Shoot")

func _on_area_entered(area):
	# Do hurt() when collide worm and absorb() when collide flower
	if (area.get_parent().is_in_group("Worm")):
		hurt(area)
	elif (area.is_in_group("Energy")):
		#main_scene.energy_mng.increase(area.get_parent().e_value)
		absorb(area)

func hurt(area):
	# call worm's bite animation and call its stop_moving method
	var worm = area.owner
	worm.movement_composition.set_stop(true) # to set worm's velocity become 0
	worm.bite()
	
	health.decrease_health(area.get_parent().info.damage)
	becrunch_audio.play()
	await get_tree().create_timer(0.15).timeout # wait for audio's finish

func absorb(area):
	if (absorb_sound):
		absorb_sound.play()
	var tween = create_tween().set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "scale", Vector2(2.5, 2.5), 0.2).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.2).set_ease(Tween.EASE_IN)
	
	level.gain_exp(area.get_parent().e_value)
	area.get_parent().be_absorb()
	await get_tree().create_timer(0.5).timeout

func _on_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		print("Clicked")

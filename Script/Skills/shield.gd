extends Skill

# Shield Skill
var count : int = 0
var max_shield : int = 3
var shield_flag : bool = false

func shield_on():
	shield_flag = false
	count = 0

func shield_off():
	shield_flag = true
	count = 3

func drop_shield():
	if shield_flag: return
	count += 1;
	if count > max_shield:
		shield_off()
	var red_worm = owner
	red_worm.movement_composition.set_stop(true) # Stop moving
	red_worm.anim_composition.shield() # Do animation
	var tween = create_tween().set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(red_worm, "scale", Vector2(1.4, 1), 0.25).set_ease(Tween.EASE_IN)
	tween.tween_property(red_worm, "scale", Vector2(1.6, 1), 0.25).set_ease(Tween.EASE_OUT)
	tween.tween_property(red_worm, "scale", Vector2(1.4, 1), 0.25).set_ease(Tween.EASE_IN)
	tween.tween_property(red_worm, "scale", Vector2(1.4, 1.4), 0.25).set_ease(Tween.EASE_OUT)
	await tween.finished
	red_worm.anim_composition.moving() # Reset moving animation
	red_worm.movement_composition.set_stop(false) # Enable moving

extends Animations

@export var worm_spritesheet : AnimatedSprite2D
@export var shadow_spritesheet : AnimatedSprite2D
@export var fx_spritesheet : AnimatedSprite2D

func moving():
	if anim_player:
		anim_player.play("moving")
		shadow_spritesheet.play("moving")

func dead():
	if anim_player:
		anim_player.play("die")

func bite():
	if anim_player:
		anim_player.play("bite")

func fx_boom():
	if fx_spritesheet:
		fx_spritesheet.play("default")

func set_flip_h(flag: bool):
	if worm_spritesheet:
		worm_spritesheet.flip_h = flag
		shadow_spritesheet.flip_h = flag

func shoot():
	anim_player.play("shoot")

extends Node2D

class_name Skills_Composition

var skills : Array # This use for store skills

func _ready():
	init_skills()

func init_skills():
	skills = get_children()

func get_skill(_name : String):
	for skill in skills:
		if skill.name == _name and !skill.activing:
			skill.active()

func get_skill_randomly():
	var skill = skills.pick_random()
	if (skill.is_in_group("Skill") and !skill.activing):
		skill.active()

func get_skill_always(_name : String):
	for skill in skills:
		if skill.name == _name and !skill.activing:
			skill.active()

extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func change_scene(target):
	animation_player.play("dissolve")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	animation_player.play_backwards("dissolve")

func change_scene_final(target):
	animation_player.play("bliss")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	animation_player.play_backwards("bliss")
	await get_tree().create_timer(7).timeout
	animation_player.play("bliss")

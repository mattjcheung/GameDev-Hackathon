extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		await get_tree().process_frame
		var game_manager = get_tree().get_first_node_in_group("Manager")
		game_manager.load_scene(preload("res://TheBossFight/scenes/boss_battle.tscn"))

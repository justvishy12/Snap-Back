extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.coins += 1
		$".".visible = false
		$"../..".update()
		if Global.coins == 10:
			get_tree().change_scene_to_file("res://scenes/Last.tscn")
		queue_free()

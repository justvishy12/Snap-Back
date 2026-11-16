extends Node2D

@export var distanceleft: float = 15.0
@export var distanceright: float = 15.0
@export var time = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")
	tween_loop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func tween_loop():
	while true:
		var tween = create_tween()
		tween.tween_property(self, "position:x", position.x + distanceleft, time)
		await tween.finished

		var tween2 = create_tween()
		tween2.tween_property(self, "position:x", position.x - distanceright, time)
		await tween2.finished


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.hearts -= 1
		$".".visible = false
		$"../..".update()
		if Global.hearts == 0:
			get_tree().change_scene_to_file("res://scenes/MainGame.tscn")
		queue_free()

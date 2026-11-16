extends Node2D
@export var distanceleft: float = 15.0
@export var distanceright: float = 15.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")
	tween_loop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func tween_loop():
	var tween = create_tween()
	tween.tween_property(self, "position:x", position.x + distanceleft, 0.5)
	await tween.finished
	var tween2 = create_tween()
	tween2.tween_property(self, "position:x", position.x - distanceright, 0.5)
	tween_loop()
	


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainGame.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/instructions.tscn")

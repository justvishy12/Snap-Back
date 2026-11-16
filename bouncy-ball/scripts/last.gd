extends Node2D
var skip_typing = false
var dialogue = [
	{
		#0
		"speaker": "cat",
		"name": "Old Man",
		"text": "Wow your so helpul ",
		"portrait": preload("res://assets/headshots/old.png")
	},
	{
		#1
		"speaker": "cat",
		"name": "You",
		"text": "Thanks ",
		"portrait": preload("res://assets/headshots/mc.png")
	},
	{
		#2
		"speaker": "cat",
		"name": "Old Man",
		"text": "Now you can get a job and bounce back ",
		"portrait": preload("res://assets/headshots/old.png")
	},

	]

var dialogue_index = 0
var typing = false


func show_next_dialogue() -> void:
	if dialogue_index >= dialogue.size():
		$Textbox.visible = false
		return
	
	var line = dialogue[dialogue_index]
	
	if line["speaker"] == "cat":
		show_cat_text(line)
		



func show_cat_text(line) -> void:
	skip_typing = false
	$Textbox.visible = true
	typing = true
	
	$Textbox/namelabel.text = line["name"]
	$Textbox/textlabel.text = line["text"]
	
	if line.has("portrait"):
		$Textbox/photobox.texture = line["portrait"]
	else:
		$Textbox/photobox.texture = null
	$Textbox/textlabel.visible_characters = 0

	for i in $Textbox/textlabel.text.length():
		if skip_typing:
			$Textbox/textlabel.visible_characters = $Textbox/textlabel.text.length()
			break
		if !is_inside_tree():
			return
		$Textbox/textlabel.visible_characters = i
		await get_tree().create_timer(Global.speed, false).timeout
	typing = false


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = true
	if event.is_action_pressed("ui_accept") and !typing:
		if dialogue_index < dialogue.size() and dialogue[dialogue_index]["speaker"] == "cat":
			if dialogue_index == 2:
				$Label.visible = true
			dialogue_index += 1
			show_next_dialogue()
			
	elif event.is_action_pressed("ui_accept") and typing:
		skip_typing = true
		$Textbox/textlabel.visible_characters = $Textbox/textlabel.text.length()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show_next_dialogue()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Node2D


var skip_typing = false
var dialogue = [
	{
		#0
		"speaker": "cat",
		"name": "Old Man",
		"text": "Can you help me? ",
		"portrait": preload("res://assets/headshots/old.png")
	},
	{
		#2
		"speaker": "cat",
		"name": "You",
		"text": "I just lost my job, STOP! ",
		"portrait": preload("res://assets/headshots/mc.png")
	},
	{
		#3
		"speaker": "cat",
		"name": "Old Man",
		"text": "P-please, I just need a little help. ",
		"portrait": preload("res://assets/headshots/old.png")
	},
	{
		#4
		"speaker": "cat",
		"name": "You",
		"text": "Fine what do you need ",
		"portrait": preload("res://assets/headshots/mc.png")
	},
	{
		#5
		"speaker": "cat",
		"name": "Old Man",
		"text": "First things first, jump on trampolines to bounce back up.",
		"portrait": preload("res://assets/headshots/old.png")
	},
	{
		#4
		"speaker": "cat",
		"name": "Old Man",
		"text": "Second, find my 10 coins, then find my house and return it to me there, Thank You ",
		"portrait": preload("res://assets/headshots/old.png")
	},

	]

var dialogue_index = 0
var typing = false


func show_next_dialogue() -> void:
	if dialogue_index >= dialogue.size():
		$Player/Textbox.visible = false
		return
	
	var line = dialogue[dialogue_index]
	
	if line["speaker"] == "cat":
		show_cat_text(line)
		



func show_cat_text(line) -> void:
	skip_typing = false
	$Player/Textbox.visible = true
	typing = true
	
	$Player/Textbox/namelabel.text = line["name"]
	$Player/Textbox/textlabel.text = line["text"]
	
	if line.has("portrait"):
		$Player/Textbox/photobox.texture = line["portrait"]
	else:
		$Player/Textbox/photobox.texture = null
	$Player/Textbox/textlabel.visible_characters = 0

	for i in $Player/Textbox/textlabel.text.length():
		if skip_typing:
			$Player/Textbox/textlabel.visible_characters = $Player/Textbox/textlabel.text.length()
			break
		if !is_inside_tree():
			return
		$Player/Textbox/textlabel.visible_characters = i
		await get_tree().create_timer(Global.speed, false).timeout
	typing = false


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = true
	if event.is_action_pressed("ui_accept") and !typing:
		if dialogue_index < dialogue.size() and dialogue[dialogue_index]["speaker"] == "cat":
			dialogue_index += 1
			show_next_dialogue()
			
	elif event.is_action_pressed("ui_accept") and typing:
		skip_typing = true
		$Player/Textbox/textlabel.visible_characters = $Player/Textbox/textlabel.text.length()

func _ready() -> void:
	update()
	show_next_dialogue()

func update():
	$Player/Label2.text = "Coins:" + str(Global.coins)+"/10"
	$Player/Label.text = "Lives Left:" + str(Global.hearts)

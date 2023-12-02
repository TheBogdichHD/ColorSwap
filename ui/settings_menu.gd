extends Control

@onready var full_screen_check_box = $MarginContainer/VBoxContainer/FullscreenButton
@onready var resolution_option_button = $MarginContainer/VBoxContainer/Resolution/ResolutionOptionButton
@onready var sound = preload("res://assets/sounds/button_ui.wav")

var Resolutions: Dictionary = {"2560x1440":Vector2i(2560,1080),
								"1920x1080":Vector2i(1920,1080),
								"1366x768":Vector2i(1366,768),
								"1536x864":Vector2i(1536,864),
								"1280x720":Vector2i(1280,720),
								"1440x900":Vector2i(1440,900),
								"1600x900":Vector2i(1600,900),
								"1024x600":Vector2i(1024,600),
								"800x600": Vector2i(800,600)}
								

func _ready():
	Add_Resolutions()
	Check_Variables()

func Check_Variables():
	var _window = get_window()
	var mode = _window.get_mode()
	
	if mode == Window.MODE_FULLSCREEN:
		resolution_option_button.set_disabled(true)
		full_screen_check_box.set_pressed_no_signal(true)


func Set_Resolution_Text():
	var Resolution_Text = str(get_window().get_size().x)+"x"+str(get_window().get_size().y)
	resolution_option_button.set_text(Resolution_Text)


func Add_Resolutions():
	var Current_Resolution = get_window().get_size()
	var ID = 0
	
	for r in Resolutions:
		resolution_option_button.add_item(r, ID)
		
		if Resolutions[r] == Current_Resolution:
			resolution_option_button.select(ID)
			Save.data["settings"]["resolution"] = ID
		
		ID += 1

func _on_option_button_item_selected(index):
	var ID = resolution_option_button.get_item_text(index)
	get_window().set_size(Resolutions[ID])
	Set_Resolution_Text()
	Centre_Window()
	Save.data["settings"]["resolution"] = ID


func _on_fullscreen_checkbox_toggled(toggled_on):
	resolution_option_button.set_disabled(toggled_on)
	if toggled_on:
		get_window().set_mode(Window.MODE_FULLSCREEN)
		Save.data["settings"]["fullscreen"] = true
	else:
		Save.data["settings"]["fullscreen"] = false
		get_window().set_mode(Window.MODE_WINDOWED)
		Centre_Window()
	get_tree().create_timer(.05).timeout.connect(Set_Resolution_Text)

func Centre_Window():
	var Centre_Screen = DisplayServer.screen_get_position()+DisplayServer.screen_get_size()/2
	var Window_Size = get_window().get_size_with_decorations()
	get_window().set_position(Centre_Screen-Window_Size/2)


func _on_back_pressed():
	AudioPlayer.play_sound(sound)
	get_tree().change_scene_to_file("res://ui/menu.tscn")

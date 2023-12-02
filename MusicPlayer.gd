extends AudioStreamPlayer


func play_music(music):
	if stream != music:
		stream = music
		play()

func stop_playing():
	stop()


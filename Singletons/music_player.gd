extends AudioStreamPlayer

func play_intro():
	var playback: AudioStreamPlaybackInteractive = self.get_stream_playback()
	playback.switch_to_clip_by_name("Intro")

func play_detonate():
	var playback: AudioStreamPlaybackInteractive = self.get_stream_playback()
	playback.switch_to_clip_by_name("Detonate")

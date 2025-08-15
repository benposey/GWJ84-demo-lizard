extends Node

@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var qte_music_player: AudioStreamPlayer = $QteMusicPlayer
@onready var sfx_player: AudioStreamPlayer = $SfxPlayer

func music_play(clip_name: String):
	var playback: AudioStreamPlaybackInteractive = music_player.get_stream_playback()
	playback.switch_to_clip_by_name(clip_name)

func music_stop():
	var playback: AudioStreamPlaybackInteractive = music_player.get_stream_playback()
	playback.stop()
	
func qte_play():
	qte_music_player.play()
	
func sfx_play():
	sfx_player.play()

func start_qte():
	music_play("Fade")
	qte_play()

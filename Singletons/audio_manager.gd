extends Node

@onready var qte_music_player: AudioStreamPlayer = $QteMusicPlayer
@onready var sfx_player: AudioStreamPlayer = $SfxPlayer
	
func qte_play():
	qte_music_player.play()
	
func sfx_play():
	sfx_player.play()

func start_qte():
	qte_play()

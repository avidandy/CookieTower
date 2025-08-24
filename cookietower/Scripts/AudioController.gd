extends Node

func play_sound(sound, volume):
	var audio_player = AudioStreamPlayer.new()
	audio_player.stream = load(sound)
	add_child(audio_player)
	audio_player.volume_db = volume
	audio_player.play()
	await audio_player.finished
	audio_player.queue_free()

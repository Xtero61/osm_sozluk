extends Node2D

func _on_Alistirmalar_pressed():
	Genel.ButonSesi()
	get_tree().change_scene("res://Alistirma(Secme).tscn")

func _on_KelimeEkleCikar_pressed():
	Genel.ButonSesi()
	get_tree().change_scene("res://Sozluk(Ekle-Cikar).tscn")

func _on_Cks_pressed():
	Genel.ButonSesi()
	$Timer.start()

func _on_Timer_timeout():
	get_tree().quit()

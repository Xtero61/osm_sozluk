extends Node2D

func _on_KelimeBilme_pressed():
	Genel.ButonSesi()
	get_tree().change_scene("res://Alistirma(KelimeBilme).tscn")

func _on_Geri_pressed():
	Genel.ButonSesi()
	get_tree().change_scene("res://Sozluk(Anamenu).tscn")

func _on_SklSorular_pressed():
	Genel.ButonSesi()
	get_tree().change_scene("res://Alistirma(ŞıklıSorular).tscn")

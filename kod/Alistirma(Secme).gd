extends Node2D

func _on_KelimeBilme_pressed():
	ButonSesi()
	get_tree().change_scene("res://Alistirma(KelimeBilme).tscn")


func _on_Geri_pressed():
	ButonSesi()
	get_tree().change_scene("res://Sozluk(Anamenu).tscn")

func ButonSesi():
	var ButonSesi = load("res://ses/ButonSesi.tscn")
	var Buton = ButonSesi.instance()
	Buton.position = Vector2(320,160)
	get_parent().add_child(Buton)

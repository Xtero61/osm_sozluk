extends Node2D

func _on_Alistirmalar_pressed():
	ButonSesi()
	get_tree().change_scene("res://Alistirma(Secme).tscn")

func _on_KelimeEkleCikar_pressed():
	ButonSesi()
	get_tree().change_scene("res://Sozluk(Ekle-Cikar).tscn")

func _on_Cks_pressed():
	ButonSesi()
	$Timer.start()

func ButonSesi():
	var ButonSesi = load("res://ses/ButonSesi.tscn")
	var Buton = ButonSesi.instance()
	Buton.position = Vector2(320,160)
	get_parent().add_child(Buton)

func _on_Timer_timeout():
	get_tree().quit()

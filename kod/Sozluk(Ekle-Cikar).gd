extends Node2D

onready var Osmanlica = []
onready var Turkce = []

func _ready():
	Osmanlica = dosyadan_oku("Osmanlıca")
	Turkce = dosyadan_oku("Türkçe")
	Liste_guncelleme()

#Kelime liste güncelleme
func Liste_guncelleme():
	$OsmanlicaTurkce.text = ""
	for i in range(0,Osmanlica.size()):
		$OsmanlicaTurkce.text += Osmanlica[i] + " = " + Turkce[i] + "\n"

#sözlük kaydetme
func dosyaya_yaz(sozluk,sozluk_adi):
	var file = File.new()
	file.open("user://%s.res" % sozluk_adi, file.WRITE)
	file.store_string(var2str(sozluk))
	file.close()

#sözlük okuma
func dosyadan_oku(sozluk_adi):
	var file = File.new()
	var hata = file.open("user://%s.res" % sozluk_adi, file.READ)
	if OK != hata:
		return []
	var liste = str2var(file.get_as_text())
	file.close()
	
	return liste

#kelime ekleme
func _on_Ekle_pressed():

	#yazılan yere yazı yazıldıysa eklme
	if not $OsmanlicaEkle.text == "" and not $TurkceEkle.text == "" :
		Osmanlica.append($OsmanlicaEkle.text.to_lower())
		Turkce.append($TurkceEkle.text.to_lower())
		dosyaya_yaz(Osmanlica,"Osmanlıca")
		dosyaya_yaz(Turkce,"Türkçe")
		Liste_guncelleme()
		Gorunurluk_kapa()
		$KelimeEklendi.visible = true
		$Timer.start()

	#yazılan yerlerin ikiside boşsa ekrana yazılan yazı
	elif $OsmanlicaEkle.text == "" and $TurkceEkle.text == "" :
		Gorunurluk_kapa()
		$KelimeYok2.visible = true
		$Timer2.start()

	#yazılan yerlerin turkcesi boşsa ekrana yazılan yazı
	elif $OsmanlicaEkle.text == "" :
		Gorunurluk_kapa()
		$KelimeYokTurk.visible = true
		$Timer2.start()

	#yazılan yerlerin osmanlıcası boşsa ekrana yazılan yazı
	elif $TurkceEkle.text == "" :
		Gorunurluk_kapa()
		$KelimeYokOsmanlica.visible = true
		$Timer2.start()

#kelime çıkarma
func _on_Cikar_pressed():
	ButonSesi()
	var arama = Turkce.find($OsmanlicaCikar.text.to_lower())
	
	#kelime cıkara hiç yazı yazmamışsa cıkacak yazı
	if $OsmanlicaCikar.text == "":
		Gorunurluk_kapa()
		$KelimeYok3.visible = true
		$Timer.start()

	#çıkarılacak kelime yoksa gösterilen yazı
	elif arama == -1 :
		Gorunurluk_kapa()
		$KelimeYok.visible = true
		$Timer.start()

	#kelimeyi cıkarma ve cıkarıldı yazma
	else :
		Osmanlica.remove(arama)
		Turkce.remove(arama)
		dosyaya_yaz(Osmanlica,"Osmanlıca")
		dosyaya_yaz(Turkce,"Türkçe")
		Liste_guncelleme()
		Gorunurluk_kapa()
		$KelimeCikarildi.visible = true
		$Timer.start()

#ekle butonuna basınca yazı yerlerini boşaltma
func _on_Ekle_button_up():
	ButonSesi()
	$OsmanlicaEkle.text = ""
	$TurkceEkle.text = ""

#çıkar butonuna basınca yazı yerini boşaltma
func _on_Cikar_button_up():
	ButonSesi()
	$OsmanlicaCikar.text = ""

 #hata yazılarını ekranda bekleme süresinin bittiği yer
func _on_Timer_timeout():
	$KelimeYok.visible = false
	$KelimeYok3.visible = false
	$KelimeEklendi.visible = false
	$KelimeCikarildi.visible = false

 #hata yazılarını ekranda bekleme süresinin bittiği yer
func _on_Timer2_timeout():
	$KelimeYok2.visible = false
	$KelimeYokTurk.visible = false
	$KelimeYokOsmanlica.visible = false

#hata yazıları görünürlüğü kapama
func Gorunurluk_kapa():
	$KelimeYok.visible = false
	$KelimeYok2.visible = false
	$KelimeYok3.visible = false
	$KelimeYokTurk.visible = false
	$KelimeYokOsmanlica.visible = false
	$KelimeEklendi.visible = false
	$KelimeCikarildi.visible = false

#kelime listesini görme
func _on_KelimeListe_toggled(button_pressed):
	if button_pressed == true:
		ButonSesi()
		$AnimationPlayer.play("Açılma")
	else :
		ButonSesi()
		$AnimationPlayer.play("Kapanma")

#anamenüye dönme
func _on_Geri_pressed():
	ButonSesi()
	get_tree().change_scene("res://Sozluk(Anamenu).tscn")

func ButonSesi():
	var ButonSesi = load("res://ses/ButonSesi.tscn")
	var Buton = ButonSesi.instance()
	Buton.position = Vector2(320,160)
	get_parent().add_child(Buton)

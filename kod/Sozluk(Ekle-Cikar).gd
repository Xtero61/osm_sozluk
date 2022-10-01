extends Node2D

onready var Osmanlica = []
onready var Turkce = []

func _process(_delta):
	Genel.Android_Klavye($AndroidYeri,$NormalYeri)
#string ters çevirme
static func invert_string(s:String)->String:
	var chars_pool = PoolStringArray()
	var length = s.length()
	chars_pool.resize(length)
	for i in length:
		chars_pool[i] = s[i]
	chars_pool.invert()
	return chars_pool.join("")

#kelimeleri başlangıcta ekleme
func _ready():
	Osmanlica = Genel.dosyadan_oku("Osmanlıca")
	Turkce = Genel.dosyadan_oku("Türkçe")
	Liste_guncelleme()

#Kelime liste güncelleme
func Liste_guncelleme():
	$OsmanlicaTurkce.text = ""
	for i in range(0,Osmanlica.size()):
		$OsmanlicaTurkce.text += Osmanlica[i] + " = " + Turkce[i] + "\n"

#buton tıklama sesi
func ButonSesi():
	var ButonSesi = load("res://ses/ButonSesi.tscn")
	var Buton = ButonSesi.instance()
	Buton.position = Vector2(320,160)
	get_parent().add_child(Buton)

#kelime ekleme
func _on_Ekle_pressed():

	#yazılan yere yazı yazıldıysa eklme
	if not $OsmanlicaEkle.text == "" and not $TurkceEkle.text == "" :
		Osmanlica.append($OsmanlicaEkle.text.to_lower())
		Turkce.append($TurkceEkle.text.to_lower())
		Genel.dosyaya_yaz(Osmanlica,"Osmanlıca")
		Genel.dosyaya_yaz(Turkce,"Türkçe")
		Liste_guncelleme()
		$KelimeYok2.text = "Kelime eklendi"
		$KelimeYok2.visible = true
		$Timer2.start()

	#yazılan yerlerin ikiside boşsa ekrana yazılan yazı
	elif $OsmanlicaEkle.text == "" and $TurkceEkle.text == "" :
		$KelimeYok2.text = "Önce birşeyler yazmalısın"
		$KelimeYok2.visible = true
		$Timer2.start()

	#yazılan yerlerin turkcesi boşsa ekrana yazılan yazı
	elif $OsmanlicaEkle.text == "" :
		$KelimeYok2.text = "Osmanlıca karşılığınıda yazmalısın"
		$KelimeYok2.visible = true
		$Timer2.start()

	#yazılan yerlerin osmanlıcası boşsa ekrana yazılan yazı
	elif $TurkceEkle.text == "" :
		$KelimeYok2.text = "Türkçe karşılığınıda yazmalısın"
		$KelimeYok2.visible = true
		$Timer2.start()

#kelime çıkarma
func _on_Cikar_pressed():
	ButonSesi()
	var arama = Turkce.find($OsmanlicaCikar.text.to_lower())
	
	#kelime cıkara hiç yazı yazmamışsa cıkacak yazı
	if $OsmanlicaCikar.text == "":
		$KelimeYok.text = "Önce birşeyler yazmalısın"
		$KelimeYok.visible = true
		$Timer.start()

	#çıkarılacak kelime yoksa gösterilen yazı
	elif arama == -1 :
		$KelimeYok.text = "Böyle bir kelime bulunmuyor"
		$KelimeYok.visible = true
		$Timer.start()

	#kelimeyi cıkarma ve cıkarıldı yazma
	else :
		Osmanlica.remove(arama)
		Turkce.remove(arama)
		Genel.dosyaya_yaz(Osmanlica,"Osmanlıca")
		Genel.dosyaya_yaz(Turkce,"Türkçe")
		Liste_guncelleme()
		$KelimeYok.text = "Kelime çıkarıldı"
		$KelimeYok.visible = true
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

 #hata yazılarını ekranda bekleme süresinin bittiği yer
func _on_Timer2_timeout():
	$KelimeYok2.visible = false

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

func _on_OsmanlicaEkle_focus_exited():
	var cevir = $OsmanlicaEkle.text
	$OsmanlicaEkle.text = invert_string(cevir)


func _on_Panel_focus_entered():
		$OsmanlicaCikar.release_focus()
		$OsmanlicaEkle.release_focus()
		$TurkceEkle.release_focus()

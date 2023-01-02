extends Node2D

var rng = RandomNumberGenerator.new()

onready var Osmanlica = []
onready var Turkce = []

var random_kelime : int 
var bosluk_payi : int = 0
var aldi_ipucu : int = 0
var bayrak : int = 1
var ipucu_satir_boyu : int = 40

#sözlük kelime listeye yazma
func _ready():
	Osmanlica = Genel.dosyadan_oku("Osmanlıca")
	Turkce = Genel.dosyadan_oku("Türkçe")

func _process(_delta):
	Genel.Android_Klavye($AndroidYeri,$NormalYeri)
	#sözlükte kelime varsa sormasını ayarlayan kod
	if not Osmanlica.size() == 0 :
		#enter basarsa cevabı kontrol etme
		if Input.is_action_just_pressed("ui_accept"):
			cevap_kontrol()

		#random kelime seçme
		if bayrak == 1 :
			rng.randomize()
			random_kelime = rng.randi_range(1,Osmanlica.size())
			ipucu_bosalt(Turkce[random_kelime-1])
			$SoruAnimasyon.play("SoruSorma")
			bayrak = 0
			#ipucudaki boşluğu sayan for döngüsü
			var ipucu = Turkce[random_kelime-1]
			for i in ipucu:
				if i == " ":
					bosluk_payi += 1

		#random sectiği soruyu sorma
		if bayrak == 0 :
			$Soru.text = "' %s ' türkçesi ne demek ?" % Osmanlica[random_kelime-1].capitalize()

	#sözlükte kelime yoksa çıkan hata
	else:
		$bos.visible = true
		$SoslukKelimeYok.visible = true
		$Soru.visible = false
		$Cevap.visible = false
		$ipucuTema.visible = false
		$ipucuYazi.visible = false
		$"İpucu".visible = false
		$"Enter".visible = false

#girilen cevabın doğruluğuna bakan fonksiyon
func cevap_kontrol():
	var cevap = $Cevap.text
	#cevap doğruysa oluşan animasyon
	if cevap == Turkce[random_kelime-1] :
		bayrak = 1
		$BilmeAnimasyon.play("Doğru")
		$Dogru.play()
	#cevap doğru değilse oynayan animasyon
	else :
		$Yanlis.play()
		$YanlisBilme.play("Yanlış")
		$BilmeAnimasyon.play("Yanlış")
	$Cevap.text = ""

#ipucu butonuna basınca çağrılan fonsiyon
func ipucu_al():
	var ipucu = Turkce[random_kelime-1]
	var ipucuarti : int = 0
	$ipucuYazi.text = ""
	if aldi_ipucu-1 < ipucu.length()-bosluk_payi:
		$ipucu.play()
		$ipucuAnimasyon.play("ipucu")
	var a = 0
	for i in ipucu:
		a += 1 
		if a == ipucu_satir_boyu :
			a = 0
			$ipucuYazi.text += "\n"
		if not i == " ":
			if ipucuarti < aldi_ipucu:
				$ipucuYazi.text += i
				ipucuarti += 1
			else :
				$ipucuYazi.text += "-"
		elif i == " ":
			$ipucuYazi.text += " "

#her soru yenilenince çağrılan fonsiyon
func ipucu_bosalt(ipucu):
	var a = 0
	aldi_ipucu = 0
	$ipucuYazi.text = ""
	for i in ipucu:
		a += 1
		if a == ipucu_satir_boyu :
			a = 0
			$ipucuYazi.text += "\n"
		if i == " ":
			$ipucuYazi.text += " "
		else :
			$ipucuYazi.text += "-"

#butona basınca çıkan ses
func ButonSesi():
	var ButonSesi = load("res://ses/ButonSesi.tscn")
	var Buton = ButonSesi.instance()
	Buton.position = Vector2(320,160)
	get_parent().add_child(Buton)

func _on_Geri_pressed():
	get_tree().change_scene("res://Alistirma(Secme).tscn")
	ButonSesi()

func _on_Enter_pressed():
	cevap_kontrol()

func _on_pucu_pressed():
	aldi_ipucu += 1
	ipucu_al()

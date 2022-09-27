extends Node2D

var rng = RandomNumberGenerator.new()

onready var Osmanlica = []
onready var Turkce = []

var random_kelime : int 
var bayrak : int = 1
var aldi_ipucu : int = 0
var cevap

#sözlük kelime listeye yazma
func _ready():
	Osmanlica = dosyadan_oku("Osmanlıca")
	Turkce = dosyadan_oku("Türkçe")

#sözlük kelime okuma
func dosyadan_oku(sozluk_adi):
	var file = File.new()
	var hata = file.open("user://%s.res" % sozluk_adi, file.READ)
	if OK != hata:
		return []
	var liste = str2var(file.get_as_text())
	file.close()
	
	return liste

func _process(_delta):

	if not Osmanlica.size() == 0 :
		if Input.is_action_just_pressed("ui_accept"):
			cevap_kontrol()

		if bayrak == 1 :
			rng.randomize()
			random_kelime = rng.randi_range(1,Osmanlica.size())
			ipucu_bosalt(Turkce[random_kelime-1])
			$SoruAnimasyon.play("SoruSorma")
			bayrak = 0
		if bayrak == 0 :
			$Soru.text = "' %s ' türkçesi ne demek ?" % Osmanlica[random_kelime-1].capitalize()
		
	else:
		$SoslukKelimeYok.visible = true
		$Soru.visible = false
		$Cevap.visible = false
		$ipucuTema.visible = false
		$ipucuYazi.visible = false
		$"İpucu".visible = false
		$"Enter".visible = false

func cevap_kontrol():
	cevap = $Cevap.text
	if cevap == Turkce[random_kelime-1] :
		bayrak = 1
		$BilmeAnimasyon.play("Doğru")
		$Dogru.play()
	
	else :
		$Yanlis.play()
		$YanlisBilme.play("Yanlış")
		$BilmeAnimasyon.play("Yanlış")
	$Cevap.text = ""
	cevap = ""


func ipucu_al():
	var ipucu = Turkce[random_kelime-1]
	$ipucuYazi.text = ""
	var ipucuarti : int = 0
	if aldi_ipucu-1 < ipucu.length():
		$ipucu.play()
		$ipucuAnimasyon.play("ipucu")
	for i in ipucu:
		if ipucuarti < aldi_ipucu:
			$ipucuYazi.text += i
			ipucuarti += 1
		else :
			$ipucuYazi.text += "-"

func ipucu_bosalt(ipucu):
	aldi_ipucu = 0
	$ipucuYazi.text = ""
	for i in ipucu:
		$ipucuYazi.text += "-"


func _on_Geri_pressed():
	get_tree().change_scene("res://Alistirma(Secme).tscn")
	ButonSesi()

func _on_Enter_pressed():
	cevap_kontrol()

func _on_pucu_pressed():
	aldi_ipucu += 1
	ipucu_al()

func ButonSesi():
	var ButonSesi = load("res://ses/ButonSesi.tscn")
	var Buton = ButonSesi.instance()
	Buton.position = Vector2(320,160)
	get_parent().add_child(Buton)

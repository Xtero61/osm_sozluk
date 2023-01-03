extends Node2D

var rng = RandomNumberGenerator.new()

onready var Osmanlica = []
onready var Turkce = []

onready var SorulanListe = []
onready var CevaptakiListe = []

onready var A_cevap = $A
onready var B_cevap = $B
onready var C_cevap = $C
onready var D_cevap = $D

var sozluk : String = "türkçesi"

var a_daki_cevap : int 
var b_daki_cevap : int 
var c_daki_cevap : int 
var d_daki_cevap : int 

var bir_onceki_cevap : int
var sahte_cevap : int 
var cevap_hangiyse : int
var random_kelime : int
var bayrak : int = 1


#sözlük kelime listeye yazma
func _ready():
	Osmanlica = Genel.dosyadan_oku("Osmanlıca")
	Turkce = Genel.dosyadan_oku("Türkçe")
	SorulanListe = Osmanlica
	CevaptakiListe = Turkce


func _process(_delta):

	if not Osmanlica.size() < 4 :

		#random kelime seçme
		if bayrak == 1 :
			a_daki_cevap = 0 
			b_daki_cevap = 0 
			c_daki_cevap = 0 
			d_daki_cevap = 0
			rng.randomize()
			while true :
				random_kelime = rng.randi_range(1,Osmanlica.size())
				if random_kelime != bir_onceki_cevap :
					break
			bir_onceki_cevap = random_kelime
			cevap_hangiyse = rng.randi_range(1,4)

			for i in 4 :
				i += 1

				if i != cevap_hangiyse :
					if i == 1 :
						while true :
							sahte_cevap = rng.randi_range(1,Osmanlica.size())
							if (random_kelime != sahte_cevap 
							and sahte_cevap != a_daki_cevap 
							and sahte_cevap != b_daki_cevap 
							and sahte_cevap != c_daki_cevap 
							and sahte_cevap != d_daki_cevap):
								a_daki_cevap = sahte_cevap
								A_cevap.text = "A) %s" % CevaptakiListe[sahte_cevap-1].capitalize()
								break

					elif i == 2 :
						while true :
							sahte_cevap = rng.randi_range(1,Osmanlica.size())
							if (random_kelime != sahte_cevap 
							and sahte_cevap != a_daki_cevap 
							and sahte_cevap != b_daki_cevap 
							and sahte_cevap != c_daki_cevap 
							and sahte_cevap != d_daki_cevap):
								b_daki_cevap = sahte_cevap
								B_cevap.text = "B) %s" % CevaptakiListe[sahte_cevap-1].capitalize()
								break

					elif i == 3 :
						while true :
							sahte_cevap = rng.randi_range(1,Osmanlica.size())
							if (random_kelime != sahte_cevap 
							and sahte_cevap != a_daki_cevap 
							and sahte_cevap != b_daki_cevap 
							and sahte_cevap != c_daki_cevap 
							and sahte_cevap != d_daki_cevap):
								c_daki_cevap = sahte_cevap
								C_cevap.text = "C) %s" % CevaptakiListe[sahte_cevap-1].capitalize()
								break

					elif i == 4 :
						while true :
							sahte_cevap = rng.randi_range(1,Osmanlica.size())
							if (random_kelime != sahte_cevap 
							and sahte_cevap != a_daki_cevap 
							and sahte_cevap != b_daki_cevap 
							and sahte_cevap != c_daki_cevap 
							and sahte_cevap != d_daki_cevap):
								d_daki_cevap = sahte_cevap
								D_cevap.text = "D) %s" % CevaptakiListe[sahte_cevap-1].capitalize()
								break

				else :
					if i == 1 :
						A_cevap.text = "A) %s" % CevaptakiListe[random_kelime-1].capitalize()
						a_daki_cevap = random_kelime
					elif i == 2 :
						B_cevap.text = "B) %s" % CevaptakiListe[random_kelime-1].capitalize()
						b_daki_cevap = random_kelime
					elif i == 3 :
						C_cevap.text = "C) %s" % CevaptakiListe[random_kelime-1].capitalize()
						c_daki_cevap = random_kelime
					elif i == 4 :
						D_cevap.text = "D) %s" % CevaptakiListe[random_kelime-1].capitalize()
						d_daki_cevap = random_kelime
			bayrak = 0

		if bayrak == 0 :
			$SorulanKelime.text = "' %s '" % SorulanListe[random_kelime-1].capitalize()
			$Soru.text = "Yukardaki kelimenin %s şıklardan hangisidir ?" % sozluk
			bayrak = 2
	else :
		$SoslukKelimeYok.visible = true
		$SorulanKelime.visible = false
		$Soru.visible = false
		A_cevap.visible = false
		B_cevap.visible = false
		C_cevap.visible = false
		D_cevap.visible = false

func cevap_kontrol(cevap):
	if cevap == random_kelime :
		$BilmeAnimasyon.play("Dogru")
		bayrak = 1
	else :
		$BilmeAnimasyon.play("Yanlis")

func sorulma_sekli_deis():
	if sozluk == "türlçesi":
		sozluk = "osmanlıcası"
		SorulanListe = Turkce
		CevaptakiListe = Osmanlica
		$"Değiştir".text = "Türkçe"
	else :
		sozluk = "türlçesi"
		SorulanListe = Osmanlica
		CevaptakiListe = Turkce
		$"Değiştir".text = "Osmanlıca"
	bayrak = 1

func _on_A_pressed():
	cevap_kontrol(a_daki_cevap)

func _on_B_pressed():
	cevap_kontrol(b_daki_cevap)

func _on_C_pressed():
	cevap_kontrol(c_daki_cevap)

func _on_D_pressed():
	cevap_kontrol(d_daki_cevap)

func _on_Geri_pressed():
	Genel.ButonSesi()
	get_tree().change_scene("res://Alistirma(Secme).tscn")

func _on_Deitir_pressed():
	sorulma_sekli_deis()

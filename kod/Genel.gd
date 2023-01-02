extends Node

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

#butana tıklayınca çıkan ses
func ButonSesi():
	var ButonSesi = load("res://ses/ButonSesi.tscn")
	var Buton = ButonSesi.instance()
	Buton.position = Vector2(320,160)
	get_parent().add_child(Buton)

#ekranı telefonun klavyeli ekranına göre ayarlama
func Android_Klavye(Android_camera,Normal_camera):
	var Klavye_durum = OS.get_virtual_keyboard_height()
	if (Klavye_durum == 0) :
		Normal_camera.current = true
	else :
		Android_camera.current = true

# Vaja 3d - polja, datumi in matematika

Pozabljiva babi Fifi
Babica Fifi je svojemu vnuku, ki je slučajno programer na Vegovi, zadala naslednjo nalogo. Izdelati mora aplikacijo za opravke (angl. to-do). Čeprav bi si mislili, da je babi tista, ki kdaj kaj pozabi, temu ni tako. Babi namreč pravi, da bo našo aplikacijo uporabila za opominjanje (ne)lenih vnukov.

1. Lastnosti opravkov
Razmisli, katere lastnosti bodo imeli tvoji opravki (objekti). Minimalno naj vsebujejo:

Naslov,
Opis opravka,
Rok za dokončanje (uporabi Date),
Prioriteto.
Ustvarjeni opravki se združujejo v polje (angl. Array).

2. Funkcionalnosti aplikacije
Tvoj uporabniški vmesnik mora omogočati:

Izračun dni do roka opravka:

Vsak opravek naj prikazuje, koliko dni je še do roka za dokončanje.
Če je rok že pretekel, naj se to označi z opozorilno barvo.
Avtomatsko dodeljevanje rokov - če uporabnik ne vnese roka, naj bo rok privzeto določen na 7 dni od trenutnega datuma.

Statistika (uporabi Math) - prikaži odstotek opravljenih nalog.

Uporabi zanko za razvrščanje opravkov glede na prioriteto (nizka, srednja, visoka).
Razširitev posameznega opravka za ogled podrobnosti in brisanje opravkov.

Da ne bomo grizli nohtov - urejanje že ustvarjenih opravkov bomo zanemarili.

Stran mora biti ustrezno oblikovana - lahko uporabite isti CSS kot pri prejšnjih nalogah.
Naloga je vredna 3 točke.

3. Shramba podatkov (localStorage) - opcijsko oz. če imate preveč prostega časa
Ker se podatki pri osvežitvi strani izbrišejo, implementiraj shranjevanje opravkov z uporabo localStorage.

Podatke shrani v localStorage ob vsakem ustvarjanju/posodabljanju opravka.
Ko aplikacija naloži stran, preveri, ali obstajajo podatki v localStorage, in jih naloži.
Marsikdo bo pojamral, da to niste jemali pri teoriji. Ali pa mogoče ste? Nevertheless, kot ste morda zasledili v navodilih za izdelavo izdelka, morate localStorage uporabiti tudi v svojem izdelku. Za pomoč vam prilagam povezavo do razlage for dummies.
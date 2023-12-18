<p align="center" width="100%">
    <img width="33%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/SpotmarketSwitcherLogo.png?raw=true"> 
</p>

[Tšehhi](README.cs.md)-[taani keel](README.da.md)-[saksa keel](README.de.md)-[Inglise](README.md)-[hispaania keel](README.es.md)-[Estonian](README.et.md)-[soome keel](README.fi.md)-[prantsuse keel](README.fr.md)-[kreeka keel](README.el.md)-[itaalia keel](README.it.md)-[hollandi keel](README.nl.md)-[norra keel](README.no.md)-[poola keel](README.pl.md)-[portugali keel](README.pt.md)-[Svenska ](README.sv.md)-[Jaapani](README.ja.md)

## Tere tulemast Spotmarket-Switcheri hoidlasse!

Mida see tarkvara teeb?
Spotmarket-Switcher on lihtsalt kasutatav tarkvaratööriist, mis aitab säästa raha oma energiaarvetelt. Kui teil on nutikas akulaadija või sellised seadmed nagu boilerid, mis võivad automaatselt sisse ja välja lülituda, on see tööriist teile ideaalne! See lülitab teie seadmed nutikalt sisse, kui energiahinnad on madalad, eriti kasulik siis, kui teie energiakulud muutuvad iga tunni tagant.

Miks kasutada Spotmarket-Switcherit?

-   Säästke raha: see lülitab teie seadmed sisse, kui energia on odavam, vähendades sellega teie arveid.
-   Energiasäästlik: kasutades energiat, kui seda on ülejääk (nagu tuulised ööd), aitate kaasa rohelisema planeedi loomisele.
-   Nutikas kasutamine: laadige oma akut automaatselt või lülitage sisse seadmeid (nt veesoojendid) parimal ajal.

Toetatud süsteemid on praegu:

-   Shelly tooted (nt[Shelly pistik S](https://shellyparts.de/products/shelly-plus-plug-s)või[Shelly Plus](https://shellyparts.de/products/shelly-plus-1pm))
-   [AVMFritz!DECT200](https://avm.de/produkte/smart-home/fritzdect-200/)ja[210](https://avm.de/produkte/smart-home/fritzdect-210/)lülitatavad pistikupesad
-   [Victron](https://www.victronenergy.com/)Venus OS-i energiasalvestussüsteemid nagu[MultiPlus-II seeria](https://www.victronenergy.com/inverters-chargers)

Alustamine:

-   Laadige alla ja installige: häälestusprotsess on lihtne. Laadige skript alla, kohandage mõnda seadet ja oletegi valmis.
-   Ajastage ja lõdvestage: seadistage see üks kord ja see töötab automaatselt. Ei mingit igapäevast tüli!

Kas olete huvitatud?

-   Vaadake meie üksikasjalikke juhiseid erinevate süsteemide jaoks, nagu Victron Venus OS, Windows või Linux. Oleme veendunud, et samme on lihtne järgida.
-   Liituge meiega, et muuta energiakasutus nutikamaks ja kuluefektiivsemaks! Kui teil on küsimusi, soovitusi või tagasisidet, võtke julgelt ühendust.

Kood on lihtne, nii et seda saab hõlpsasti kohandada muude energiasalvestussüsteemidega, kui saate laadida laadimist Linuxi kestakäskude abil.
Palun vaadake aadressi controller.sh ja otsige üles Charger_command_turnon, et näha, kui lihtne on seda kohandada.
Looge githubi kahvel ja jagage oma kohandusi, et teised kasutajad saaksid sellest kasu.

## Andmeallikas

Tarkvara kasutab praegu EPEX Spot tunnihindu, mida pakuvad kolm tasuta API-d (Tibber, aWATTar ja Entso-E).
Integreeritud tasuta Entso-E API pakub energiahinna andmeid järgmistest riikidest:
Albaania (AL), Austria (AT), Belgia (BE), Bosnia ja Herz. (BA), Bulgaaria (BG), Horvaatia (HR), Küpros (CY), Tšehhi Vabariik (CZ), Taani (DK), Eesti (EE), Soome (FI), Prantsusmaa (FR), Gruusia (GE), Saksamaa (DE), Kreeka (GR), Ungari (HU), Iirimaa (IE), Itaalia (IT), Kosovo (XK), Läti (LV), Leedu (LT), Luksemburg (LU), Malta (MT), Moldova (MD), Montenegro (ME), Holland (NL), Põhja-Makedoonia (MK), Norra (NO), Poola (PL), Portugal (PT), Rumeenia (RO), Serbia (RS), Slovakkia (SK) , Sloveenia (SI), Hispaania (ES), Rootsi (SE), Šveits (CH), Türgi (TR), Ukraina (UA), Ühendkuningriik (UK) vt.[Läbipaistvus Entso-E platvorm](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show). 

![Screenshot 2023-12-15 221401](https://github.com/christian1980nrw/Spotmarket-Switcher/assets/6513794/25992602-b0a2-48ff-bd4c-64a6f8182297)

## Paigaldamine

Spotmarket-Switcheri seadistamine on lihtne protsess. Kui kasutate juba UNIX-põhist masinat (nt macOS, Linux või Windows koos Linuxi alamsüsteemiga), järgige tarkvara installimiseks järgmisi samme.

1.  Laadige installiskript alla GitHubi hoidlast, kasutades[see hüperlink](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh)või käivitage oma terminalis järgmine käsk:
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  Käivitage installiskript koos lisavalikutega, et alamkataloogis kõik kontrollimiseks ette valmistada. Näiteks:
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    Kui kasutate operatsioonisüsteemi Victron Venus, peaks DESTDIR olema õige`/`(juurkataloog). Tutvuge installitud failidega`/tmp/foo`.
    Cerbo GX-ile on failisüsteem ühendatud ainult lugemiseks. Vaata<https://www.victronenergy.com/live/ccgx:root_access>. Failisüsteemi kirjutatavaks muutmiseks peate enne installiskripti käivitamist käivitama järgmise käsu:
        /opt/victronenergy/swupdate-scripts/resize2fs.sh

Pange tähele, et kuigi see tarkvara on praegu Venus OS-i jaoks optimeeritud, saab seda kohandada teistele Linuxi maitsetele, nagu Debian/Ubuntu Raspberry Pi või mõne muu väikese plaadi jaoks. Peakandidaat on kindlasti[OpenWRT](https://www.openwrt.org). Lauaarvuti kasutamine sobib testimiseks, kuid ööpäevaringsel kasutamisel on selle suurem energiatarve murettekitav.

### Juurdepääs Venus OS-ile

Juhised Venus OS-ile juurdepääsu kohta leiate aadressilt<https://www.victronenergy.com/live/ccgx:root_access>.

### Installi skripti täitmine

-   Kui kasutate operatsioonisüsteemi Victron Venus:
    -   Seejärel muutke muutujaid tekstiredaktoriga`/data/etc/Spotmarket-Switcher/config.txt`.
    -   Seadistage ESS-i laadimisgraafik (vt kaasasolevat ekraanipilti). Näites laeb aku öösel kuni 50%, kui see on aktiveeritud, teisi päevaseid laadimisaegu eiratakse. Kui ei soovi, koosta ajakava kõigi 24 tunni jaoks. Ärge unustage seda pärast loomist deaktiveerida. Veenduge, et süsteemiaeg (nagu on näidatud ekraani paremas ülanurgas) on täpne.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

Ekraanipilt näitab automaatse laadimise konfiguratsiooni kasutaja määratud aegadel. Vaikimisi desaktiveeritud, skript võib ajutiselt aktiveerida.

-   Juhised Spotmarket-Switcheri installimiseks Windows 10 või 11 süsteemi, et testida ilma Victroni seadmeteta (ainult lülitatavad pistikupesad).

    -   käivitada`cmd.exe`administraatorina
    -   Sisenema`wsl --install -d Debian`
    -   Sisestage uus kasutajanimi nagu`admin`
    -   Sisestage uus parool
    -   Sisenema`sudo su`ja tippige oma parool
    -   Sisenema`apt-get update && apt-get install wget curl`
    -   Jätkake allpool oleva Linuxi käsitsi kirjeldusega (installeri skript ei ühildu).
    -   Ärge unustage, et kui sulgete kesta, peatab Windows süsteemi.


-   Kui kasutate Linuxi süsteemi nagu Ubuntu või Debian:
    -   Kopeeri kestaskript (`controller.sh`) kohandatud asukohta ja kohandage muutujaid vastavalt oma vajadustele.
    -   käsud on`cd /path/to/save/ && curl -s -O "https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/scripts/{controller.sh,sample.config.txt,license.txt}" && chmod +x ./controller.sh && mv sample.config.txt config.txt` and to edit your settings use `vi /path/to/save/config.txt`
    -   Selle skripti käivitamiseks iga tunni alguses looge crontab või muu ajastamismeetod.
    -   Crontabi näidis:
          Kasutage juhtskripti käivitamiseks iga tund järgmist crontab-kirjet:
          Avage oma terminal ja sisestage`crontab -e`, seejärel sisestage järgmine rida:`0 * * * * /path/to/controller.sh`

### Tugi ja panus :+1:

Kui leiate, et see projekt on väärtuslik, kaaluge sponsoreerimist ja edasise arengu toetamist järgmiste linkide kaudu:

-   [Revolut](https://revolut.me/christqki2)
-   [PayPal](https://paypal.me/christian1980nrw)

Kui olete Saksamaalt ja olete huvitatud dünaamilisele elektritariifile üleminekust, saate projekti toetada, registreerudes selle kaudu[Tibber (viitelink)](https://invite.tibber.com/ojgfbx2e)või sisestades koodi`ojgfbx2e`teie rakenduses. Saate nii teie kui ka projekt**50 eurot lisatasu riistvara eest**. Please note that a smart meter or a Pulse-IR is required for an hourly tariff (<https://tibber.com/de/store/produkt/pulse-ir>) .
Kui vajate maagaasi tariifi või eelistate klassikalist elektritariifi, saate siiski projekti toetada[Octopus Energy (viitelink)](https://share.octopusenergy.de/glass-raven-58).
Saate boonuse (pakkumine on erinev**vahemikus 50-120 eurot**) endale ja ka projektile.
Kaheksajala eeliseks on see, et mõned pakkumised on ilma minimaalse lepingu tähtajata. Need sobivad ideaalselt näiteks börsihindadel põhineva tariifi peatamiseks.

Kui olete pärit Austriast, saate meid toetada kasutades[aWATtar Austria (viitelink)](https://www.awattar.at/services/offers/promotecustomers). Palun kasutage ära`3KEHMQN2F`koodina.

## Vastutusest loobumine

Palun tutvuge kasutustingimustega aadressil<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/License.md>

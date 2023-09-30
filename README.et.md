<p align="center" width="100%">
    <img width="33%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/SpotmarketSwitcherLogo.png?raw=true"> 
</p>

[Tšehhi](README.cs.md)-[taani keel](README.da.md)-[saksa keel](README.de.md)-[Inglise](README.md)-[hispaania keel](README.es.md)-[Estonian](README.et.md)-[soome keel](README.fi.md)-[prantsuse keel](README.fr.md)-[kreeka keel](README.el.md)-[itaalia keel](README.it.md)-[hollandi keel](README.nl.md)-[norra keel](README.no.md)-[poola keel](README.pl.md)-[portugali keel](README.pt.md)-[rootsi keel](README.sv.md)-[Jaapani](README.ja.md)

## Tere tulemast Spotmarket-Switcheri hoidlasse!

Mida see tarkvara teeb?
See on Linuxi kestaskript, mis lülitab teie akulaadija ja/või lülitatavad pistikupesad õigel ajal sisse, kui teie tunnipõhised dünaamilised energiahinnad on madalad.
Seejärel saate pistikupesade abil sooja veepaagi palju soodsamalt sisse lülitada või saate akuhoidlat automaatselt laadida öösel, kui võrgus on saadaval odav tuuleenergia.
Oodatavat päikeseenergiat saab arvesse võtta ilmastiku API ja vastavalt reserveeritud aku salvestusruumi kaudu.
Toetatud süsteemid on praegu:

-   Shelly tooted (nt[Shelly pistik S](https://shellyparts.de/products/shelly-plus-plug-s)või[Shelly Plus](https://shellyparts.de/products/shelly-plus-1pm))
-   [AVMFritz!DECT200](https://avm.de/produkte/smart-home/fritzdect-200/)ja[210](https://avm.de/produkte/smart-home/fritzdect-210/)lülitatavad pistikupesad
-   [Victron](https://www.victronenergy.com/)Venus OS-i energiasalvestussüsteemid nagu[MultiPlus-II seeria](https://www.victronenergy.com/inverters-chargers)

Kood on lihtne, nii et seda saab hõlpsasti kohandada muude energiasalvestussüsteemidega, kui saate laadida laadimist Linuxi kestakäskude abil.
Palun vaadake faili controller.sh rida 100 alt, et saaksite näha, mida kasutaja saab seadistada.

## Andmeallikas

Tarkvara kasutab praegu EPEX Spoti tunnihindu, mida pakuvad kolm tasuta API-d (Tibber, aWATTar ja Entso-E).
Integreeritud tasuta Entso-E API pakub energiahinna andmeid järgmistest riikidest:
Albaania (AL), Austria (AT), Belgia (BE), Bosnia ja Herz. (BA), Bulgaaria (BG), Horvaatia (HR), Küpros (CY), Tšehhi Vabariik (CZ), Taani (DK), Eesti (EE), Soome (FI), Prantsusmaa (FR), Gruusia (GE), Saksamaa (DE), Kreeka (GR), Ungari (HU), Iirimaa (IE), Itaalia (IT), Kosovo (XK), Läti (LV), Leedu (LT), Luksemburg (LU), Malta (MT), Moldova (MD), Montenegro (ME), Holland (NL), Põhja-Makedoonia (MK), Norra (NO), Poola (PL), Portugal (PT), Rumeenia (RO), Serbia (RS), Slovakkia (SK) , Sloveenia (SI), Hispaania (ES), Rootsi (SE), Šveits (CH), Türgi (TR), Ukraina (UA), Ühendkuningriik (UK) vt.[Läbipaistvus Entso-E platvorm](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![grafik](https://user-images.githubusercontent.com/6513794/224442951-c0155a48-f32b-43f4-8014-d86d60c3b311.png)

## Paigaldamine

Spotmarket-Switcheri seadistamine on lihtne protsess. Kui kasutate juba UNIX-põhist masinat (nt macOS, Linux või Windows koos Linuxi alamsüsteemiga), järgige tarkvara installimiseks järgmisi samme.

1.  Laadige installiskript alla GitHubi hoidlast, kasutades[see hüperlink](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh)või käivitage oma terminalis järgmine käsk:
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  Käivitage installiskript koos lisavalikutega, et alamkataloogis kõik kontrollimiseks ette valmistada. Näiteks:
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    Kui kasutate operatsioonisüsteemi Victron Venus, peaks DESTDIR olema õige`/`(juurkataloog). Tutvuge installitud failidega`/tmp/foo`.

Pange tähele, et kuigi see tarkvara on praegu Venus OS-i jaoks optimeeritud, saab seda kohandada muudele Linuxi maitsetele, nagu Debian/Ubuntu Raspberry Pi-l või mõnel muul väikesel tahvlil. Peakandidaat on kindlasti[OpenWRT](https://www.openwrt.org). Lauaarvuti kasutamine sobib testimiseks, kuid ööpäevaringsel kasutamisel on selle suurem energiatarve murettekitav.

### Juurdepääs Venus OS-ile

Juhised Venus OS-ile juurdepääsu kohta leiate aadressilt<https://www.victronenergy.com/live/ccgx:root_access>.

### Installi skripti täitmine

-   Kui kasutate operatsioonisüsteemi Victron Venus:
    -   Pärast täitmist`victron-venus-os-install.sh`, muutke muutujaid tekstiredaktoriga`/data/etc/Spotmarket-Switcher/controller.sh`.
    -   Seadistage ESS-i laadimisgraafik (vt kaasasolevat ekraanipilti). Näites laeb aku öösel kuni 50%, kui see on aktiveeritud, teisi päevaseid laadimisaegu eiratakse. Kui ei soovi, koosta ajakava kõigi 24 tunni jaoks. Ärge unustage seda pärast loomist deaktiveerida. Veenduge, et süsteemiaeg (nagu on näidatud ekraani paremas ülanurgas) on täpne.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

The Screenshot is showing the configuration of automated charging during user defined times. Deactivated by default, may be temporarily activated by the script.

-   Juhised Spotmarket-Switcheri installimiseks Windows 10 või 11 süsteemi, et testida ilma Victroni seadmeteta (ainult lülitatavad pistikupesad).

    -   käivitada`cmd.exe`administraatorina
    -   Sisenema`wsl --install -d Debian`
    -   Sisestage uus kasutajanimi nagu`admin`
    -   Sisestage uus parool
    -   Sisenema`sudo su`ja tippige oma parool
    -   Sisenema`apt-get update && apt-get install wget curl`
    -   Jätkake allpool oleva Linuxi kirjeldusega


-   Kui kasutate Linuxi süsteemi nagu Ubuntu või Debian:
    -   Kopeeri kestaskript (`controller.sh`) kohandatud asukohta ja kohandage muutujaid vastavalt oma vajadustele.
    -   käsud on`cd /path/to/save/ && wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/scripts/controller.sh && chmod +x ./controller.sh`ja redigeerimiseks`vi /path/to/save/controller.sh`
    -   Selle skripti käivitamiseks iga tunni alguses looge crontab või muu ajastamismeetod.
    -   Crontabi näidis:
          Kasutage juhtskripti käivitamiseks iga tund järgmist crontab-kirjet:
          Avage oma terminal ja sisestage`crontab -e`, seejärel sisestage järgmine rida:`0 * * * * /path/to/controller.sh`

### Toetus ja panus

Kui leiate, et see projekt on väärtuslik, kaaluge sponsoreerimist ja edasise arengu toetamist järgmiste linkide kaudu:

-   [Revolut](https://revolut.me/christqki2)
-   [PayPal](https://paypal.me/christian1980nrw)

Lisaks, kui olete Saksamaal ja olete huvitatud dünaamilisele elektritariifile üleminekust, saate projekti toetada, registreerudes selle kaudu[Tibber (viitelink)](https://invite.tibber.com/ojgfbx2e). Nii sina kui projekt saate 50 euro suuruse riistvara boonuse. Pange tähele, et tunnitariifi jaoks on vaja nutikat arvestit või Pulse-IR-i (<https://tibber.com/de/store/produkt/pulse-ir>) .

Kui vajate maagaasi tariifi või eelistate klassikalist elektritariifi, saate siiski projekti toetada[Octopus Energy (viitelink)](https://share.octopusenergy.de/glass-raven-58).
Saate endale ja ka projektile 50 eurot boonust.
Kaheksajala eeliseks on see, et lepingud on tavaliselt ainult igakuised. Need sobivad ideaalselt näiteks börsihindadel põhineva tariifi peatamiseks.

## Vastutusest loobumine

Palun tutvuge kasutustingimustega aadressil<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/License.md>

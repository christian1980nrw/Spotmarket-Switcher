<p align="center" width="100%">
    <img width="33%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/SpotmarketSwitcherLogo.png?raw=true"> 
</p>

[Tsjechisch](README.cs.md)-[Deens](README.da.md)-[Duits](README.de.md)-[Engels](README.md)-[Spaans](README.es.md)-[Ests](README.et.md)-[Fins](README.fi.md)-[Frans](README.fr.md)-[Grieks](README.el.md)-[Italiaans](README.it.md)-[Nederlands](README.nl.md)-[Noors](README.no.md)-[Pools](README.pl.md)-[Portugees](README.pt.md)-[Zweeds](README.sv.md)-[Japans](README.ja.md)

## Welkom bij de Spotmarket-Switcher-repository!

Wat doet deze software?
Spotmarket-Switcher is een eenvoudig te gebruiken softwaretool waarmee u geld kunt besparen op uw energierekening. Als je een slimme batterijlader hebt of apparaten zoals boilers die automatisch kunnen worden in- en uitgeschakeld, dan is deze tool perfect voor jou! Hij schakelt je apparaten slim in als de energieprijzen laag zijn, vooral handig als je energiekosten elk uur veranderen.

Dit typische resultaat demonstreert het vermogen van de Spotmarket-Switcher om het energieverbruik efficiënt te automatiseren, waardoor niet alleen kosten worden bespaard, maar ook het gebruik van hernieuwbare energiebronnen wordt geoptimaliseerd. Het is een goed voorbeeld van hoe slimme technologie kan worden gebruikt om het energieverbruik op een duurzamere en kosteneffectievere manier te beheren.

<p align="center" width="100%">
    <img width="50%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/Screenshot.jpg?raw=true"> 
</p>

-   Nachtelijk gebruik: Tijdens de nacht, toen de energieprijzen het laagst waren, activeerde de Spotmarket-Switcher op slimme wijze een schakelbaar stopcontact om de warmwater-warmtepomp (aangegeven in rood) van stroom te voorzien. Dit toont aan dat het systeem in staat is om goedkope energieperioden voor energie-intensieve taken te identificeren en te gebruiken.
-   Economische efficiëntie bij het opladen van de batterij: het script heeft strategisch besloten om de batterijopslag op dit moment niet op te laden. Deze beslissing was gebaseerd op een economische controle waarbij rekening werd gehouden met laadverliezen en deze werden vergeleken met de gemiddelde of hoogste energieprijzen van de dag. Deze aanpak zorgt ervoor dat het opladen van de batterij alleen plaatsvindt wanneer dit het meest kosteneffectief is.
-   Optimaal batterijgebruik tijdens piekuren: In de grafiek worden de duurste energie-uren in de ochtend en avond weergegeven. Tijdens deze periodes gebruikte de Spotmarket-Switcher de opgeslagen energie in de batterij (blauw weergegeven), waardoor hoge elektriciteitskosten werden vermeden. Dit is een slimme strategie om de energiekosten te verlagen door opgeslagen energie te gebruiken wanneer het duurder is om van het elektriciteitsnet te putten.
-   Batterijreservering voor uren met hoge kosten: Na de perioden met hoge kosten werd het energieopslagsysteem (ESS) van de batterij uitgeschakeld. Deze actie werd ondernomen om voldoende batterijcapaciteit te reserveren voor de komende dure uren in de volgende ochtend. Het is een vooruitstrevende aanpak die anticipeert op toekomstige perioden met hoge kosten en ervoor zorgt dat opgeslagen energie beschikbaar is om deze kosten te compenseren.

Waarom Spotmarket-Switcher gebruiken?

-   Bespaar geld: het schakelt uw apparaten in wanneer energie goedkoper is, waardoor uw rekeningen dalen.
-   Energie-efficiënt: Door energie te gebruiken wanneer er een overschot is (zoals winderige nachten), draagt ​​u bij aan een groenere planeet.
-   Slim gebruik: laad automatisch uw batterijopslag op of schakel apparaten zoals boilers op de beste tijden in.

Ondersteunde systemen zijn momenteel:

-   Shelly-producten (zoals[Shelly Plug S](https://shellyparts.de/products/shelly-plus-plug-s)of[Shelly Plus](https://shellyparts.de/products/shelly-plus-1pm))
-   [AVMFritz!DECT200](https://avm.de/produkte/smart-home/fritzdect-200/)En[210](https://avm.de/produkte/smart-home/fritzdect-210/)schakelbare stopcontacten
-   [Victron](https://www.victronenergy.com/)Venus OS energieopslagsystemen zoals de[MultiPlus-II-serie](https://www.victronenergy.com/inverters-chargers)

Aan de slag:

-   Downloaden en installeren: Het installatieproces is eenvoudig. Download het script, pas een paar instellingen aan en je bent klaar om aan de slag te gaan.
-   Plannen en ontspannen: Stel het één keer in en het wordt automatisch uitgevoerd. Geen dagelijkse rompslomp!

Geïnteresseerd?

-   Bekijk onze gedetailleerde instructies voor verschillende systemen zoals Victron Venus OS-, Windows- of Linux-installaties. We hebben ervoor gezorgd dat de stappen eenvoudig te volgen zijn.
-   Help ons mee om het energieverbruik slimmer en kosteneffectiever te maken! Voor vragen, suggesties of feedback kunt u gerust contact opnemen.

De code is eenvoudig, zodat deze gemakkelijk kan worden aangepast aan andere energieopslagsystemen als je het opladen kunt regelen met Linux-shell-opdrachten.
Kijk eens op controller.sh en zoek naar Charger_command_turnon, zodat je kunt zien hoe eenvoudig het kan worden aangepast.
Maak een github-fork en deel uw aanpassingen zodat andere gebruikers ervan kunnen profiteren.

## Databron

De software maakt momenteel gebruik van EPEX Spot-uurprijzen die worden aangeboden door drie gratis API's (Tibber, aWATTar en Entso-E).
De geïntegreerde gratis Entso-E API levert energieprijsgegevens van de volgende landen:
Albanië (AL), Oostenrijk (AT), België (BE), Bosnië en Herz. (BA), Bulgarije (BG), Kroatië (HR), Cyprus (CY), Tsjechië (CZ), Denemarken (DK), Estland (EE), Finland (FI), Frankrijk (FR), Georgië (GE), Duitsland (DE), Griekenland (GR), Hongarije (HU), Ierland (IE), Italië (IT), Kosovo (XK), Letland (LV), Litouwen (LT), Luxemburg (LU), Malta (MT), Moldavië (MD), Montenegro (ME), Nederland (NL), Noord-Macedonië (MK), Noorwegen (NO), Polen (PL), Portugal (PT), Roemenië (RO), Servië (RS), Slowakije (SK) , Slovenië (SI), Spanje (ES), Zweden (SE), Zwitserland (CH), Turkije (TR), Oekraïne (UA), Verenigd Koninkrijk (UK) zie[Transparantie Entso-E-platform](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![Screenshot 2023-12-15 221401](https://github.com/christian1980nrw/Spotmarket-Switcher/assets/6513794/25992602-b0a2-48ff-bd4c-64a6f8182297)

## Installatie

Het opzetten van de Spotmarket-Switcher is een eenvoudig proces. Als u al een op UNIX gebaseerde machine gebruikt, zoals macOS, Linux of Windows met het Linux-subsysteem, volgt u deze stappen om de software te installeren:

1.  Download het installatiescript uit de GitHub-opslagplaats met behulp van[deze hyperlink](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh), of voer de volgende opdracht uit in uw terminal:
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  Voer het installatiescript uit met extra opties om alles in een submap voor te bereiden voor uw inspectie. Bijvoorbeeld:
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    Als u Victron Venus OS gebruikt, zou de juiste DESTDIR moeten zijn`/`(de hoofdmap). Voel je vrij om de geïnstalleerde bestanden te verkennen in`/tmp/foo`.
    Op een Cerbo GX is het bestandssysteem alleen-lezen aangekoppeld. Zien<https://www.victronenergy.com/live/ccgx:root_access>. Om het bestandssysteem schrijfbaar te maken, moet u de volgende opdracht uitvoeren voordat u het installatiescript uitvoert:
        /opt/victronenergy/swupdate-scripts/resize2fs.sh

Houd er rekening mee dat hoewel deze software momenteel is geoptimaliseerd voor het Venus OS, deze kan worden aangepast aan andere Linux-smaken, zoals Debian/Ubuntu op een Raspberry Pi of een ander klein bord. Een topkandidaat is dat zeker[OpenWRT](https://www.openwrt.org). Het gebruik van een desktopmachine is prima voor testdoeleinden, maar bij 24/7 gebruik is het grotere energieverbruik een probleem.

### Toegang tot Venus OS

Voor instructies over toegang tot het Venus OS raadpleegt u<https://www.victronenergy.com/live/ccgx:root_access>.

### Uitvoering van het installatiescript

-   Als u Victron Venus OS gebruikt:
    -   Bewerk vervolgens de variabelen met een teksteditor`/data/etc/Spotmarket-Switcher/config.txt`.
    -   Stel een ESS-laadschema in (zie de meegeleverde schermafbeelding). In het voorbeeld laadt de batterij 's nachts tot 50% op, indien geactiveerd, andere oplaadtijden van de dag worden genegeerd. Indien niet gewenst, maak dan een schema voor alle 24 uur van de dag. Vergeet niet om het na het maken te deactiveren. Controleer of de systeemtijd (zoals weergegeven in de rechterbovenhoek van het scherm) juist is.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

De schermafbeelding toont de configuratie van automatisch opladen tijdens door de gebruiker gedefinieerde tijden. Standaard gedeactiveerd, kan tijdelijk worden geactiveerd door het script.

-   Instructies voor het installeren van de Spotmarket-Switcher op een Windows 10- of 11-systeem voor testen zonder Victron-apparaten (alleen schakelbare stopcontacten).

    -   launch`cmd.exe`als Beheerder
    -   Binnenkomen`wsl --install -d Debian`
    -   Voer een nieuwe gebruikersnaam in, zoals`admin`
    -   Voer een nieuw wachtwoord in
    -   Binnenkomen`sudo su`en typ uw wachtwoord
    -   Binnenkomen`apt-get update && apt-get install wget curl`
    -   Ga verder met de onderstaande handleiding voor Linux (installatiescript is niet compatibel).
    -   Vergeet niet dat Windows het systeem zal stoppen als u de shell sluit.


-   Als je een Linux-systeem zoals Ubuntu of Debian gebruikt:
    -   Kopieer het shellscript (`controller.sh`) naar een aangepaste locatie en pas de variabelen aan uw behoeften aan.
    -   de commando's zijn`cd /path/to/save/ && curl -s -O "https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/scripts/{controller.sh,sample.config.txt,license.txt}" && chmod +x ./controller.sh && mv sample.config.txt config.txt`en om uw instellingen te bewerken gebruikt u`vi /path/to/save/config.txt`
    -   Maak een crontab of een andere planningsmethode om dit script aan het begin van elk uur uit te voeren.
    -   Voorbeeldcrontab:
          Gebruik de volgende crontab-invoer om het controlescript elk uur uit te voeren:
          Open uw terminal en ga naar binnen`crontab -e`en voeg vervolgens de volgende regel in:`0 * * * * /path/to/controller.sh`

### Ondersteuning en bijdrage:+1:

Als u dit project waardevol vindt, overweeg dan om verdere ontwikkeling te sponsoren en te ondersteunen via deze links:

-   [Revolutie](https://revolut.me/christqki2)
-   [PayPal](https://paypal.me/christian1980nrw)

Als u uit Duitsland komt en geïnteresseerd bent in de overstap naar een dynamisch elektriciteitstarief, kunt u het project steunen door u hier aan te melden[Tibber (verwijzingslink)](https://invite.tibber.com/ojgfbx2e)of door de code in te voeren`ojgfbx2e`in uw app. Zowel jij als het project zullen ontvangen**50 euro bonus voor hardware**. Houd er rekening mee dat voor een uurtarief een slimme meter of een Pulse-IR nodig is (<https://tibber.com/de/store/produkt/pulse-ir>).
Indien u een aardgastarief nodig heeft of de voorkeur geeft aan een klassiek elektriciteitstarief, kunt u het project nog steeds steunen[Octopus Energy (verwijzingslink)](https://share.octopusenergy.de/glass-raven-58).
Je ontvangt een bonus (het aanbod varieert**tussen 50 en 120 euro**) voor uzelf en ook voor het project.
Octopus heeft het voordeel dat sommige aanbiedingen geen minimale contractduur hebben. Ze zijn bijvoorbeeld ideaal om een ​​tarief op basis van beurskoersen te pauzeren.

Als u uit Oostenrijk komt, kunt u ons steunen door gebruik te maken van[aWATTar Oostenrijk (verwijzingslink)](https://www.awattar.at/services/offers/promotecustomers). Maak er alstublieft gebruik van`3KEHMQN2F`als code.

## Vrijwaring

Let op de gebruiksvoorwaarden op<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/License.md>

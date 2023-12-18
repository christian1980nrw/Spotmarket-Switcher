<p align="center" width="100%">
    <img width="33%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/SpotmarketSwitcherLogo.png?raw=true"> 
</p>

[tjeckiska](README.cs.md)-[danska](README.da.md)-[tysk](README.de.md)-[engelsk](README.md)-[spanska](README.es.md)-[estniska](README.et.md)-[finska](README.fi.md)-[franska](README.fr.md)-[grekisk](README.el.md)-[italienska](README.it.md)-[holländska](README.nl.md)-[norska](README.no.md)-[putsa](README.pl.md)-[portugisiska](README.pt.md) - [Svenska](README.sv.md)-[japanska](README.ja.md)

## Välkommen till Spotmarket-Switcher-förrådet!

Vad gör denna programvara?
Spotmarket-Switcher är ett lättanvänt mjukvaruverktyg som hjälper dig att spara pengar på dina energiräkningar. Om du har en smart batteriladdare eller enheter som varmvattenberedare som kan slås på och stängas av automatiskt, är detta verktyg perfekt för dig! Den sätter smart på dina enheter när energipriserna är låga, särskilt användbart om dina energikostnader ändras varje timme.

Varför använda Spotmarket-Switcher?

-   Spara pengar: Det sätter på dina enheter när energin är billigare, vilket minskar dina räkningar.
-   Energieffektiv: Genom att använda energi när den är i överskott (som blåsiga nätter) bidrar du till en grönare planet.
-   Smart användning: Ladda din batterilagring automatiskt eller slå på enheter som varmvattenberedare vid de bästa tiderna.

System som stöds är för närvarande:

-   Shelly-produkter (t.ex[Shelly Plug S](https://shellyparts.de/products/shelly-plus-plug-s)eller[Shelly Plus](https://shellyparts.de/products/shelly-plus-1pm))
-   [AVMFritz!DECT200](https://avm.de/produkte/smart-home/fritzdect-200/)och[210](https://avm.de/produkte/smart-home/fritzdect-210/)omkopplingsbara uttag
-   [Victron](https://www.victronenergy.com/)Venus OS energilagringssystem som[MultiPlus-II series](https://www.victronenergy.com/inverters-chargers)

Komma igång:

-   Ladda ner och installera: Installationsprocessen är enkel. Ladda ner skriptet, justera några inställningar och du är redo att gå.
-   Schemalägg och koppla av: Ställ in det en gång, så körs det automatiskt. Inget dagligt krångel!

Intresserad?

-   Kolla in våra detaljerade instruktioner för olika system som Victron Venus OS, Windows eller Linux-inställningar. Vi har sett till att stegen är enkla att följa.
-   Var med och gör energianvändningen smartare och mer kostnadseffektiv! För frågor, förslag eller feedback är du välkommen att höra av dig.

Koden är enkel så att den lätt kan anpassas till andra energilagringssystem om du kan styra laddningen med Linux-skalkommandon.
Ta en titt på controller.sh och sök efter charger_command_turnon så att du kan se hur enkelt den kan anpassas.
Skapa en github-gaffel och dela din anpassning så att andra användare kan dra nytta av den.

## Datakälla

Mjukvaran använder för närvarande EPEX Spot timpriser som tillhandahålls av tre gratis API:er (Tibber, aWATTar & Entso-E).
Den integrerade kostnadsfria Entso-E API tillhandahåller energiprisdata för följande länder:
Albanien (AL), Österrike (AT), Belgien (BE), Bosnien och Herz. (BA), Bulgarien (BG), Kroatien (HR), Cypern (CY), Tjeckien (CZ), Danmark (DK), Estland (EE), Finland (FI), Frankrike (FR), Georgien (GE), Tyskland (DE), Grekland (GR), Ungern (HU), Irland (IE), Italien (IT), Kosovo (XK), Lettland (LV), Litauen (LT), Luxemburg (LU), Malta (MT), Moldavien (MD), Montenegro (ME), Nederländerna (NL), Nordmakedonien (MK), Norge (NO), Polen (PL), Portugal (PT), Rumänien (RO), Serbien (RS), Slovakien (SK) , Slovenien (SI), Spanien (ES), Sverige (SE), Schweiz (CH), Turkiet (TR), Ukraina (UA), Storbritannien (UK) se[Transparens Entso-E-plattform](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![Screenshot 2023-12-15 221401](https://github.com/christian1980nrw/Spotmarket-Switcher/assets/6513794/25992602-b0a2-48ff-bd4c-64a6f8182297)

## Installation

Att installera Spotmarket-Switcher är en enkel process. Om du redan kör en UNIX-baserad maskin, som macOS, Linux eller Windows med Linux-undersystemet, följ dessa steg för att installera programvaran:

1.  Ladda ner installationsskriptet från GitHub-förvaret genom att använda[denna hyperlänk](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh), eller kör följande kommando i din terminal:
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  Kör installationsskriptet med ytterligare alternativ för att förbereda allt i en underkatalog för din inspektion. Till exempel:
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    Om du använder Victron Venus OS bör rätt DESTDIR vara`/`(rotkatalogen). Utforska gärna de installerade filerna i`/tmp/foo`.
    På en Cerbo GX är filsystemet skrivskyddat monterat. Ser<https://www.victronenergy.com/live/ccgx:root_access>. För att göra filsystemet skrivbart måste du köra följande kommando innan du kör installationsskriptet:
        /opt/victronenergy/swupdate-scripts/resize2fs.sh

Observera att även om denna programvara för närvarande är optimerad för Venus OS, kan den anpassas till andra Linux-smaker, som Debian/Ubuntu på en Raspberry Pi eller ett annat litet kort. En främsta kandidat är definitivt[ÖppnaWRT](https://www.openwrt.org). Att använda en stationär dator är bra för teständamål, men när den används dygnet runt, är dess större strömförbrukning ett problem.

### Tillgång till Venus OS

För instruktioner om hur du kommer åt Venus OS, se<https://www.victronenergy.com/live/ccgx:root_access>.

### Körning av installationsskriptet

-   Om du använder Victron Venus OS:
    -   Redigera sedan variablerna med en textredigerare i`/data/etc/Spotmarket-Switcher/config.txt`.
    -   Ställ in ett ESS-avgiftsschema (se den medföljande skärmdumpen). I exemplet laddas batteriet på natten upp till 50 % om det är aktiverat, andra laddningstider på dygnet ignoreras. Om du inte vill, skapa ett schema för dygnets alla 24 timmar. Kom ihåg att avaktivera det efter att du skapat det. Kontrollera att systemtiden (som visas uppe till höger på skärmen) är korrekt.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

Skärmdumpen visar konfigurationen av automatisk laddning under användardefinierade tider. Inaktiverad som standard, kan tillfälligt aktiveras av skriptet.

-   Instruktioner för att installera Spotmarket-Switcher på ett Windows 10- eller 11-system för testning utan Victron-enheter (endast omkopplingsbara uttag).

    -   lansera`cmd.exe`som administratör
    -   Stiga på`wsl --install -d Debian`
    -   Ange ett nytt användarnamn som`admin`
    -   Ange ett nytt lösenord
    -   Stiga på`sudo su`och skriv ditt lösenord
    -   Stiga på`apt-get update && apt-get install wget curl`
    -   Fortsätt med den manuella Linux-beskrivningen nedan (installationsskriptet är inte kompatibelt).
    -   Glöm inte om du stänger skalet, Windows kommer att stoppa systemet.


-   Om du använder ett Linux-system som Ubuntu eller Debian:
    -   Kopiera skalskriptet (`controller.sh`) till en anpassad plats och justera variablerna efter dina behov.
    -   kommandona är`cd /path/to/save/ && curl -s -O "https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/scripts/{controller.sh,sample.config.txt,license.txt}" && chmod +x ./controller.sh && mv sample.config.txt config.txt`och för att redigera dina inställningar använd`vi /path/to/save/config.txt`
    -   Skapa en crontab eller annan schemaläggningsmetod för att köra det här skriptet i början av varje timme.
    -   Exempel Crontab:
          Använd följande crontab-post för att köra kontrollskriptet varje timme:
          Öppna din terminal och skriv in`crontab -e`, infoga sedan följande rad:`0 * * * * /path/to/controller.sh`

### Support och bidrag :+1:

Om du tycker att det här projektet är värdefullt, vänligen överväg att sponsra och stödja ytterligare utveckling via dessa länkar:

-   [Revolut](https://revolut.me/christqki2)
-   [PayPal](https://paypal.me/christian1980nrw)

Om du är från Tyskland och är intresserad av att byta till en dynamisk eltariff kan du stödja projektet genom att registrera dig med denna[Tibber (remisslänk)](https://invite.tibber.com/ojgfbx2e)eller genom att ange koden`ojgfbx2e`i din app. Både du och projektet kommer att få**50 euro bonus för hårdvara**. Observera att en smart mätare eller en Pulse-IR krävs för en timtaxa (<https://tibber.com/de/store/produkt/pulse-ir>) .
Om du behöver en naturgastariff eller föredrar en klassisk eltaxa kan du fortfarande stödja projektet[Octopus Energy (referenslänk)](https://share.octopusenergy.de/glass-raven-58).
Du får en bonus (erbjudandet varierar**between 50 and 120 euro**) för dig själv och även för projektet.
Octopus har fördelen att vissa erbjudanden är utan minimikontraktstid. De är till exempel idealiska för att pausa en tariff baserad på börskurser.

Om du är från Österrike kan du stödja oss genom att använda[aWATTar Österrike (referenslänk)](https://www.awattar.at/services/offers/promotecustomers). Vänligen använd`3KEHMQN2F`som kod.

## varning

Observera användarvillkoren på<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/License.md>

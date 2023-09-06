# Spotmarket-Switcher-Repository

## README Översättning

-   [engelsk](README.md)-[tysk](README.de.md)-[franska](README.fr.md)-[Spanish](README.es.md)-[svenska](README.sv.md)-[norska](README.no.md)-[danska](README.da.md)

Välkommen till Spotmarket-Switcher-förrådet! Denna programvara är utformad för att förbättra funktionaliteten i din energiinstallation genom att integrera:

-   [Victron](https://www.victronenergy.com/)Venus OS energilagringssystem
-   Shelly-produkter (som Shelly Plug S eller Shelly Plus1PM)
-   AVM Fritz!DECT200 och 210 omkopplingsbara uttag

Det primära målet med denna programvara är att ge ditt system möjlighet att reagera på elpriser på spotmarknaden, så att det kan fatta intelligenta beslut som batteriladdning och strömaktivering baserat på lågprisperioder. Den förväntade solavkastningen kan tas med i beräkningen via en väder-API och batterilagring reserverad i enlighet därmed.

## Datakälla

Mjukvaran använder för närvarande EPEX Spot timpriser som tillhandahålls av tre gratis API:er (Tibber, aWATTar & Entso-E).
Den integrerade kostnadsfria Entso-E API tillhandahåller energiprisdata för följande länder:
Albanien (AL), Österrike (AT), Belgien (BE), Bosnien och Herz. (BA), Bulgarien (BG), Kroatien (HR), Cypern (CY), Tjeckien (CZ), Danmark (DK), Estland (EE), Finland (FI), Frankrike (FR), Georgien (GE), Tyskland (DE), Grekland (GR), Ungern (HU), Irland (IE), Italien (IT), Kosovo (XK), Lettland (LV), Litauen (LT), Luxemburg (LU), Malta (MT), Moldavien (MD), Montenegro (ME), Nederländerna (NL), Nordmakedonien (MK), Norge (NO), Polen (PL), Portugal (PT), Rumänien (RO), Serbien (RS), Slovakien (SK) , Slovenien (SI), Spanien (ES), Sverige (SE), Schweiz (CH), Turkiet (TR), Ukraina (UA), Storbritannien (UK) se[Transparency Entso-E Platform](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![grafik](https://user-images.githubusercontent.com/6513794/224442951-c0155a48-f32b-43f4-8014-d86d60c3b311.png)

## Installation

Att installera Spotmarket-Switcher är en enkel process. Om du redan kör en UNIX-baserad maskin, som macOS, Linux eller Windows med Linux-undersystemet, följ dessa steg för att installera programvaran:

1.  Ladda ner installationsskriptet från GitHub-förvaret genom att använda[denna hyperlänk](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh), eller kör följande kommando i din terminal:
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  Run the installer script with additional options to prepare everything in a subdirectory for your inspection. For example:
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    Om du använder Victron Venus OS bör rätt DESTDIR vara`/`(rotkatalogen). Utforska gärna de installerade filerna i`/tmp/foo`.

Observera att även om den här programvaran för närvarande är optimerad för Venus OS, kan den anpassas till andra inställningar, som att styra hushållsenheter via IP-switchar. Framtida utveckling kan förbättra kompatibiliteten med andra system.

### Access to Venus OS

För instruktioner om hur du kommer åt Venus OS, se<https://www.victronenergy.com/live/ccgx:root_access>.

### Körning av installationsskriptet

-   Om du använder Victron Venus OS:
    -   Kör`victron-venus-os-install.sh`för att ladda ner och installera Spotmarket-Switcher.
    -   Redigera variablerna med en textredigerare i`/data/etc/Spotmarket-Switcher/controller.sh`.
    -   Ställ in ett ESS-avgiftsschema (se den medföljande skärmdumpen). I exemplet laddas batteriet på natten upp till 50 % om det är aktiverat. Kom ihåg att avaktivera det efter att du skapat det. Kontrollera att systemtiden (som visas på skärmdumpen) är korrekt.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

-   Om du använder ett annat operativsystem:
    -   Kopiera skalskriptet (`controller.sh`) till en anpassad plats och justera variablerna efter dina behov.
    -   Skapa en crontab eller annan schemaläggningsmetod för att köra det här skriptet i början av varje timme.
    -   Exempel Crontab:
          Använd följande crontab-post för att köra kontrollskriptet varje timme:
          Öppna din terminal och skriv in`crontab -e`, infoga sedan följande rad:
            0 * * * * /path/to/controller.sh

### Stöd och bidrag

Om du tycker att det här projektet är värdefullt, vänligen överväg att sponsra och stödja ytterligare utveckling via dessa länkar:

-   [Revolut](https://revolut.me/christqki2)
-   [PayPal](https://paypal.me/christian1980nrw)

Additionally, if you're in Germany and interested in switching to a dynamic electricity tariff, you can support the project by signing up using this [Tibber (remisslänk)](https://invite.tibber.com/ojgfbx2e). Både du och projektet kommer att få en bonus på 50 euro för hårdvara. Observera att en smart mätare eller en Pulse-IR krävs för en timtaxa (<https://tibber.com/de/store/produkt/pulse-ir>) .

Om du behöver en naturgastariff eller föredrar en klassisk eltaxa kan du fortfarande stödja projektet[Octopus Energy (referenslänk)](https://share.octopusenergy.de/glass-raven-58).
Du får en bonus på 50 euro för dig själv och även för projektet.
Octopus har fördelen att kontrakten oftast bara har en månatlig löptid. De är till exempel idealiska för att pausa en tariff baserad på börskurser.

## varning

Observera användarvillkoren på<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/dev/License.md>

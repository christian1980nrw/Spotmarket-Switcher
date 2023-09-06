# Spotmarket-Switcher-Repository

## README Översättning

-   [engelsk](README.md)-[Deutsch](README.de.md)-[franska](README.fr.md)-[spanska](README.es.md)-[Svenska](README.sv.md)-[norska](README.no.md)-[danska](README.da.md)

Välkommen till Spotmarket-Switcher-förrådet!

Vad gör denna programvara?
Detta är ett linux-skalskript och sätter på din batteriladdare och/eller omkopplingsbara uttag vid rätt tidpunkt om dina timbaserade energipriser är låga.
Du kan då använda uttagen för att använda exempelvis en varmvattentank mycket billigare eller automatiskt ladda batterilagret nattetid när billig vindenergi finns tillgänglig på nätet.
Den förväntade solavkastningen kan tas med i beräkningen via en väder-API och batterilagring reserverad i enlighet därmed.
System som stöds är för närvarande:

-   Shelly-produkter (som Shelly Plug S eller Shelly Plus1PM)
-   AVM Fritz!DECT200 och 210 omkopplingsbara uttag
-   [Victron](https://www.victronenergy.com/)Venus OS energilagringssystem som Multiplus II.

Koden är enkel så att den enkelt kan anpassas till andra energilagringssystem om du kan styra laddningen med linux-skalkommandon.
Ta en titt på de första raderna i filen controller.sh så att du kan se vad som kan konfigureras av användaren.

## Datakälla

Mjukvaran använder för närvarande EPEX Spot timpriser som tillhandahålls av tre gratis API:er (Tibber, aWATTar & Entso-E).
Den integrerade kostnadsfria Entso-E API tillhandahåller energiprisdata för följande länder:
Albanien (AL), Österrike (AT), Belgien (BE), Bosnien och Herz. (BA), Bulgarien (BG), Kroatien (HR), Cypern (CY), Tjeckien (CZ), Danmark (DK), Estland (EE), Finland (FI), Frankrike (FR), Georgien (GE), Tyskland (DE), Grekland (GR), Ungern (HU), Irland (IE), Italien (IT), Kosovo (XK), Lettland (LV), Litauen (LT), Luxemburg (LU), Malta (MT), Moldavien (MD), Montenegro (ME), Nederländerna (NL), Nordmakedonien (MK), Norge (NO), Polen (PL), Portugal (PT), Rumänien (RO), Serbien (RS), Slovakien (SK) , Slovenien (SI), Spanien (ES), Sverige (SE), Schweiz (CH), Turkiet (TR), Ukraina (UA), Storbritannien (UK) se[Transparens Entso-E-plattform](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![grafik](https://user-images.githubusercontent.com/6513794/224442951-c0155a48-f32b-43f4-8014-d86d60c3b311.png)

## Installation

Att installera Spotmarket-Switcher är en enkel process. Om du redan kör en UNIX-baserad maskin, som macOS, Linux eller Windows med Linux-undersystemet, följ dessa steg för att installera programvaran:

1.  Ladda ner installationsskriptet från GitHub-förvaret genom att använda[denna hyperlänk](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh), eller kör följande kommando i din terminal:
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  Kör installationsskriptet med ytterligare alternativ för att förbereda allt i en underkatalog för din inspektion. Till exempel:
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    Om du använder Victron Venus OS bör rätt DESTDIR vara`/`(rotkatalogen). Utforska gärna de installerade filerna i`/tmp/foo`.

Observera att även om denna programvara för närvarande är optimerad för Venus OS, kan den anpassas till andra linux-enheter som en Raspberry PI. Framtida utveckling kan förbättra kompatibiliteten med andra system.

### Tillgång till Venus OS

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

Dessutom, om du är i Tyskland och är intresserad av att byta till en dynamisk eltariff, kan du stödja projektet genom att registrera dig med denna[Tibber (remisslänk)](https://invite.tibber.com/ojgfbx2e). Både du och projektet kommer att få en bonus på 50 euro för hårdvara. Observera att en smart mätare eller en Pulse-IR krävs för en timtaxa (<https://tibber.com/de/store/produkt/pulse-ir>) .

Om du behöver en naturgastariff eller föredrar en klassisk eltaxa kan du fortfarande stödja projektet[Octopus Energy (referenslänk)](https://share.octopusenergy.de/glass-raven-58).
Du får en bonus på 50 euro för dig själv och även för projektet.
Octopus har fördelen att kontrakten oftast bara har en månatlig löptid. De är till exempel idealiska för att pausa en tariff baserad på börskurser.

## varning

Observera användarvillkoren på<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/dev/License.md>

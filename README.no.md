# Spotmarket-Switcher-Repository

## README Oversettelse

-   [Engelsk](README.md) - [tysk](README.de.md)-[fransk](README.fr.md)-[spansk](README.es.md)-[svensk](README.sv.md)-[Norsk](README.no.md)-[dansk](README.da.md)

Velkommen til Spotmarket-Switcher-depotet! Denne programvaren er utviklet for å forbedre funksjonaliteten til energioppsettet ditt ved å integrere:

-   [Victron](https://www.victronenergy.com/)Venus OS energilagringssystemer
-   Shelly-produkter (som Shelly Plug S eller Shelly Plus1PM)
-   AVM Fritz!DECT200 og 210 byttebare stikkontakter

Hovedmålet med denne programvaren er å gjøre systemet ditt i stand til å svare på strømpriser på spotmarkedet, slik at det kan ta intelligente beslutninger som batterilading og strømaktivering basert på lavprisperioder. Det forventede solutbyttet kan tas i betraktning via en vær-API og batterilagring reservert tilsvarende.

## Data Source

Programvaren bruker for tiden EPEX Spot-timepriser levert av tre gratis API-er (Tibber, aWATTar & Entso-E).
Den integrerte gratis Entso-E API gir energiprisdata for følgende land:
Albania (AL), Østerrike (AT), Belgia (BE), Bosnia og Herz. (BA), Bulgaria (BG), Kroatia (HR), Kypros (CY), Tsjekkia (CZ), Danmark (DK), Estland (EE), Finland (FI), Frankrike (FR), Georgia (GE), Tyskland (DE), Hellas (GR), Ungarn (HU), Irland (IE), Italia (IT), Kosovo (XK), Latvia (LV), Litauen (LT), Luxembourg (LU), Malta (MT), Moldova (MD), Montenegro (ME), Nederland (NL), Nord-Makedonia (MK), Norge (NO), Polen (PL), Portugal (PT), Romania (RO), Serbia (RS), Slovakia (SK) , Slovenia (SI), Spania (ES), Sverige (SE), Sveits (CH), Tyrkia (TR), Ukraina (UA), Storbritannia (Storbritannia) se[Transparency Entso-E-plattformen](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![grafik](https://user-images.githubusercontent.com/6513794/224442951-c0155a48-f32b-43f4-8014-d86d60c3b311.png)

## Installasjon

Å sette opp Spotmarket-Switcher er en enkel prosess. Hvis du allerede kjører en UNIX-basert maskin, for eksempel macOS, Linux eller Windows med Linux-delsystemet, følger du disse trinnene for å installere programvaren:

1.  Last ned installasjonsskriptet fra GitHub-depotet ved å bruke[denne hyperkoblingen](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh), eller kjør følgende kommando i terminalen din:
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  Kjør installasjonsskriptet med flere alternativer for å forberede alt i en underkatalog for inspeksjonen din. For eksempel:
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    Hvis du bruker Victron Venus OS, bør riktig DESTDIR være`/`(rotkatalogen). Utforsk gjerne de installerte filene i`/tmp/foo`.

Vær oppmerksom på at selv om denne programvaren for øyeblikket er optimalisert for Venus OS, kan den tilpasses andre oppsett, for eksempel å kontrollere husholdningsenheter via IP-svitsjer. Fremtidig utvikling kan forbedre kompatibiliteten med andre systemer.

### Tilgang til Venus OS

For instruksjoner om tilgang til Venus OS, se<https://www.victronenergy.com/live/ccgx:root_access>.

### Utførelse av installasjonsskriptet

-   Hvis du bruker Victron Venus OS:
    -   Henrette`victron-venus-os-install.sh`for å laste ned og installere Spotmarket-Switcher.
    -   Rediger variablene med et tekstredigeringsprogram i`/data/etc/Spotmarket-Switcher/controller.sh`.
    -   Sett opp en ESS-ladeplan (se skjermbildet som følger med). I eksemplet lades batteriet om natten opp til 50 % hvis det er aktivert. Husk å deaktivere den etter oppretting. Kontroller at systemtiden (som vist på skjermbildet) er nøyaktig.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

-   Hvis du bruker et annet OS:
    -   Kopier skallskriptet (`controller.sh`) til en egendefinert plassering og juster variablene i henhold til dine behov.
    -   Opprett en crontab eller en annen planleggingsmetode for å kjøre dette skriptet ved starten av hver time.
    -   Eksempel på Crontab:
          Bruk følgende crontab-oppføring for å utføre kontrollskriptet hver time:
          Åpne terminalen og skriv inn`crontab -e`, sett inn følgende linje:
            0 * * * * /path/to/controller.sh

### Støtte og bidrag

Hvis du finner dette prosjektet verdifullt, kan du vurdere å sponse og støtte videre utvikling gjennom disse lenkene:

-   [Revolut](https://revolut.me/christqki2)
-   [PayPal](https://paypal.me/christian1980nrw)

I tillegg, hvis du er i Tyskland og er interessert i å bytte til en dynamisk strømtariff, kan du støtte prosjektet ved å registrere deg ved å bruke denne[Tibber (referral link)](https://invite.tibber.com/ojgfbx2e). Både du og prosjektet vil motta en bonus på 50 euro for maskinvare. Vær oppmerksom på at en smartmåler eller en Pulse-IR kreves for timetakst (<https://tibber.com/de/store/produkt/pulse-ir>) .

Trenger du en naturgasstariff eller foretrekker en klassisk strømtariff, kan du fortsatt støtte prosjektet[Octopus Energy (henvisningslenke)](https://share.octopusenergy.de/glass-raven-58).
Du mottar en bonus på 50 euro for deg selv og også for prosjektet.
Octopus har den fordelen at kontraktene vanligvis kun har en månedlig løpetid. De er ideelle for for eksempel å sette en tariff basert på børskurser på pause.

## Ansvarsfraskrivelse

Vær oppmerksom på vilkårene for bruk på<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/dev/License.md>

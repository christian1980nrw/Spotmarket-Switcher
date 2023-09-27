<p align="center" width="100%">
    <img width="33%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/SpotmarketSwitcherLogo.png?raw=true"> 
</p>

[tsjekkisk](README.cs.md)-[dansk](README.da.md)-[tysk](README.de.md)-[Engelsk](README.md)-[spansk](README.es.md)-[estisk](README.et.md)-[finsk](README.fi.md)-[fransk](README.fr.md)-[gresk](README.el.md)-[italiensk](README.it.md)-[nederlandsk](README.nl.md)-[Norsk](README.no.md)-[Pusse](README.pl.md)-[portugisisk](README.pt.md)-[svensk](README.sv.md)-[japansk](README.ja.md)

## Velkommen til Spotmarket-Switcher-depotet!

Hva gjør denne programvaren?
Dette er et Linux-shell-skript og slår på batteriladeren og/eller koblingsbare stikkontakter til rett tid hvis timebaserte dynamiske energipriser er lave.
Du kan da bruke stikkontaktene til å skru på en varmtvannsbeholder mye billigere eller du kan automatisk lade batterilageret om natten når billig vindenergi er tilgjengelig på nettet.
Det forventede solutbyttet kan tas i betraktning via en vær-API og batterilagring reservert tilsvarende.
Støttede systemer er for øyeblikket:

-   Shelly-produkter (som f.eks[Shelly Plug S](https://shellyparts.de/products/shelly-plus-plug-s)eller[Shelly Plus](https://shellyparts.de/products/shelly-plus-1pm))
-   [AVMFritz!DECT200](https://avm.de/produkte/smart-home/fritzdect-200/)og[210](https://avm.de/produkte/smart-home/fritzdect-210/)byttebare stikkontakter
-   [Victron](https://www.victronenergy.com/)Venus OS energilagringssystemer som[MultiPlus-II-serien](https://www.victronenergy.com/inverters-chargers)

Koden er enkel slik at den enkelt kan tilpasses andre energilagringssystemer hvis du er i stand til å kontrollere lading med Linux-shell-kommandoer.
Ta en titt under linje 100 i controller.sh-filen slik at du kan se hva som kan konfigureres av brukeren.

## Datakilde

Programvaren bruker for tiden EPEX Spot-timepriser levert av tre gratis APIer (Tibber, aWATTar & Entso-E).
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

Vær oppmerksom på at selv om denne programvaren for øyeblikket er optimalisert for Venus OS, kan den tilpasses til andre Linux-smaker, som Debian/Ubuntu på en Raspberry Pi eller et annet lite brett. En førstegangskandidat er det absolutt[ÅpneWRT](https://www.openwrt.org). Å bruke en stasjonær maskin er greit for testformål, men når den er i 24/7 bruk, er det større strømforbruket en bekymring.

### Tilgang til Venus OS

For instruksjoner om tilgang til Venus OS, se<https://www.victronenergy.com/live/ccgx:root_access>.

### Utførelse av installasjonsskriptet

-   Hvis du bruker Victron Venus OS:
    -   Etter utførelse av`victron-venus-os-install.sh`, rediger variablene med et tekstredigeringsprogram i`/data/etc/Spotmarket-Switcher/controller.sh`.
    -   Sett opp en ESS-ladeplan (se skjermbildet som følger med). I eksemplet lades batteriet om natten opp til 50 % hvis det er aktivert, andre ladetider på dagen ignoreres. Hvis du ikke ønsker det, lag en tidsplan for alle døgnets 24 timer. Husk å deaktivere den etter oppretting. Kontroller at systemtiden (som vist øverst til høyre på skjermen) er nøyaktig.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

Skjermbildet viser konfigurasjonen av automatisk lading under brukerdefinerte tider. Deaktivert som standard, kan være midlertidig aktivert av skriptet.

-   Instruksjoner for å installere Spotmarket-Switcher på et Windows 10- eller 11-system for testing uten Victron-enheter (kun koblingsbare stikkontakter).

    -   lansering`cmd.exe`som administrator
    -   Tast inn`wsl --install -d Debian`
    -   Skriv inn et nytt brukernavn som`admin`
    -   Skriv inn et nytt passord
    -   Tast inn`sudo su`og skriv inn passordet ditt
    -   Tast inn`apt-get update && apt-get install wget curl`
    -   Fortsett med Linux-beskrivelsen nedenfor


-   Hvis du bruker et Linux-system som Ubuntu eller Debian:
    -   Kopier skallskriptet (`controller.sh`) til en egendefinert plassering og juster variablene i henhold til dine behov.
    -   kommandoene er`cd /path/to/save/ && wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/scripts/controller.sh && chmod +x ./controller.sh`og å redigere`vi /path/to/save/controller.sh`
    -   Opprett en crontab eller en annen planleggingsmetode for å kjøre dette skriptet ved starten av hver time.
    -   Eksempel på Crontab:
          Bruk følgende crontab-oppføring for å utføre kontrollskriptet hver time:
          Åpne terminalen og skriv inn`crontab -e`, sett inn følgende linje:`0 * * * * /path/to/controller.sh`

### Støtte og bidrag

Hvis du finner dette prosjektet verdifullt, kan du vurdere å sponse og støtte videre utvikling gjennom disse lenkene:

-   [Revolut](https://revolut.me/christqki2)
-   [PayPal](https://paypal.me/christian1980nrw)

I tillegg, hvis du er i Tyskland og er interessert i å bytte til en dynamisk strømtariff, kan du støtte prosjektet ved å registrere deg ved å bruke denne[Tibber (henvisningslenke)](https://invite.tibber.com/ojgfbx2e). Både du og prosjektet vil motta en bonus på 50 euro for maskinvare. Vær oppmerksom på at en smartmåler eller en Pulse-IR kreves for timetakst (<https://tibber.com/de/store/produkt/pulse-ir>) .

Trenger du en naturgasstariff eller foretrekker en klassisk strømtariff, kan du fortsatt støtte prosjektet[Octopus Energy (henvisningslenke)](https://share.octopusenergy.de/glass-raven-58).
Du mottar en bonus på 50 euro for deg selv og også for prosjektet.
Octopus har den fordelen at kontraktene vanligvis kun har en månedlig løpetid. De er ideelle for for eksempel å sette en tariff basert på børskurser på pause.

## Ansvarsfraskrivelse

Vær oppmerksom på vilkårene for bruk på<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/License.md>

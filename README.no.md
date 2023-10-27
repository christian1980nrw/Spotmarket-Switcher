<p align="center" width="100%">
    <img width="33%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/SpotmarketSwitcherLogo.png?raw=true"> 
</p>

[tsjekkisk](README.cs.md)-[dansk](README.da.md)-[tysk](README.de.md)-[Engelsk](README.md)-[spansk](README.es.md)-[estisk](README.et.md)-[finsk](README.fi.md)-[fransk](README.fr.md)-[gresk](README.el.md)-[italiensk](README.it.md)-[nederlandsk](README.nl.md)-[Norsk](README.no.md)-[Pusse](README.pl.md)-[portugisisk](README.pt.md)-[svensk](README.sv.md)-[japansk](README.ja.md)

## Velkommen til Spotmarket-Switcher-depotet!

What is this software doing? 
This is a Linux shell script and turning on your battery charger and / or switchable sockets at the right time if your hourly based dynamic energy prices are low.
You can then use the sockets to turn on a hot water tank much more cheaply or you can automatically charge the battery storage at night when cheap wind energy is available on the grid.
The expected solar yield can be taken into account via a weather API and battery storage reserved accordingly.
Supported systems are currently:

-   Shelly-produkter (som f.eks[Shelly Plug S](https://shellyparts.de/products/shelly-plus-plug-s)eller[Shelly Plus](https://shellyparts.de/products/shelly-plus-1pm))
-   [AVMFritz!DECT200](https://avm.de/produkte/smart-home/fritzdect-200/)og[210](https://avm.de/produkte/smart-home/fritzdect-210/)byttebare stikkontakter
-   [Victron](https://www.victronenergy.com/)Venus OS energilagringssystemer som[MultiPlus-II-serien](https://www.victronenergy.com/inverters-chargers)

Koden er enkel slik at den enkelt kan tilpasses andre energilagringssystemer hvis du er i stand til å kontrollere lading med Linux-shell-kommandoer.
Ta en titt under linje 100 i controller.sh-filen slik at du kan se hva som kan konfigureres av brukeren.

## Datakilde

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
    På en Cerbo GX er filsystemet montert skrivebeskyttet. Se<https://www.victronenergy.com/live/ccgx:root_access>. For å gjøre filsystemet skrivbart må du utføre følgende kommando før du kjører installasjonsskriptet:
        /opt/victronenergy/swupdate-scripts/resize2fs.sh

Vær oppmerksom på at selv om denne programvaren for øyeblikket er optimalisert for Venus OS, kan den tilpasses til andre Linux-smaker, som Debian/Ubuntu på en Raspberry Pi eller et annet lite brett. En førstegangskandidat er det absolutt[ÅpneWRT](https://www.openwrt.org). Å bruke en stasjonær maskin er greit for testformål, men når den er i 24/7 bruk, er det større strømforbruket en bekymring.

### Tilgang til Venus OS

For instruksjoner om tilgang til Venus OS, se<https://www.victronenergy.com/live/ccgx:root_access>.

### Utførelse av installasjonsskriptet

-   Hvis du bruker Victron Venus OS:
    -   Rediger deretter variablene med et tekstredigeringsprogram i`/data/etc/Spotmarket-Switcher/config.txt`.
    -   Sett opp en ESS-ladeplan (se skjermbildet som følger med). I eksemplet lades batteriet om natten opp til 50 % hvis det er aktivert, andre ladetider på dagen ignoreres. Hvis du ikke ønsker det, lag en tidsplan for alle døgnets 24 timer. Husk å deaktivere den etter oppretting. Kontroller at systemtiden (som vist øverst til høyre på skjermen) er nøyaktig.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

Skjermbildet viser konfigurasjonen av automatisk lading under brukerdefinerte tider. Deaktivert som standard, kan være midlertidig aktivert av skriptet.

-   Instruksjoner for å installere Spotmarket-Switcher på et Windows 10- eller 11-system for testing uten Victron-enheter (kun byttebare stikkontakter).

    -   lansering`cmd.exe`som administrator
    -   Tast inn`wsl --install -d Debian`
    -   Skriv inn et nytt brukernavn som`admin`
    -   Skriv inn et nytt passord
    -   Tast inn`sudo su`og skriv inn passordet ditt
    -   Tast inn`apt-get update && apt-get install wget curl`
    -   Fortsett med den manuelle Linux-beskrivelsen nedenfor (installasjonsskriptet er ikke kompatibelt).
    -   Ikke glem at hvis du lukker skallet, vil Windows stoppe systemet.


-   Hvis du bruker et Linux-system som Ubuntu eller Debian:
    -   Kopier skallskriptet (`controller.sh`) til en egendefinert plassering og juster variablene i henhold til dine behov.
    -   kommandoene er`cd /path/to/save/ &&  curl -s -O "https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/scripts/{controller.sh,sample.config.txt}" && mv sample.config.txt config.txt && chmod +x ./controller.sh`og å redigere`vi /path/to/save/config.txt`
    -   Opprett en crontab eller en annen planleggingsmetode for å kjøre dette skriptet ved starten av hver time.
    -   Eksempel på Crontab:
          Bruk følgende crontab-oppføring for å utføre kontrollskriptet hver time:
          Åpne terminalen og skriv inn`crontab -e`, sett inn følgende linje:`0 * * * * /path/to/controller.sh`

### Støtte og bidrag :+1:

Hvis du finner dette prosjektet verdifullt, kan du vurdere å sponse og støtte videre utvikling gjennom disse lenkene:

-   [Revolut](https://revolut.me/christqki2)
-   [PayPal](https://paypal.me/christian1980nrw)

Hvis du er fra Tyskland og interessert i å bytte til en dynamisk strømtariff, kan du støtte prosjektet ved å registrere deg ved å bruke denne[Tibber (henvisningslenke)](https://invite.tibber.com/ojgfbx2e)eller ved å taste inn koden`ojgfbx2e`i appen din. Både du og prosjektet vil motta**50 euro bonus for maskinvare**. Vær oppmerksom på at en smartmåler eller en Pulse-IR kreves for timetakst (<https://tibber.com/de/store/produkt/pulse-ir>).
Trenger du en naturgasstariff eller foretrekker en klassisk strømtariff, kan du fortsatt støtte prosjektet[Octopus Energy (henvisningslenke)](https://share.octopusenergy.de/glass-raven-58).
Du mottar en bonus (tilbudet varierer**mellom 50 og 120 euro**) for deg selv og også for prosjektet.
Octopus har den fordelen at noen tilbud er uten minimumskontraktstid. De er ideelle for for eksempel å sette en tariff basert på børskurser på pause.

Brukere fra Østerrike kan støtte oss ved å[aWATTar Østerrike (henvisningslenke)](https://www.awattar.at/services/offers/promotecustomers)henvisningshandling og gå inn`3KEHMQN2F`som kode.

## Ansvarsfraskrivelse

Vær oppmerksom på vilkårene for bruk på<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/License.md>

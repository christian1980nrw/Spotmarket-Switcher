<p align="center" width="100%">
    <img width="33%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/SpotmarketSwitcherLogo.png?raw=true"> 
</p>

[tsjekkisk](README.cs.md)-[dansk](README.da.md)-[tysk](README.de.md)-[engelsk](README.md)-[spansk](README.es.md)-[estisk](README.et.md)-[finsk](README.fi.md)-[fransk](README.fr.md)-[gresk](README.el.md)-[italiensk](README.it.md)-[nederlandsk](README.nl.md)-[Norsk](README.no.md)-[Pusse](README.pl.md)-[portugisisk](README.pt.md)-[svensk](README.sv.md)-[japansk](README.ja.md)

## Velkommen til Spotmarket-Switcher-depotet!

Hva gjør denne programvaren? 
Spotmarket-Switcher er et brukervennlig programvareverktøy som hjelper deg å spare penger på strømregningen. Hvis du har en smart batterilader eller enheter som varmtvannsberedere som kan slå seg på og av automatisk, er dette verktøyet perfekt for deg! Den slår på enhetene dine på en smart måte når energiprisene er lave, spesielt nyttig hvis energikostnadene dine endres hver time.

Dette typiske resultatet viser Spotmarket-Switchers evne til å automatisere energibruk effektivt, ikke bare spare kostnader, men også optimalisere bruken av fornybare energikilder. Det er et godt eksempel på hvordan smart teknologi kan brukes til å styre energiforbruket på en mer bærekraftig og kostnadseffektiv måte. (blå = bruk av batteri, rød = rutenett, gul = solenergi)

<p align="center" width="100%">
    <img width="50%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/Screenshot.jpg?raw=true"> 
</p>

-   Nattbruk: I løpet av natten, da energiprisene var på det laveste, aktiverte Spotmarket-Switcher smart en koblingsbar stikkontakt for å slå på varmtvannsvarmepumpen (spike indikert i rødt). Dette viser systemets evne til å identifisere og utnytte lavkostenergiperioder til energikrevende oppgaver.
-   Økonomisk effektivitet i batterilading: Programmet bestemte seg strategisk for å ikke lade batterilagringen i løpet av denne tiden. Denne beslutningen var basert på en økonomisk sjekk som tok hensyn til ladetap og sammenlignet dem med dagens gjennomsnittlige eller høyeste energipriser. Denne tilnærmingen sikrer at batterilading bare skjer når det er mest kostnadseffektivt.
-   Optimal bruk av batteri i rushtiden: På denne dagen var de dyreste energitimene morgen og kveld. I disse periodene brukte Spotmarket-Switcher den lagrede batterienergien (vist i blått), og unngikk dermed høye strømkostnader.
-   Batterireservasjon for høykostnadstimer: Etter høykostnadsperiodene ble batteriets energilagringssystem (ESS) slått av. Det var ikke tomt på kvelden rundt klokken 20.00. Denne handlingen ble tatt for å reservere tilstrekkelig batterikapasitet for de kommende dyre timene neste morgen. Dette forutser fremtidige høykostnadsperioder og sikrer at lagret energi er tilgjengelig for å minimere kostnadene.

Hvorfor bruke Spotmarket-Switcher?

-   Spar penger: Den slår på enhetene dine når energien er billigere, og reduserer regningene dine.
-   Spar penger: Bruk din lagrede solenergi til høyeste priser.
-   Energieffektiv: Ved å bruke energi når det er i overskudd (som vindfulle netter), bidrar du til en grønnere planet.
-   Smart bruk: Lad batterilagringen automatisk eller slå på enheter som varmtvannsberedere på de beste tidspunktene.

Støttede systemer er for øyeblikket:

-   Shelly products (such as [Shelly Plug S](https://shellyparts.de/products/shelly-plus-plug-s)eller[Shelly Plus](https://shellyparts.de/products/shelly-plus-1pm))
-   [AVMFritz!DECT200](https://avm.de/produkte/smart-home/fritzdect-200/)og[210](https://avm.de/produkte/smart-home/fritzdect-210/)byttebare stikkontakter
-   [Victron](https://www.victronenergy.com/)Venus OS energilagringssystemer som[MultiPlus-II-serien](https://www.victronenergy.com/inverters-chargers)(Dbus på localhost og MQTT by LAN støttes)
-   [sonnen](https://www.sonnen.de/)/[Sonnen batteri 10](https://sonnen.de/stromspeicher/sonnenbatterie-10/)Testet med programvareversjon 1.15.6 over LAN på et frittstående system uten SonnenCommunity eller sonnenVPP.
-   [annen MQTT-lader](http://www.steves-internet-guide.com/mosquitto_pub-sub-clients/)(ladere som kan kontrolleres av mygg MQTT-kommandoer)

Komme i gang:

-   Last ned og installer: Konfigurasjonsprosessen er enkel. Last ned skriptet, juster noen innstillinger, og du er klar til å gå.
-   Planlegg og slapp av: Sett den opp én gang, og den kjører automatisk. Ingen daglig stress!

Interessert?

-   Sjekk ut våre detaljerte instruksjoner for forskjellige systemer som Victron Venus OS, Windows eller Linux-oppsett. Vi har sørget for at trinnene er enkle å følge.
-   Bli med oss ​​for å gjøre energibruken smartere og mer kostnadseffektiv! For spørsmål, forslag eller tilbakemeldinger, ta gjerne kontakt.

Koden er enkel slik at den enkelt kan tilpasses andre energilagringssystemer hvis du er i stand til å kontrollere lading med Linux-shell-kommandoer.
Ta en titt på controller.sh og søk etter charger_command_turnon slik at du kan se hvor enkelt den kan tilpasses.
Opprett en github-gaffel og del tilpasningen din slik at andre brukere kan dra nytte av den.

## Datakilde

Programvaren bruker for tiden EPEX Spot-timepriser levert av tre gratis API-er (Tibber, aWATTar & Entso-E).
Den integrerte gratis Entso-E API gir energiprisdata for følgende land:
Albania (AL), Østerrike (AT), Belgia (BE), Bosnia og Herz. (BA), Bulgaria (BG), Kroatia (HR), Kypros (CY), Tsjekkia (CZ), Danmark (DK), Estland (EE), Finland (FI), Frankrike (FR), Georgia (GE), Tyskland (DE), Hellas (GR), Ungarn (HU), Irland (IE), Italia (IT), Kosovo (XK), Latvia (LV), Litauen (LT), Luxembourg (LU), Malta (MT), Moldova (MD), Montenegro (ME), Nederland (NL), Nord-Makedonia (MK), Norge (NO), Polen (PL), Portugal (PT), Romania (RO), Serbia (RS), Slovakia (SK), Slovenia (SI), Spania (ES) , Sverige (SE), Sveits (CH), Tyrkia (TR), Ukraina (UA), Storbritannia (Storbritannia) se[Transparency Entso-E-plattformen](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![Screenshot 2023-12-15 221401](https://github.com/christian1980nrw/Spotmarket-Switcher/assets/6513794/25992602-b0a2-48ff-bd4c-64a6f8182297)En mer detaljert logg kan sees med følgende kommando ved skallet ditt:

     cd /data/etc/Spotmarket-Switcher
     DEBUG=1 bash ./controller.sh

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

-   Instruksjoner for å installere Spotmarket-Switcher på et Windows 10- eller 11-system for testing uten Victron-enheter (kun koblingsbare stikkontakter).

    -   lansering`cmd.exe`som administrator
    -   Gå`wsl --install -d Debian`
    -   Skriv inn et nytt brukernavn som`admin`
    -   Skriv inn et nytt passord
    -   Gå`sudo su`og skriv inn passordet ditt
    -   Gå`apt-get update && apt-get install wget curl`
    -   Fortsett med den manuelle Linux-beskrivelsen nedenfor (installasjonsskriptet er ikke kompatibelt).
    -   Ikke glem at hvis du lukker skallet, vil Windows stoppe systemet.


-   Hvis du bruker et Linux-system som Ubuntu eller Debian:
    -   Kopier skallskriptet (`controller.sh`) til en egendefinert plassering og juster variablene i henhold til dine behov.
    -   kommandoene er`cd /path/to/save/ && curl -s -O "https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/scripts/{controller.sh,sample.config.txt,license.txt}" && chmod +x ./controller.sh && mv sample.config.txt config.txt`og for å redigere innstillingene dine`vi /path/to/save/config.txt`
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

Hvis du er fra Østerrike kan du støtte oss ved å bruke[aWATTar Østerrike (henvisningslenke)](https://www.awattar.at/services/offers/promotecustomers). Vennligst bruk`3KEHMQN2F`som kode.

## Ansvarsfraskrivelse

Vær oppmerksom på vilkårene for bruk på<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/License.md>

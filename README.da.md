<p align="center" width="100%">
    <img width="33%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/SpotmarketSwitcherLogo.png?raw=true"> 
</p>

[tjekkisk](README.cs.md)-[Dansk](README.da.md)-[tysk](README.de.md)-[engelsk](README.md)-[spansk](README.es.md)-[estisk](README.et.md)-[finsk](README.fi.md)-[fransk](README.fr.md)-[græsk](README.el.md)-[italiensk](README.it.md)-[hollandsk](README.nl.md)-[norsk](README.no.md)-[Polere](README.pl.md)-[portugisisk](README.pt.md)-[svensk](README.sv.md)-[japansk](README.ja.md)

## Velkommen til Spotmarket-Switcher-depotet!

Hvad laver denne software? 
Spotmarket-Switcher er et letanvendeligt softwareværktøj, der hjælper dig med at spare penge på dine energiregninger. Hvis du har en smart batterioplader eller enheder som vandvarmere, der kan tænde og slukke automatisk, er dette værktøj perfekt til dig! Den tænder smart for dine enheder, når energipriserne er lave, især nyttigt, hvis dine energiomkostninger ændrer sig hver time.

Dette typiske resultat viser Spotmarket-Switchers evne til at automatisere energiforbruget effektivt, ikke kun spare omkostninger, men også optimere brugen af ​​vedvarende energikilder. Det er et godt eksempel på, hvordan smart teknologi kan bruges til at styre energiforbruget på en mere bæredygtig og omkostningseffektiv måde. (blå = brug af batteri, rød = gitter, gul = solenergi)

<p align="center" width="100%">
    <img width="50%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/Screenshot.jpg?raw=true"> 
</p>

-   Natbrug: I løbet af natten, hvor energipriserne var på det laveste, aktiverede Spotmarket-Switcher smart en omskiftelig stikkontakt til at tænde for varmtvandsvarmepumpen (spids angivet med rødt). Dette viser systemets evne til at identificere og udnytte billige energiperioder til energikrævende opgaver.
-   Økonomisk effektivitet i batteriopladning: Programmet besluttede strategisk ikke at oplade batterilageret i denne periode. Denne beslutning var baseret på en økonomisk kontrol, der tog hensyn til opladningstab og sammenlignede dem med dagens gennemsnitlige eller højeste energipriser. Denne tilgang sikrer, at batteriopladning kun sker, når det er mest omkostningseffektivt.
-   Optimal brug af batteriet i myldretiden: På denne dag var de dyreste energitimer morgen og aften. I disse perioder brugte Spotmarket-Switcheren den lagrede batteri-energi (vist med blåt), og dermed undgik høje el-omkostninger.
-   Batterireservation til højomkostningstimer: Efter højomkostningsperioderne blev batteriets energilagersystem (ESS) slukket. Der var ikke tomt om aftenen omkring klokken 20.00. Denne handling blev truffet for at reservere tilstrækkelig batterikapacitet til de kommende dyre timer næste morgen. Dette forudser fremtidige højomkostningsperioder og sikrer, at lagret energi er tilgængelig for at minimere omkostningerne.

Hvorfor bruge Spotmarket-Switcher?

-   Spar penge: Den tænder for dine enheder, når energien er billigere, hvilket reducerer dine regninger.
-   Spar penge: Brug din lagrede solenergi til højeste priser.
-   Energieffektiv: Ved at bruge energi, når den er i overskud (som blæsende nætter), bidrager du til en grønnere planet.
-   Smart brug: Oplad automatisk dit batterilager eller tænd for enheder som vandvarmere på de bedste tidspunkter.

Understøttede systemer er i øjeblikket:

-   Shelly-produkter (f.eks[Shelly Plug S](https://shellyparts.de/products/shelly-plus-plug-s)eller[Shelly Plus](https://shellyparts.de/products/shelly-plus-1pm))
-   [AVMFritz!DECT200](https://avm.de/produkte/smart-home/fritzdect-200/)og[210](https://avm.de/produkte/smart-home/fritzdect-210/)omskiftelige stikkontakter
-   [Victron](https://www.victronenergy.com/)Venus OS energilagringssystemer som[MultiPlus-II-serien](https://www.victronenergy.com/inverters-chargers)(Dbus på localhost og MQTT by LAN er understøttet)
-   [sonnen](https://www.sonnen.de/)/[Sonnen batteri 10](https://sonnen.de/stromspeicher/sonnenbatterie-10/) Tested with software version 1.15.6 over LAN at a standalone system without SonnenCommunity or sonnenVPP.
-   [anden MQTT oplader](http://www.steves-internet-guide.com/mosquitto_pub-sub-clients/)(opladere, der kan styres af myg MQTT-kommandoer)

Kom godt i gang:

-   Download og installer: Opsætningsprocessen er ligetil. Download scriptet, juster nogle få indstillinger, og du er klar til at gå.
-   Planlæg og slap af: Indstil det én gang, og det kører automatisk. Ingen daglig besvær!

Interesseret?

-   Tjek vores detaljerede instruktioner til forskellige systemer som Victron Venus OS, Windows eller Linux opsætninger. Vi har sørget for, at trinene er nemme at følge.
-   Vær med til at gøre energiforbruget smartere og mere omkostningseffektivt! For spørgsmål, forslag eller feedback er du velkommen til at kontakte os.

Koden er enkel, så den nemt kan tilpasses til andre energilagringssystemer, hvis du er i stand til at styre opladningen med Linux-shell-kommandoer.
Tag et kig på controlleren.sh og søg efter charger_command_turnon, så du kan se, hvor nemt det kan tilpasses.
Opret en github-gaffel og del din tilpasning, så andre brugere kan drage fordel af den.

## Datakilde

Softwaren bruger i øjeblikket EPEX Spot-timepriser leveret af tre gratis API'er (Tibber, aWATTar & Entso-E).
Den integrerede gratis Entso-E API leverer energiprisdata for følgende lande:
Albanien (AL), Østrig (AT), Belgien (BE), Bosnien og Herz. (BA), Bulgarien (BG), Kroatien (HR), Cypern (CY), Tjekkiet (CZ), Danmark (DK), Estland (EE), Finland (FI), Frankrig (FR), Georgien (GE), Tyskland (DE), Grækenland (GR), Ungarn (HU), Irland (IE), Italien (IT), Kosovo (XK), Letland (LV), Litauen (LT), Luxembourg (LU), Malta (MT), Moldova (MD), Montenegro (ME), Holland (NL), Nordmakedonien (MK), Norge (NO), Polen (PL), Portugal (PT), Rumænien (RO), Serbien (RS), Slovakiet (SK), Slovenien (SI), Spanien (ES) , Sverige (SE), Schweiz (CH), Tyrkiet (TR), Ukraine (UA), Storbritannien (UK) se[Transparency Entso-E Platform](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![Screenshot 2023-12-15 221401](https://github.com/christian1980nrw/Spotmarket-Switcher/assets/6513794/25992602-b0a2-48ff-bd4c-64a6f8182297)En mere detaljeret log kan ses med følgende kommando på din shell:

     cd /data/etc/Spotmarket-Switcher
     DEBUG=1 bash ./controller.sh

## Installation

Opsætning af Spotmarket-Switcher er en ligetil proces. Hvis du allerede kører en UNIX-baseret maskine, såsom macOS, Linux eller Windows med Linux-undersystemet, skal du følge disse trin for at installere softwaren:

1.  Download installationsscriptet fra GitHub-lageret ved at bruge[dette hyperlink](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh), eller udfør følgende kommando i din terminal:
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  Kør installationsscriptet med yderligere muligheder for at forberede alt i en undermappe til din inspektion. For eksempel:
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    Hvis du bruger Victron Venus OS, skal den korrekte DESTDIR være`/`(rodmappen). Du er velkommen til at udforske de installerede filer i`/tmp/foo`.
    På en Cerbo GX er filsystemet monteret skrivebeskyttet. Se<https://www.victronenergy.com/live/ccgx:root_access>. For at gøre filsystemet skrivbart skal du udføre følgende kommando, før du kører installationsscriptet:
        /opt/victronenergy/swupdate-scripts/resize2fs.sh

Bemærk venligst, at selvom denne software i øjeblikket er optimeret til Venus OS, kan den tilpasses til andre Linux-varianter, som Debian/Ubuntu på en Raspberry Pi eller et andet lille bord. En topkandidat er bestemt[OpenWRT](https://www.openwrt.org). Brug af en stationær maskine er fint til testformål, men når den er i 24/7 brug, er dens større strømforbrug et problem.

### Access to Venus OS

For instruktioner om adgang til Venus OS, se venligst<https://www.victronenergy.com/live/ccgx:root_access>.

### Udførelse af installationsscriptet

-   Hvis du bruger Victron Venus OS:
    -   Rediger derefter variablerne med en teksteditor i`/data/etc/Spotmarket-Switcher/config.txt`.
    -   Opsæt en ESS-opladningsplan (se det medfølgende skærmbillede). I eksemplet oplades batteriet op til 50 % om natten, hvis det er aktiveret, andre opladningstider på dagen ignoreres. Hvis det ikke ønskes, skal du oprette en tidsplan for alle døgnets 24 timer. Husk at deaktivere den efter oprettelse. Kontroller, at systemtiden (som vist øverst til højre på skærmen) er nøjagtig.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

Skærmbilledet viser konfigurationen af ​​automatisk opladning på brugerdefinerede tidspunkter. Deaktiveret som standard, kan være midlertidigt aktiveret af scriptet.

-   Instruktioner til installation af Spotmarket-Switcher på et Windows 10- eller 11-system til test uden Victron-enheder (kun omskiftelige stik).

    -   lancering`cmd.exe` as Administrator
    -   Indtast`wsl --install -d Debian`
    -   Indtast et nyt brugernavn som`admin`
    -   Indtast en ny adgangskode
    -   Indtast`sudo su`og skriv din adgangskode
    -   Indtast`apt-get update && apt-get install wget curl`
    -   Fortsæt med den manuelle Linux-beskrivelse nedenfor (installationsscriptet er ikke kompatibelt).
    -   Glem ikke, hvis du lukker skallen, vil Windows stoppe systemet.


-   Hvis du bruger et Linux-system som Ubuntu eller Debian:
    -   Kopiér shell-scriptet (`controller.sh`) til en brugerdefineret placering og juster variablerne efter dine behov.
    -   kommandoerne er`cd /path/to/save/ && curl -s -O "https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/scripts/{controller.sh,sample.config.txt,license.txt}" && chmod +x ./controller.sh && mv sample.config.txt config.txt`og for at redigere dine indstillinger brug`vi /path/to/save/config.txt`
    -   Opret en crontab eller en anden planlægningsmetode for at køre dette script i starten af ​​hver time.
    -   Eksempel på Crontab:
          Brug følgende crontab-indgang til at udføre kontrolscriptet hver time:
          Åbn din terminal og indtast`crontab -e`, indsæt derefter følgende linje:`0 * * * * /path/to/controller.sh`

### Support og bidrag:+1:

Hvis du finder dette projekt værdifuldt, kan du overveje at sponsorere og støtte yderligere udvikling gennem disse links:

-   [Revolut](https://revolut.me/christqki2)
-   [PayPal](https://paypal.me/christian1980nrw)

Hvis du er fra Tyskland og interesseret i at skifte til en dynamisk eltakst, kan du støtte projektet ved at tilmelde dig ved hjælp af denne[Tibber (henvisningslink)](https://invite.tibber.com/ojgfbx2e)eller ved at indtaste koden`ojgfbx2e`i din app. Både du og projektet får**50 euro bonus for hardware**. Bemærk venligst, at der kræves en smartmåler eller en Pulse-IR for en timetakst (<https://tibber.com/de/store/produkt/pulse-ir>).
Har du brug for en naturgastakst eller foretrækker du en klassisk el-takst, kan du stadig støtte projektet[Octopus Energy (henvisningslink)](https://share.octopusenergy.de/glass-raven-58).
Du modtager en bonus (tilbuddet varierer**mellem 50 og 120 euro**) for dig selv og også for projektet.
Octopus har den fordel, at nogle tilbud er uden minimumskontraktperiode. De er for eksempel ideelle til at sætte en tarif på pause baseret på børskurser.

Hvis du er fra Østrig kan du støtte os ved at bruge[aWATTar Østrig (henvisningslink)](https://www.awattar.at/services/offers/promotecustomers). Benyt venligst`3KEHMQN2F`som kode.

## Ansvarsfraskrivelse

Bemærk venligst vilkårene for brug på<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/License.md>

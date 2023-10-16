<p align="center" width="100%">
    <img width="33%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/SpotmarketSwitcherLogo.png?raw=true"> 
</p>

[tjekkisk](README.cs.md)-[Dansk](README.da.md)-[tysk](README.de.md)-[engelsk](README.md)-[spansk](README.es.md)-[estisk](README.et.md)-[finsk](README.fi.md)-[fransk](README.fr.md)-[græsk](README.el.md)-[italiensk](README.it.md)-[hollandsk](README.nl.md)-[Norsk](README.no.md)-[Polere](README.pl.md)-[portugisisk](README.pt.md)-[svensk](README.sv.md)-[japansk](README.ja.md)

## Velkommen til Spotmarket-Switcher-depotet!

Hvad laver denne software?
Dette er et Linux-shell-script og tænder for din batterioplader og/eller omskiftelige stik på det rigtige tidspunkt, hvis dine timebaserede dynamiske energipriser er lave.
Du kan så bruge stikkontakterne til at tænde en varmtvandsbeholder meget billigere eller du kan automatisk oplade batterilageret om natten, når der er billig vindenergi til rådighed på nettet.
Det forventede soludbytte kan tages i betragtning via en vejr-API og batterilager reserveret i overensstemmelse hermed.
Understøttede systemer er i øjeblikket:

-   Shelly-produkter (f.eks[Shelly Plug S](https://shellyparts.de/products/shelly-plus-plug-s)eller[Shelly Plus](https://shellyparts.de/products/shelly-plus-1pm))
-   [AVMFritz!DECT200](https://avm.de/produkte/smart-home/fritzdect-200/)og[210](https://avm.de/produkte/smart-home/fritzdect-210/)omskiftelige stikkontakter
-   [Victron](https://www.victronenergy.com/)Venus OS energilagringssystemer som[MultiPlus-II-serien](https://www.victronenergy.com/inverters-chargers)

Koden er enkel, så den nemt kan tilpasses til andre energilagringssystemer, hvis du er i stand til at styre opladningen med Linux-shell-kommandoer.
Tag et kig under linje 100 i controller.sh-filen, så du kan se, hvad der kan konfigureres af brugeren.

## Datakilde

Softwaren bruger i øjeblikket EPEX Spot-timepriser leveret af tre gratis API'er (Tibber, aWATTar & Entso-E).
Den integrerede gratis Entso-E API leverer energiprisdata for følgende lande:
Albanien (AL), Østrig (AT), Belgien (BE), Bosnien og Herz. (BA), Bulgarien (BG), Kroatien (HR), Cypern (CY), Tjekkiet (CZ), Danmark (DK), Estland (EE), Finland (FI), Frankrig (FR), Georgien (GE), Tyskland (DE), Grækenland (GR), Ungarn (HU), Irland (IE), Italien (IT), Kosovo (XK), Letland (LV), Litauen (LT), Luxembourg (LU), Malta (MT), Moldova (MD), Montenegro (ME), Holland (NL), Nordmakedonien (MK), Norge (NO), Polen (PL), Portugal (PT), Rumænien (RO), Serbien (RS), Slovakiet (SK) , Slovenien (SI), Spanien (ES), Sverige (SE), Schweiz (CH), Tyrkiet (TR), Ukraine (UA), Storbritannien (UK) se[Transparency Entso-E Platform](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![grafik](https://user-images.githubusercontent.com/6513794/224442951-c0155a48-f32b-43f4-8014-d86d60c3b311.png)

## Installation

Opsætning af Spotmarket-Switcher er en ligetil proces. Hvis du allerede kører en UNIX-baseret maskine, såsom macOS, Linux eller Windows med Linux-undersystemet, skal du følge disse trin for at installere softwaren:

1.  Download installationsscriptet fra GitHub-lageret ved at bruge[dette hyperlink](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh), eller udfør følgende kommando i din terminal:
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  Kør installationsscriptet med yderligere muligheder for at forberede alt i en undermappe til din inspektion. For eksempel:
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    Hvis du bruger Victron Venus OS, skal den korrekte DESTDIR være`/`(rodmappen). Du er velkommen til at udforske de installerede filer i`/tmp/foo`.

Bemærk venligst, at selvom denne software i øjeblikket er optimeret til Venus OS, kan den tilpasses til andre Linux-varianter, som Debian/Ubuntu på en Raspberry Pi eller et andet lille bord. En topkandidat er bestemt[OpenWRT](https://www.openwrt.org). Brug af en stationær maskine er fint til testformål, men når den er i 24/7 brug, er dens større strømforbrug et problem.

### Adgang til Venus OS

For instruktioner om adgang til Venus OS, se venligst<https://www.victronenergy.com/live/ccgx:root_access>.

### Udførelse af installationsscriptet

-   Hvis du bruger Victron Venus OS:
    -   Efter udførelse af`victron-venus-os-install.sh`, rediger variablerne med en teksteditor i`/data/etc/Spotmarket-Switcher/controller.sh`.
    -   Opsæt en ESS-opladningsplan (se det medfølgende skærmbillede). I eksemplet oplades batteriet op til 50 % om natten, hvis det er aktiveret, andre opladningstider på dagen ignoreres. Hvis det ikke ønskes, skal du oprette en tidsplan for alle døgnets 24 timer. Husk at deaktivere den efter oprettelse. Kontroller, at systemtiden (som vist øverst til højre på skærmen) er nøjagtig.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

Skærmbilledet viser konfigurationen af ​​automatisk opladning på brugerdefinerede tidspunkter. Deaktiveret som standard, kan være midlertidigt aktiveret af scriptet.

-   Instruktioner til installation af Spotmarket-Switcher på et Windows 10- eller 11-system til test uden Victron-enheder (kun omskiftelige stik).

    -   lancering`cmd.exe`som administrator
    -   Gå ind`wsl --install -d Debian`
    -   Indtast et nyt brugernavn som`admin`
    -   Indtast et nyt kodeord
    -   Gå ind`sudo su`og skriv din adgangskode
    -   Gå ind`apt-get update && apt-get install wget curl`
    -   Fortsæt med den manuelle Linux-beskrivelse nedenfor (installationsscriptet er ikke kompatibelt).
    -   Glem ikke, hvis du lukker skallen, vil Windows stoppe systemet.


-   Hvis du bruger et Linux-system som Ubuntu eller Debian:
    -   Kopiér shell-scriptet (`controller.sh`) til en brugerdefineret placering og juster variablerne efter dine behov.
    -   kommandoerne er`cd /path/to/save/ && wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/scripts/controller.sh && chmod +x ./controller.sh`og at redigere`vi /path/to/save/controller.sh`
    -   Opret en crontab eller en anden planlægningsmetode for at køre dette script i starten af ​​hver time.
    -   Eksempel på Crontab:
          Brug følgende crontab-indgang til at udføre kontrolscriptet hver time:
          Åbn din terminal og indtast`crontab -e`, indsæt derefter følgende linje:`0 * * * * /path/to/controller.sh`

### Støtte og bidrag

Hvis du finder dette projekt værdifuldt, kan du overveje at sponsorere og støtte yderligere udvikling gennem disse links:

-   [Revolut](https://revolut.me/christqki2)
-   [PayPal](https://paypal.me/christian1980nrw)

Derudover, hvis du er i Tyskland og er interesseret i at skifte til en dynamisk eltakst, kan du støtte projektet ved at tilmelde dig ved hjælp af denne[Tibber (henvisningslink)](https://invite.tibber.com/ojgfbx2e). Både du og projektet vil modtage en bonus på 50 euro for hardware. Bemærk venligst, at der kræves en smartmåler eller en Pulse-IR for en timetakst (<https://tibber.com/de/store/produkt/pulse-ir>) .

Har du brug for en naturgastakst eller foretrækker du en klassisk el-takst, kan du stadig støtte projektet[Octopus Energy (henvisningslink)](https://share.octopusenergy.de/glass-raven-58).
Du modtager en bonus (tilbuddet varierer mellem 50 og 120 euro) til dig selv og også for projektet.
Octopus har den fordel, at kontrakterne normalt kun har en månedlig løbetid. De er for eksempel ideelle til at sætte en tarif på pause baseret på børskurser.

## Ansvarsfraskrivelse

Bemærk venligst vilkårene for brug på<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/License.md>

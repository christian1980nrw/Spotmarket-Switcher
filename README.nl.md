<p align="center" width="100%">
    <img width="33%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/SpotmarketSwitcherLogo.png?raw=true"> 
</p>

[Deens](README.da.md)-[Duits](README.de.md)-[Engels](README.md)-[Spaans](README.es.md)-[Ests](README.et.md)-[Fins](README.fi.md)-[Frans](README.fr.md)-[Grieks](README.el.md)-[Italiaans](README.it.md)-[Nederlands](README.nl.md)-[Noors](README.no.md)-[Portugees](README.pt.md)-[Zweeds](README.sv.md)-[Japans](README.ja.md)

## Welkom bij de Spotmarket-Switcher-repository!

Wat doet deze software?
Dit is een Linux-shellscript dat uw acculader en/of schakelbare stopcontacten op het juiste moment inschakelt als uw uurgebaseerde dynamische energieprijzen laag zijn.
Je kunt de stopcontacten dan gebruiken om veel goedkoper een warmwatertank aan te zetten of je kunt de batterijopslag 's nachts automatisch opladen als er goedkope windenergie op het elektriciteitsnet beschikbaar is.
Via een weer-API kan rekening worden gehouden met de verwachte zonne-opbrengst en kan de batterijopslag dienovereenkomstig worden gereserveerd.
Ondersteunde systemen zijn momenteel:

-   Shelly-producten (zoals[Shelly Plug S](https://shellyparts.de/products/shelly-plus-plug-s)of[Shelly Plus](https://shellyparts.de/products/shelly-plus-1pm))
-   [AVMFritz!DECT200](https://avm.de/produkte/smart-home/fritzdect-200/)En[210](https://avm.de/produkte/smart-home/fritzdect-210/)schakelbare stopcontacten
-   [Victron](https://www.victronenergy.com/)Venus OS energieopslagsystemen zoals de[MultiPlus-II-serie](https://www.victronenergy.com/inverters-chargers)

De code is eenvoudig, zodat deze gemakkelijk kan worden aangepast aan andere energieopslagsystemen als je het opladen kunt regelen met Linux-shell-opdrachten.
Kijk eens onder regel 100 van het controller.sh-bestand, zodat u kunt zien wat door de gebruiker kan worden geconfigureerd.

## Databron

De software maakt momenteel gebruik van EPEX Spot-uurprijzen die worden aangeboden door drie gratis API's (Tibber, aWATTar en Entso-E).
De geïntegreerde gratis Entso-E API levert energieprijsgegevens van de volgende landen:
Albanië (AL), Oostenrijk (AT), België (BE), Bosnië en Herz. (BA), Bulgarije (BG), Kroatië (HR), Cyprus (CY), Tsjechië (CZ), Denemarken (DK), Estland (EE), Finland (FI), Frankrijk (FR), Georgië (GE), Duitsland (DE), Griekenland (GR), Hongarije (HU), Ierland (IE), Italië (IT), Kosovo (XK), Letland (LV), Litouwen (LT), Luxemburg (LU), Malta (MT), Moldavië (MD), Montenegro (ME), Nederland (NL), Noord-Macedonië (MK), Noorwegen (NO), Polen (PL), Portugal (PT), Roemenië (RO), Servië (RS), Slowakije (SK) , Slovenië (SI), Spanje (ES), Zweden (SE), Zwitserland (CH), Turkije (TR), Oekraïne (UA), Verenigd Koninkrijk (UK) zie[Transparantie Entso-E-platform](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![grafik](https://user-images.githubusercontent.com/6513794/224442951-c0155a48-f32b-43f4-8014-d86d60c3b311.png)

## Installatie

Het opzetten van de Spotmarket-Switcher is een eenvoudig proces. Als u al een op UNIX gebaseerde machine gebruikt, zoals macOS, Linux of Windows met het Linux-subsysteem, volgt u deze stappen om de software te installeren:

1.  Download het installatiescript uit de GitHub-opslagplaats met behulp van[deze hyperlink](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh), of voer de volgende opdracht uit in uw terminal:
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  Voer het installatiescript uit met extra opties om alles in een submap voor te bereiden voor uw inspectie. Bijvoorbeeld:
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    Als u Victron Venus OS gebruikt, zou de juiste DESTDIR moeten zijn`/`(de hoofdmap). Voel je vrij om de geïnstalleerde bestanden te verkennen in`/tmp/foo`.

Houd er rekening mee dat hoewel deze software momenteel is geoptimaliseerd voor het Venus OS, deze kan worden aangepast aan andere Linux-smaken, zoals Debian/Ubuntu op een Raspberry Pi of een ander klein bord. Een topkandidaat is dat zeker[OpenWRT](https://www.openwrt.org). Het gebruik van een desktopmachine is prima voor testdoeleinden, maar bij 24/7 gebruik is het grotere energieverbruik een probleem.

### Toegang tot Venus OS

Voor instructies over toegang tot het Venus OS raadpleegt u<https://www.victronenergy.com/live/ccgx:root_access>.

### Uitvoering van het installatiescript

-   Als u Victron Venus OS gebruikt:
    -   Na uitvoering van de`victron-venus-os-install.sh`, bewerk de variabelen met een teksteditor in`/data/etc/Spotmarket-Switcher/controller.sh`.
    -   Stel een ESS-laadschema in (zie de meegeleverde schermafbeelding). In het voorbeeld laadt de batterij 's nachts tot 50% op, indien geactiveerd, andere oplaadtijden van de dag worden genegeerd. Indien niet gewenst, maak dan een schema voor alle 24 uur van de dag. Vergeet niet om het na het maken te deactiveren. Controleer of de systeemtijd (zoals weergegeven in de rechterbovenhoek van het scherm) juist is.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

De schermafbeelding toont de configuratie van automatisch opladen tijdens door de gebruiker gedefinieerde tijden. Standaard gedeactiveerd, kan tijdelijk worden geactiveerd door het script.

-   Als u een ander besturingssysteem gebruikt:
    -   Kopieer het shellscript (`controller.sh`) naar een aangepaste locatie en pas de variabelen aan uw behoeften aan.
    -   Maak een crontab of een andere planningsmethode om dit script aan het begin van elk uur uit te voeren.
    -   Voorbeeldcrontab:
          Gebruik de volgende crontab-invoer om het controlescript elk uur uit te voeren:
          Open uw terminal en ga naar binnen`crontab -e`en voeg vervolgens de volgende regel in:
            0 * * * * /path/to/controller.sh

### Ondersteuning en bijdrage

Als u dit project waardevol vindt, overweeg dan om verdere ontwikkeling te sponsoren en te ondersteunen via deze links:

-   [Revolutie](https://revolut.me/christqki2)
-   [PayPal](https://paypal.me/christian1980nrw)

Als u zich bovendien in Duitsland bevindt en geïnteresseerd bent in de overstap naar een dynamisch elektriciteitstarief, kunt u het project steunen door u hier aan te melden[Tibber (verwijzingslink)](https://invite.tibber.com/ojgfbx2e). Zowel jij als het project ontvangen een bonus van 50 euro voor hardware. Houd er rekening mee dat voor een uurtarief een slimme meter of een Pulse-IR nodig is (<https://tibber.com/de/store/produkt/pulse-ir>) .

Indien u een aardgastarief nodig heeft of de voorkeur geeft aan een klassiek elektriciteitstarief, kunt u het project nog steeds steunen[Octopus Energy (verwijzingslink)](https://share.octopusenergy.de/glass-raven-58).
Je ontvangt een bonus van 50 euro voor jezelf en ook voor het project.
Octopus heeft als voordeel dat de contracten doorgaans slechts een maandelijkse looptijd hebben. Ze zijn bijvoorbeeld ideaal om een ​​tarief op basis van beurskoersen te pauzeren.

## Vrijwaring

Let op de gebruiksvoorwaarden op<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/License.md>

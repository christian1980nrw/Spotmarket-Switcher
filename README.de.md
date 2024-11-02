<p align="center" width="100%">
    <img width="33%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/SpotmarketSwitcherLogo.png?raw=true"> 
</p>

[tschechisch](README.cs.md)-[dänisch](README.da.md)-[Deutsch](README.de.md)-[Englisch](README.md)-[Spanisch](README.es.md)-[estnisch](README.et.md)-[finnisch](README.fi.md)-[Französisch](README.fr.md)-[griechisch](README.el.md)-[Italienisch](README.it.md)-[Niederländisch](README.nl.md)-[norwegisch](README.no.md)-[Polieren](README.pl.md)-[Portugiesisch](README.pt.md)-[Schwedisch](README.sv.md)-[japanisch](README.ja.md)

## Willkommen im Spotmarket-Switcher-Repository!

Was macht diese Software? 
Spotmarket-Switcher ist ein benutzerfreundliches Softwaretool, mit dem Sie Geld bei Ihren Energierechnungen sparen können. Wenn Sie ein intelligentes Batterieladegerät oder Geräte wie Warmwasserbereiter haben, die sich automatisch ein- und ausschalten können, ist dieses Tool perfekt für Sie! Es schaltet Ihre Geräte intelligent ein, wenn die Energiepreise niedrig sind, was besonders nützlich ist, wenn sich Ihre Energiekosten stündlich ändern.

Dieses typische Ergebnis zeigt die Fähigkeit des Spotmarket-Switchers, den Energieverbrauch effizient zu automatisieren und so nicht nur Kosten zu sparen, sondern auch die Nutzung erneuerbarer Energiequellen zu optimieren. Es ist ein großartiges Beispiel dafür, wie intelligente Technologie genutzt werden kann, um den Energieverbrauch nachhaltiger und kostengünstiger zu steuern. (blau = Batterienutzung, rot = Netz, gelb = Solar)

<p align="center" width="100%">
    <img width="50%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/Screenshot.jpg?raw=true"> 
</p>

-   Nachtnutzung: Nachts, als die Energiepreise am niedrigsten waren, aktivierte der Spotmarket-Switcher intelligent eine schaltbare Steckdose, um die Warmwasser-Wärmepumpe einzuschalten (Spitze rot angezeigt). Dies zeigt die Fähigkeit des Systems, kostengünstige Energieperioden für energieintensive Aufgaben zu identifizieren und zu nutzen.
-   Wirtschaftlichkeit beim Batterieladen: Das Programm hat sich strategisch entschieden, den Batteriespeicher in dieser Zeit nicht zu laden. Diese Entscheidung basierte auf einer wirtschaftlichen Prüfung, bei der Ladeverluste berücksichtigt und mit den durchschnittlichen bzw. höchsten Energiepreisen des Tages verglichen wurden. Dieser Ansatz stellt sicher, dass das Laden der Batterie nur dann erfolgt, wenn es am kostengünstigsten ist.
-   Optimale Batterieausnutzung während der Spitzenzeiten: An diesem Tag waren die energieintensivsten Stunden morgens und abends am teuersten. In diesen Zeiträumen nutzt der Spotmarket-Switcher die gespeicherte Batterieenergie (blau dargestellt) und vermeidet so hohe Stromkosten.
-   Batteriereservierung für Stunden mit hohen Kosten: Nach den Zeiträumen mit hohen Kosten wurde das Energiespeichersystem (ESS) der Batterie abgeschaltet. Abends gegen 20:00 Uhr war es nicht leer. Diese Maßnahme wurde ergriffen, um ausreichend Batteriekapazität für die bevorstehenden teuren Stunden am nächsten Morgen zu reservieren. Dies antizipiert künftige Hochkostenperioden und stellt sicher, dass gespeicherte Energie zur Kostenminimierung verfügbar ist.

Warum Spotmarket-Switcher verwenden?

-   Sparen Sie Geld: Es schaltet Ihre Geräte ein, wenn der Strom günstiger ist, und senkt so Ihre Rechnungen.
-   Sparen Sie Geld: Nutzen Sie Ihren gespeicherten Solarstrom zu Höchstpreisen.
-   Energieeffizient: Indem Sie Energie nutzen, wenn ein Überschuss vorhanden ist (z. B. in windigen Nächten), tragen Sie zu einem grüneren Planeten bei.
-   Intelligente Nutzung: Laden Sie Ihren Batteriespeicher automatisch auf oder schalten Sie Geräte wie Warmwasserbereiter zu den besten Zeiten ein.

Unterstützte Systeme sind derzeit:

-   Shelly-Produkte (wie z[Shelly Plug S](https://shellyparts.de/products/shelly-plus-plug-s)oder[Shelly Plus](https://shellyparts.de/products/shelly-plus-1pm))
-   [AVMFritz!DECT200](https://avm.de/produkte/smart-home/fritzdect-200/)Und[210](https://avm.de/produkte/smart-home/fritzdect-210/)schaltbare Steckdosen
-   [Victron](https://www.victronenergy.com/)Venus OS Energiespeichersysteme wie das[MultiPlus-II-Serie](https://www.victronenergy.com/inverters-chargers)
-   [MQTT-Ladegerät](http://www.steves-internet-guide.com/mosquitto_pub-sub-clients/)(Ladegeräte, die über Mosquito MQTT-Befehle steuerbar sind)

Erste Schritte:

-   Herunterladen und installieren: Der Einrichtungsprozess ist unkompliziert. Laden Sie das Skript herunter, passen Sie ein paar Einstellungen an und schon kann es losgehen.
-   Planen und entspannen: Richten Sie es einmal ein und es wird automatisch ausgeführt. Kein täglicher Ärger!

Interessiert?

-   Schauen Sie sich unsere detaillierten Anweisungen für verschiedene Systeme wie Victron Venus OS, Windows- oder Linux-Setups an. Wir haben dafür gesorgt, dass die Schritte einfach zu befolgen sind.
-   Machen Sie mit uns die Energienutzung intelligenter und kostengünstiger! Bei Fragen, Anregungen oder Feedback können Sie sich gerne an uns wenden.

Der Code ist einfach gehalten, so dass er problemlos an andere Energiespeichersysteme angepasst werden kann, wenn Sie in der Lage sind, den Ladevorgang über Linux-Shell-Befehle zu steuern.
Schauen Sie sich bitte die Datei „controller.sh“ an und suchen Sie nach „charger_command_turnon“, damit Sie sehen können, wie einfach die Anpassung ist.
Bitte erstellen Sie einen Github-Fork und teilen Sie Ihre Anpassung, damit andere Benutzer davon profitieren können.

## Datenquelle

Die Software nutzt derzeit EPEX Spot-Stundenpreise, die von drei kostenlosen APIs (Tibber, aWATTar und Entso-E) bereitgestellt werden.
Die integrierte kostenlose Entso-E API stellt Energiepreisdaten der folgenden Länder bereit:
Albanien (AL), Österreich (AT), Belgien (BE), Bosnien und Herz. (BA), Bulgarien (BG), Kroatien (HR), Zypern (CY), Tschechische Republik (CZ), Dänemark (DK), Estland (EE), Finnland (FI), Frankreich (FR), Georgien (GE), Deutschland (DE), Griechenland (GR), Ungarn (HU), Irland (IE), Italien (IT), Kosovo (XK), Lettland (LV), Litauen (LT), Luxemburg (LU), Malta (MT), Moldawien (MD), Montenegro (ME), Niederlande (NL), Nordmazedonien (MK), Norwegen (NO), Polen (PL), Portugal (PT), Rumänien (RO), Serbien (RS), Slowakei (SK) , Slowenien (SI), Spanien (ES), Schweden (SE), Schweiz (CH), Türkei (TR), Ukraine (UA), Vereinigtes Königreich (UK) siehe[Transparenz Entso-E-Plattform](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![Screenshot 2023-12-15 221401](https://github.com/christian1980nrw/Spotmarket-Switcher/assets/6513794/25992602-b0a2-48ff-bd4c-64a6f8182297)Ein detaillierteres Protokoll können Sie mit dem folgenden Befehl in Ihrer Shell einsehen:

     cd /data/etc/Spotmarket-Switcher
     DEBUG=1 bash ./controller.sh

## Installation

Das Einrichten des Spotmarket-Switchers ist ein unkomplizierter Vorgang. Wenn Sie bereits einen UNIX-basierten Computer wie macOS, Linux oder Windows mit dem Linux-Subsystem ausführen, befolgen Sie diese Schritte, um die Software zu installieren:

1.  Laden Sie das Installationsskript mithilfe von aus dem GitHub-Repository herunter[dieser Hyperlink](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh), oder führen Sie den folgenden Befehl in Ihrem Terminal aus:
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  Führen Sie das Installationsskript mit zusätzlichen Optionen aus, um alles in einem Unterverzeichnis für Ihre Inspektion vorzubereiten. Zum Beispiel:
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    Wenn Sie Victron Venus OS verwenden, sollte das richtige DESTDIR sein`/`(das Stammverzeichnis). Schauen Sie sich gerne die installierten Dateien an`/tmp/foo`.
    Auf einem Cerbo GX ist das Dateisystem schreibgeschützt gemountet. Sehen<https://www.victronenergy.com/live/ccgx:root_access>. Um das Dateisystem beschreibbar zu machen, müssen Sie den folgenden Befehl ausführen, bevor Sie das Installationsskript ausführen:
        /opt/victronenergy/swupdate-scripts/resize2fs.sh

Bitte beachten Sie, dass diese Software derzeit zwar für das Venus-Betriebssystem optimiert ist, aber an andere Linux-Varianten angepasst werden kann, wie Debian/Ubuntu auf einem Raspberry Pi oder einem anderen kleinen Board. Ein Spitzenkandidat ist das sicherlich[OpenWRT](https://www.openwrt.org). Für Testzwecke ist die Verwendung eines Desktop-Rechners in Ordnung, im 24/7-Einsatz ist jedoch der höhere Stromverbrauch besorgniserregend.

### Zugriff auf Venus OS

Anweisungen zum Zugriff auf das Venus-Betriebssystem finden Sie unter<https://www.victronenergy.com/live/ccgx:root_access>.

### Ausführung des Installationsskripts

-   Wenn Sie Victron Venus OS verwenden:
    -   Bearbeiten Sie dann die Variablen mit einem Texteditor in`/data/etc/Spotmarket-Switcher/config.txt`.
    -   Richten Sie einen ESS-Ladeplan ein (siehe Screenshot). Im Beispiel lädt sich der Akku bei Aktivierung nachts bis zu 50 % auf, andere Ladezeiten am Tag werden ignoriert. Falls nicht gewünscht, erstellen Sie einen Zeitplan für alle 24 Stunden des Tages. Denken Sie daran, es nach der Erstellung zu deaktivieren. Stellen Sie sicher, dass die Systemzeit (wie oben rechts auf dem Bildschirm angezeigt) korrekt ist.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

Der Screenshot zeigt die Konfiguration des automatischen Ladens zu benutzerdefinierten Zeiten. Standardmäßig deaktiviert, kann vom Skript vorübergehend aktiviert werden.

-   Anleitung zur Installation des Spotmarket-Switchers auf einem Windows 10- oder 11-System zum Testen ohne Victron-Geräte (nur schaltbare Steckdosen).

    -   Start`cmd.exe`als Administrator
    -   Eingeben`wsl --install -d Debian`
    -   Geben Sie einen neuen Benutzernamen ein, z`admin`
    -   Geben Sie ein neues Passwort ein
    -   Eingeben`sudo su`und geben Sie Ihr Passwort ein
    -   Eingeben`apt-get update && apt-get install wget curl`
    -   Fahren Sie mit der manuellen Linux-Beschreibung unten fort (das Installationsskript ist nicht kompatibel).
    -   Vergessen Sie nicht, dass Windows das System stoppt, wenn Sie die Shell schließen.


-   Wenn Sie ein Linux-System wie Ubuntu oder Debian verwenden:
    -   Kopieren Sie das Shell-Skript (`controller.sh`) an einen benutzerdefinierten Speicherort und passen Sie die Variablen entsprechend Ihren Anforderungen an.
    -   Die Befehle sind`cd /path/to/save/ && curl -s -O "https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/scripts/{controller.sh,sample.config.txt,license.txt}" && chmod +x ./controller.sh && mv sample.config.txt config.txt`und zum Bearbeiten Ihrer Einstellungen verwenden Sie`vi /path/to/save/config.txt`
    -   Erstellen Sie eine Crontab oder eine andere Planungsmethode, um dieses Skript zu Beginn jeder Stunde auszuführen.
    -   Beispiel-Crontab:
          Verwenden Sie den folgenden Crontab-Eintrag, um das Steuerskript stündlich auszuführen:
          Öffnen Sie Ihr Terminal und betreten Sie es`crontab -e`, dann fügen Sie die folgende Zeile ein:`0 * * * * /path/to/controller.sh`

### Unterstützung und Beitrag :+1:

Wenn Sie dieses Projekt wertvoll finden, denken Sie bitte darüber nach, die weitere Entwicklung über diese Links zu sponsern und zu unterstützen:

-   [Revolut](https://revolut.me/christqki2)
-   [PayPal](https://paypal.me/christian1980nrw)

Wenn Sie aus Deutschland kommen und an einem Wechsel zu einem dynamischen Stromtarif interessiert sind, können Sie das Projekt unterstützen, indem Sie sich hier anmelden[Tibber (Empfehlungslink)](https://invite.tibber.com/ojgfbx2e)oder durch Eingabe des Codes`ojgfbx2e`in Ihrer App. Sowohl Sie als auch das Projekt erhalten**50 Euro Bonus für Hardware**. Bitte beachten Sie, dass für einen Stundentarif ein Smart Meter oder ein Pulse-IR erforderlich ist (<https://tibber.com/de/store/produkt/pulse-ir>).
Wenn Sie einen Erdgastarif benötigen oder einen klassischen Stromtarif bevorzugen, können Sie das Projekt trotzdem unterstützen[Octopus Energy (Empfehlungslink)](https://share.octopusenergy.de/glass-raven-58).
Sie erhalten einen Bonus (das Angebot variiert**zwischen 50 und 120 Euro**) für sich selbst und auch für das Projekt.
Octopus hat den Vorteil, dass einige Angebote ohne Mindestvertragslaufzeit sind. Sie eignen sich beispielsweise ideal, um einen an Börsenkursen orientierten Tarif zu pausieren.

Wenn Sie aus Österreich kommen, können Sie uns mit unterstützen[aWATTar Österreich (Referenzlink)](https://www.awattar.at/services/offers/promotecustomers). Bitte nutzen Sie es`3KEHMQN2F`als Code.

## Haftungsausschluss

Bitte beachten Sie die Nutzungsbedingungen unter<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/License.md>

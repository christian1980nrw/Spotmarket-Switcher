# Victron-ESS, Shelly Plug S und AVM-Fritz-DECT200-210 Spotmarket-Switcher

Willkommen im Victron-ESS & Shelly Plug S & AVM-Fritz-DECT200-210 Spotmarket-Switcher-Repository! Diese Software wurde entwickelt, um die Funktionalität Ihres Energiesystems durch die Integration von Folgendem zu verbessern:

-   [Victron](https://www.victronenergy.com/)Venus OS Energiespeichersysteme
-   Shelly-Produkte (wie Shelly Plug S oder Shelly Plus1PM)
-   AVM Fritz!DECT200 und 210 schaltbare Steckdosen

Das Hauptziel dieser Software besteht darin, Ihr System in die Lage zu versetzen, auf Spotmarkt-Strompreise zu reagieren und so intelligente Entscheidungen wie das Laden der Batterie und die Stromaktivierung auf der Grundlage von Zeiträumen mit niedrigen Preisen zu treffen.

## Was diese Software bietet

Für diejenigen, die in Umgebungen mit dynamischen Strompreisen tätig sind, insbesondere in Europa, wo Preisschwankungen am nächsten Tag aufgrund von Energie-Spotmärkten an der Tagesordnung sind, ist diese Software ein wertvoller Vorteil. Beliebte Energieversorger mögen[Tibber (Empfehlungslink)](https://tibber.com/de/invite/ojgfbx2e)Leiten Sie diese Preisniveaus in Echtzeit an Endverbraucher weiter und ermöglichen Sie so einen sparsameren und nachhaltigeren Energieverbrauch.

Durch die Integration dieser Software haben Sie die Möglichkeit, zur sauberen Energie beizutragen oder einfach Ihren Energieverbrauch zu optimieren. Zum Beispiel:

-   **Erneuerbare Priorität:**Stellen Sie sicher, dass Ihr Energieverbrauch mit der Verfügbarkeit erneuerbarer Energien übereinstimmt, und meiden Sie nicht erneuerbare Energiequellen in Zeiten geringer Sonneneinstrahlung und wenig Wind.
-   **Batterieoptimierung:**Wenn Sie über ein Speichersystem verfügen, ermöglicht die Software das Aufladen Ihrer Batterie, wenn die Strompreise unter dem Einspeisetarif liegen, und nutzen so kostengünstige Energie.
-   **Benutzerdefinierte Regeln:**Passen Sie die Software anhand von Faktoren wie Batteriekapazität, voraussichtlichem Energieverbrauch und vorhergesagtem Sonnenschein an Ihre Bedürfnisse an. Dies eröffnet die Möglichkeit, nachts oder zu bestimmten Zeiten günstige Windenergiepreise zu nutzen.
-   **Unabhängige ESS-Nutzung:**Diese Software ermöglicht die Nutzung von Energiespeichersystemen (ESS) auch ohne Solarpanel-Installationen und bietet so einen Mehrwert für alle Nutzer, insbesondere in den Wintermonaten.

## Datenquelle

Die Software nutzt derzeit EPEX Spot-Stundenpreise, die von drei kostenlosen APIs (Tibber, aWATTar und Entso-E) bereitgestellt werden.
Die integrierte kostenlose Entso-E API stellt Energiepreisdaten der folgenden Länder bereit:
Albanien (AL), Österreich (AT), Belgien (BE), Bosnien und Herz. (BA), Bulgarien (BG), Kroatien (HR), Zypern (CY), Tschechische Republik (CZ), Dänemark (DK), Estland (EE), Finnland (FI), Frankreich (FR), Georgien (GE), Deutschland (DE), Griechenland (GR), Ungarn (HU), Irland (IE), Italien (IT), Kosovo (XK), Lettland (LV), Litauen (LT), Luxemburg (LU), Malta (MT), Moldawien (MD), Montenegro (ME), Niederlande (NL), Nordmazedonien (MK), Norwegen (NO), Polen (PL), Portugal (PT), Rumänien (RO), Serbien (RS), Slowakei (SK) , Slowenien (SI), Spanien (ES), Schweden (SE), Schweiz (CH), Türkei (TR), Ukraine (UA), Vereinigtes Königreich (UK) siehe[Transparenz Entso-E-Plattform](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![grafik](https://user-images.githubusercontent.com/6513794/224442951-c0155a48-f32b-43f4-8014-d86d60c3b311.png)

## Installation

Die Einrichtung des Victron-ESS & Shelly Plug S & AVM-Fritz-DECT200-210 Spotmarket-Switcher ist ein unkomplizierter Vorgang. Wenn Sie bereits einen UNIX-basierten Computer wie macOS, Linux oder Windows mit dem Linux-Subsystem ausführen, befolgen Sie diese Schritte, um die Software zu installieren:

1.  Laden Sie das Installationsskript mithilfe von aus dem GitHub-Repository herunter[dieser Hyperlink](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh), oder führen Sie den folgenden Befehl in Ihrem Terminal aus:
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  Führen Sie das Installationsskript mit zusätzlichen Optionen aus, um alles in einem Unterverzeichnis für Ihre Inspektion vorzubereiten. Zum Beispiel:
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    Wenn Sie Victron Venus OS verwenden, sollte das richtige DESTDIR sein`/`(das Stammverzeichnis). Schauen Sie sich gerne die installierten Dateien an`/tmp/foo`.

Bitte beachten Sie, dass diese Software derzeit zwar für das Venus OS optimiert ist, aber an andere Setups angepasst werden kann, beispielsweise die Steuerung von Haushaltsgeräten über IP-Switches. Zukünftige Entwicklungen könnten die Kompatibilität mit anderen Systemen verbessern.

### Zugriff auf Venus OS

Anweisungen zum Zugriff auf das Venus-Betriebssystem finden Sie unter<https://www.victronenergy.com/live/ccgx:root_access>.

### Ausführung des Installationsskripts

-   Wenn Sie Victron Venus OS verwenden:
    -   Ausführen`victron-venus-os-install.sh`um den Spotmarket-Switcher herunterzuladen und zu installieren.
    -   Bearbeiten Sie die Variablen mit einem Texteditor in`/data/etc/Spotmarket-Switcher/controller.sh`.
    -   Richten Sie einen ESS-Ladeplan ein (siehe Screenshot). Im Beispiel lädt sich der Akku bei Aktivierung nachts bis zu 50 % auf. Denken Sie daran, es nach der Erstellung zu deaktivieren. Stellen Sie sicher, dass die Systemzeit (wie im Screenshot gezeigt) korrekt ist.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

-   Wenn Sie ein anderes Betriebssystem verwenden:
    -   Kopieren Sie das Shell-Skript (`controller.sh`) an einen benutzerdefinierten Speicherort und passen Sie die Variablen entsprechend Ihren Anforderungen an.
    -   Erstellen Sie eine Crontab oder eine andere Planungsmethode, um dieses Skript zu Beginn jeder Stunde auszuführen.
    -   Beispiel-Crontab:
          Verwenden Sie den folgenden Crontab-Eintrag, um das Steuerskript stündlich auszuführen:
          Öffnen Sie Ihr Terminal und betreten Sie es`crontab -e`, dann fügen Sie die folgende Zeile ein:
            0 * * * * /path/to/controller.sh

### Unterstützung und Beitrag

Wenn Sie dieses Projekt wertvoll finden, denken Sie bitte darüber nach, die weitere Entwicklung über diese Links zu sponsern und zu unterstützen:

-   [Revolut](https://revolut.me/christqki2)
-   [PayPal](https://paypal.me/christian1980nrw)

Wenn Sie außerdem in Deutschland leben und an einem Wechsel zu einem dynamischen Stromtarif interessiert sind, können Sie das Projekt unterstützen, indem Sie sich hier anmelden[Tibber (Empfehlungslink)](https://invite.tibber.com/ojgfbx2e). Sowohl Sie als auch das Projekt erhalten einen 50-Euro-Bonus für Hardware. Bitte beachten Sie, dass ein Smart Meter oder ein Tracker wie Pulse[hier verfügbar](https://tibber.com/de/store/produkt/pulse-ir)ist für einen Stundentarif erforderlich.

Wenn Sie einen Erdgastarif benötigen oder einen klassischen Stromtarif bevorzugen, können Sie das Projekt trotzdem hierdurch unterstützen[Octopus Energy-Empfehlungslink](https://share.octopusenergy.de/glass-raven-58)und erhalte 50 Euro Bonus für dich und das Projekt.
Octopus hat den Vorteil, dass die Verträge meist nur eine monatliche Laufzeit haben. Sie eignen sich beispielsweise ideal, um einen an Börsenkursen orientierten Tarif zu pausieren.

## Haftungsausschluss

Dieses Computerprogramm wird „wie besehen“ zur Verfügung gestellt und der Benutzer übernimmt bei der Nutzung das volle Risiko. Der Autor gibt keine Zusicherungen oder Gewährleistungen hinsichtlich der Genauigkeit, Zuverlässigkeit, Vollständigkeit oder Eignung des Programms für einen bestimmten Zweck. Der Autor haftet nicht für Schäden, die sich aus der Nutzung oder Unmöglichkeit der Nutzung des Programms ergeben, einschließlich, aber nicht beschränkt auf direkte, indirekte, zufällige, besondere oder Folgeschäden.

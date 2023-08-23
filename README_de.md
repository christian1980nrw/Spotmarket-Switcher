# Victron-ESS, Shelly Plug S und AVM-Fritz-DECT200-210 Spotmarkt-Schalter

Herzlich willkommen im Victron-ESS & Shelly Plug S & AVM-Fritz-DECT200-210 Spotmarkt-Schalter Repository!
Diese Software wurde entwickelt, um die Funktionalität Ihrer Energieanlage zu erweitern, indem sie folgende Komponenten integriert:

- Victron Venus OS Energiespeicher-Systeme
- Shelly-Produkte (wie Shelly Plug S oder Shelly Plus1PM)
- AVM Fritz!DECT200 und 210 schaltbare Steckdosen

Das Hauptziel dieser Software besteht darin, Ihr System in die Lage zu versetzen, auf die Preisschwankungen am Spotmarkt für Strom zu reagieren. Dadurch kann beispielsweise das Aufladen von Batterien oder das Aktivieren der Stromversorgung ohne händisches Zutun auf Zeiten mit niedrigen Preisen gelegt werden.

## Was diese Software bietet

In Europa gibt es Preisänderungen auf Energiemärkten mit stündlichen Anpassungen, allerdings bereits am Vortag anhand von Vorhersagen festgelegt.  Beliebte Energieanbieter wie Tibber oder Awattar übermitteln diese Echtzeit-Preisniveaus an Endnutzer, um wirtschaftlicheren und nachhaltigeren Energieverbrauch zu ermöglichen. Diese Software unterstützt entsprechende automatisierte Anpassungen der Verbraucher.

Durch die Integration dieser Software haben Sie die Möglichkeit, zur sauberen Energieversorgung beizutragen oder einfach nur Ihren Energieverbrauch zu optimieren und so Geld zu sparen:
- **Priorität für erneuerbare Energien:** Stellen Sie sicher, dass Ihr Energieverbrauch mit der Verfügbarkeit erneuerbarer Energien in Einklang steht, um nicht-erneuerbare Quellen während Zeiten geringer Sonneneinstrahlung und Wind zu vermeiden.
- **Batterieoptimierung:** Wenn Sie ein Energiespeichersystem besitzen, ermöglicht Ihnen die Software, Ihre Batterie aufzuladen, wenn die Strompreise niedriger sind als die Einspeisevergütung, um kostengünstige Energie optimal zu nutzen.
- **Individuelle Regelungen:** Passen Sie die Software an Ihre Bedürfnisse an, basierend auf Faktoren wie Batteriekapazität, erwartetem Energieverbrauch und vorausgesagtem Sonnenschein. Dies eröffnet die Möglichkeit, günstige Windenergiepreise in der Nacht oder zu bestimmten Zeiträumen zu nutzen.
- **Unabhängige Nutzung von Energiespeichersystemen:** Diese Software fördert die Nutzung von Energiespeichersystemen (ESS) auch ohne Installation von Solaranlagen und bietet Mehrwert für alle Benutzer, insbesondere während der Wintermonate.

## Datenquelle und Erweiterbarkeit

Die Software verwendet derzeit stündliche EPEX Spot DE-LU Preise, wie sie von einem deutschen Energieanbieter bereitgestellt werden. Wir möchten Sie aber dazu anhalten, uns Patches zukommen zu lassen, um ähnliche Dienste auf anderen Kontinenten zu nutzen.

Für diejenigen, die tiefer in die Integration von APIs einsteigen möchten, finden Sie wichtige Informationen zur Nutzung der API auf unserer Referenzwebsite: [Awattar API-Dokumentation](https://www.awattar.de/services/api). Es ist erwähnenswert, dass die API für Kunden des Anbieters kostenlos ist und dem Fair-Use-Prinzip folgt. Derzeit ist kein Zugriffstoken erforderlich. Alternativ kann die kostenlose Entso-E-API, die ganz Europa abdeckt, verwendet werden.

## Visualisierung der Strompreise

Um Einblicke in die Strompreise zu erhalten und fundierte Entscheidungen zu treffen, empfiehlt sich die [Transparency Entso-E Platform](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show). Diese Plattform ermöglicht es Ihnen, Tagespreise im Voraus zu visualisieren und zu analysieren, mit einer Auflösung von PT60M. Bleiben Sie informiert, um handlungsfähig zu bleiben.

Wir hoffen, dass diese Software Intelligenz und Effizienz in Ihre Energieanlage bringt. Lassen Sie uns gemeinsam an einer intelligenteren und nachhaltigeren Energiezukunft arbeiten!

![grafik](https://user-images.githubusercontent.com/6513794/224442951-c0155a48-f32b-43f4-8014-d86d60c3b311.png)

## Installation

Die Einrichtung des Victron-ESS & Shelly Plug S & AVM-Fritz-DECT200-210 Spotmarkt-Schalters ist ein unkomplizierter Vorgang. Wenn Sie bereits eine UNIX-basierte Maschine verwenden, wie macOS, Linux oder Windows mit dem Linux-Subsystem, befolgen Sie diese Schritte, um die Software zu installieren:

1. Laden Sie das Installations-Skript aus dem GitHub-Repository herunter, indem Sie [diesen Link verwenden](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh), oder führen Sie den folgenden Befehl in Ihrem Terminal aus:
   ```
   wget https://raw.githubusercontent.com/christian1980nrw/Victron-ESS__Shelly-Plug-S__AVM-Fritz-DECT200-210__Spotmarket-Switcher/main/victron-venus-os-install.sh
   ```

2. Führen Sie das Installations-Skript aus und verwenden Sie zusätzliche Optionen, um alles in einem Unterverzeichnis für Ihre Überprüfung vorzubereiten. Zum Beispiel:
   ```
   DESTDIR=/tmp/foo sh victron-venus-os-install.sh
   ```
   Wenn Sie Victron Venus OS verwenden, sollte das korrekte DESTDIR `/` (das Stammverzeichnis) sein. Sie können die installierten Dateien in `/tmp/foo` erkunden.

Bitte beachten Sie, dass diese Software derzeit für das Venus OS optimiert ist, aber an andere Setups angepasst werden kann, beispielsweise um Haushaltsgeräte über IP-Schalter zu steuern. Zukünftige Entwicklungen sollen die Kompatibilität mit anderen Systemen verbessern.

### Zugriff auf Venus OS

Für Anweisungen zum Zugriff auf das Venus OS beachten Sie bitte [https://www.victronenergy.com/live/ccgx:root_access](https://www.victronenergy.com/live/ccgx:root_access).

### Ausführung des Installations-Skripts

- Wenn Sie Victron Venus OS verwenden:
  - Führen Sie `victron-venus-os-install.sh` aus, um den Spotmarkt-Schalter herunterzuladen und zu installieren.
  - Bearbeiten Sie die Variablen, indem Sie `vi /data/etc/Spotmarket-Switcher/controller.sh` ausführen.
  - Setzen Sie nach der Anpassung mit Schritt 3 fort.

- Wenn Sie ein anderes Betriebssystem verwenden:
  1. Kopieren Sie das Shell-Skript (`controller.sh`) an einen benutzerdefinierten Ort und passen Sie die Variablen entsprechend Ihren Anforderungen an.
  2. Erstellen Sie eine Crontab oder eine andere Zeitplanungsmethode, um dieses Skript zu jeder vollen Stunde auszuführen.
  3. Richten Sie einen ESS-Ladeplan ein (siehe Screenshot). Im Beispiel wird die Batterie nachts bis zu 50 % aufgeladen, wenn die Aktivierung erfolgt ist. Denken Sie daran, sie nach der Erstellung zu deaktivieren. Überprüfen Sie, ob die Systemzeit (wie im Screenshot gezeigt) korrekt ist.

![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

### Beispiel-Crontab

Verwenden Sie den folgenden Crontab-Eintrag, um das Steuerskript stündlich auszuführen:

Öffnen Sie Ihr Terminal und geben Sie `crontab -e` ein, dann fügen Sie die folgende Zeile ein:
```
0 * * * * /Pfad/zur/controller.sh
```

### Unterstützung und Beitrag

Wenn Sie dieses Projekt wertvoll finden, erwägen Sie bitte, die weitere Entwicklung durch diese Links zu unterstützen:
- [Revolut](https://revolut.me/christqki2)
- [PayPal](https://paypal.me/christian1980nrw)

Zusätzlich können Sie, wenn Sie in Deutschland sind und sich für einen dynamischen Stromtarif interessieren, das Projekt unterstützen, indem Sie sich über diesen [Tibber Empfehlungslink](https://invite.tibber.com/ojgfbx2e) anmelden. Sowohl Sie als auch das Projekt erhalten einen 50 Euro Bonus für Hardware. Bitte beachten Sie, dass ein intelligenter Zähler oder ein Tracker wie der Pulse [hier erhältlich](https://tibber.com/de/store/produkt/pulse-ir) erforderlich ist für einen stündlichen Tarif.

Wenn Sie einen Erdgastarif benötigen oder einen klassischen Stromtarif bevorzugen, können Sie das Projekt dennoch durch diesen [Octopus Energy Empfehlungslink](https://share.octopusenergy.de/glass-raven-58) unterstützen und einen 50 Euro Bonus für sich und das Projekt erhalten.

## Haftungsausschluss

Dieses Computerprogramm wird "wie besehen" zur Verfügung gestellt, und der Benutzer trägt das volle Risiko bei der Verwendung. Der Autor übernimmt keine Garantien hinsichtlich der Genauigkeit, Zuverlässigkeit, Vollständigkeit oder Eignung des Programms für einen bestimmten Zweck. Der Autor haftet nicht für Schäden, die aus der Verwendung oder Unfähigkeit zur Verwendung des Programms entstehen, einschließlich direkter, indirekter, zufälliger, besonderer oder Folgeschäden.

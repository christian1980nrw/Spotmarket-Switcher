# Victron-ESS & AVM-Fritz-DECT200-210 Spotmarket-Switcher
(deutsche Übersetzung am Ende / German translation at the end)

Shell script that manages Victron Venus OS ESS-Systems and/or AVM Fritz!DECT200 and 210 switchable sockets so that it charges/switches, 
when spot-market prices at Tibber or Awattar are low. 
If you have spot-market energy prices, you are able to charge your battery if the price is lower
than your own feed-in tariff or you can use cheap prices of wind energy at night.

This allows you to use your battery even in winter without sun. 

You need a hourly based dynamic tariff for this but of course you are able to test this script before
you change your provider and think about a smart meter.
The prices (EPEX Spot DE-LU hourly prices) are from a german energy provider, 
but you can fork my script and create your own if you have other data sources.
Please note the information about using the API on the following website: https://www.awattar.de/services/api
The API is available to the provider's customers free of charge according to the fair use principle.
You currently do not need an access token! You can alternate use the free Entso-E API which is supporting whole europe.

You can compare the prices here:
https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show (choose delivery day and resolution PT60M).

![grafik](https://user-images.githubusercontent.com/6513794/209883987-5660ebb9-07aa-4aaa-a6c9-a6d650482610.png)

## Installation

If you are using Victron Venus OS: Execute victron-venus-os-install.sh, it will download and install the Spotmarket-Switcher.

If you are using another OS:
1. Copy the shell script (controller.sh) into a custom location and change the variables according to your needs.
2. Create a crontab or another way to run this script after a new hour has started.
3. Create a ESS charge schedule (see screenshot) at the first position. In my example the battery will be charged at night up to 50% if activated.
   Please deactivate it after creating. Please check if the system time (at the screenshot) is correct.
   
![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

### Sample crontab
This crontab runs the control script every hour.

crontab -e and insert the folowing line
```
0 * * * * /path/to/controller.sh
```

If you live in Germany and would like to switch to a dynamic electricity tariff, you can support me and take out the tariff via the following link. We both get a 50 euro bonus for hardware.
https://invite.tibber.com/ojgfbx2e
In the tibber app, click at "i was invited" and enter the code ojgfbx2e in the app.
Please note that you need a smart meter or a tracker like Pulse https://tibber.com/de/store/produkt/pulse-ir for a hourly tariff.
Enter the first 4 digits of your meter number on that website to check Pulse compatibility. Of course you can use your bonus for the Pulse order. To do this, wait until the delivery date has been confirmed and the bonus has been credited.
If you need the tibber app, please scan this with your smartphone.

![grafik](https://user-images.githubusercontent.com/6513794/208248287-bce59608-2af5-4217-9990-e506cde19df4.png)


Thanks and regards, Christian


Dieses Skript dient dazu, ein Victron Venus OS Energiespeichersystem (ESS) zu verwalten, indem der Akku geladen wird, wenn die Energiepreise niedrig sind. Es kann auch so konfiguriert werden, dass zusätzliche Last (wie beispielsweise ein Warmwasserspeicher) mithilfe von schaltbaren Steckdosen von AVM FRITZ!DECT 200 oder 210 aktiviert wird. Das Skript bezieht stündliche Energiepreise von einem deutschen Energieversorger, und ruft dort die EPEX Spot DE-LU oder AT stündlichen Preise ab. Es kann unterstützt jedoch auch die kostenlose Entso-E API, die ganz Europa abdeckt.

Um das Skript zu verwenden, müssen Sie es in einen benutzerdefinierten Ort kopieren und die Variablen anpassen. Sie müssen auch eine Crontab oder eine ähnliche Mechanismus erstellen, um das Skript jede Stunde auszuführen. Darüber hinaus müssen Sie in der Victron Venus OS-System einen ESS-Ladetermin erstellen und ihn als erstes Element in der Liste positionieren. Es wird empfohlen, den Ladetermin nach der Erstellung zu deaktivieren.

Um das Skript zu installieren, müssen Sie die Crontab bearbeiten, indem Sie den Befehl "crontab -e" ausführen und eine Zeile einfügen, die das Skript jede Stunde ausführt. Beispielsweise wird "0 * * * * /pfad/zu/controller.sh" das Skript zu Beginn jeder Stunde ausführen.

Es ist zu beachten, dass Sie einen Smart Meter oder einen Tracker wie Pulse benötigen, um einen dynamischen Stromtarif verwenden zu können. Sie können die Website von Tibber verwenden, um zu überprüfen, ob Ihr Zähler mit Pulse kompatibel ist. Wenn Sie an einem Wechsel zu einem dynamischen Stromtarif interessiert sind, können Sie Tibber als Anbieter in Betracht ziehen. Sie können den Einladungscode "ojgfbx2e" verwenden, um einen Bonus von 50 Euro für Hardware zu erhalten. Selbstverständlich können Sie Ihren Bonus für die Pulse Bestellung verwenden. Warten Sie dazu ab bis der Belieferungstermin bestätigt wurde und der Bonus gutgeschrieben wurde.


Haftungsausschluss(Disclaimer):
Dieses Computerprogramm wird "wie es ist" bereitgestellt und der Nutzer trägt das volle Risiko bei der Nutzung. Der Autor übernimmt keine Gewährleistung für die Genauigkeit, Zuverlässigkeit, Vollständigkeit oder Brauchbarkeit des Programms für irgendeinen bestimmten Zweck. Der Autor haftet weder für Schäden, die sich aus der Nutzung oder Unfähigkeit zur Nutzung des Programms ergeben, noch für Schäden, die aufgrund von Fehlern oder Mängeln des Programms entstehen. Dies gilt auch für Schäden, die aufgrund von Verletzungen von Pflichten im Rahmen einer vertraglichen oder außervertraglichen Verpflichtung entstehen.

Disclaimer:
This computer program is provided "as is" and the user bears the full risk of using it. The author makes no representations or warranties of any kind concerning the accuracy, reliability, completeness or suitability of the program for any particular purpose. The author shall not be liable for any damages of any kind arising from the use or inability to use the program, including but not limited to direct, indirect, incidental, special or consequential damages.

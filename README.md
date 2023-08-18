# Victron-ESS & Shelly Plug S & AVM-Fritz-DECT200-210 Spotmarket-Switcher

This software provides an extension of the
- Victron Venus OS ESS-Systems and/or
- Shelly products ( like Shelly Plug S or Shelly Plus1PM ) and/or
- AVM Fritz!DECT200 and 210 switchable sockets 
to be active (charging batteries, switch-on power) when spot-market prices are low.

This software is of immediate use for all those with dynamic prices for electrical power.
In Europe, those prices are known a day in advance, as determined at the spot-market for energy.
Providers like Tibber or Awattar are forwarding those price levels to regular end users.
Or you may just feel altruistic and avoid energy consumption when renewables are not available (no sun and no wind) or when demand is exceptionally high.
For owners of a storage sytem this implies to charge their battery whenever the price is lower
than the feed-in tariff.
Additional rules may apply depending on the size of the available battery, anticipated energy consumption
and the expected sunshine, like benefiting from cheap prices of wind energy at night.
As a side-effect, this supports the employment of ESS without the co-installation of solar panels
and will be beneficial during winter for everyone.

The prices (EPEX Spot DE-LU hourly prices) are provided by a German energy provider, 
but please provide a patch to extend this script for analogous services on other continents.
Please note the information about using the API on the following website: https://www.awattar.de/services/api
Their API is available to the provider's customers free of charge according to the fair use principle.
You currently do not need an access token! You can alternatively use the free Entso-E API which is supporting the whole of Europe.

To compare prices see
https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show (choose delivery day and resolution PT60M).

![grafik](https://user-images.githubusercontent.com/6513794/224442951-c0155a48-f32b-43f4-8014-d86d60c3b311.png)

## Installation

If you are already running a UNIX-based machine, like a MacOS or Linux, or Windows with the Linux subsystem, then you can execute the install script on your machine immediately, just as described below - just, your Desktop is unlikely to be the machine that is running 24/7 to control the devices. And it is also unlikely to be prepared to connect via the CAN bus, so it will not reach out to the Victron devices you want to control. And even if you had a USB-CAN adapter, this software would not yet be prepared to access that interface.

Anyway, you can execute the installer on any machine to become familiar with the overall setip. For an immediate impression,
download script individually from the GitHub repository by following [this hyperlink](https://raw.githubusercontent.com/christian1980nrw/Victron-ESS__Shelly-Plug-S__AVM-Fritz-DECT200-210__Spotmarket-Switcher/main/victron-venus-os-install.sh) or by executing the following on the command line:
```
wget https://raw.githubusercontent.com/christian1980nrw/Victron-ESS__Shelly-Plug-S__AVM-Fritz-DECT200-210__Spotmarket-Switcher/main/victron-venus-os-install.sh
```

Run it, with the additional options set so that it prepares everything in a subdirectory for you to inspect:
```
DESTDIR=/tmp/foo sh victron-venus-os-install.sh
```
After installation please look at the files installed in /tmp/foo. If you are using Victron Venus OS, the correct DESTDIR for a permanent installation should be / (the root directory).

This software is prepared to run on the Venus OS, which is the operating system of Victron's control unit ("Cerbo") that is also availble independently as an Open Source project for the Raspberry Pi. It is running 24/7 and has CAN already built-in.
Most users (all we know, including ourselves) currently run this software on a Raspberry Pi with an extra CAN-HAT.
It should also work with a Cerbo GX (featuring a CAN interface built-in).

If you are inclined to only control household devices via IP switches, not the Victron devices via CAN, then not too much should be required to be changed to have this script run, say, on a Fritz!Box, an OpenWrt router or something else that is already running 24/7 in your household - we just did not get around to automate such setups, yet.

### Access to Venus OS

Please follow instructions on [https://www.victronenergy.com/live/ccgx:root_access](https://www.victronenergy.com/live/ccgx:root_access).

### Execution of install script

If you are using Victron Venus OS: Execute victron-venus-os-install.sh, it will download and install the Spotmarket-Switcher.
After that you can edit the variables ( vi /data/etc/Spotmarket-Switcher/controller.sh ) and continue with step 3.

If you are using another OS:
1. Copy the shell script (controller.sh) into a custom location and change the variables according to your needs.
2. Create a crontab or another way to run this script after a new hour has started.
3. Create a ESS charge schedule (see screenshot) at the first position.
   In my example the battery will be charged at night up to 50% if activated.
   Please deactivate it after creating. Please check if the system time (at the screenshot) is correct.
   
![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

### Sample crontab
This crontab runs the control script every hour.

crontab -e and insert the folowing line
```
0 * * * * /path/to/controller.sh
```

Please sponsor this project and support further development: https://revolut.me/christqki2 or https://paypal.me/christian1980nrw
If you live in Germany and would like to switch to a dynamic electricity tariff, you can support me and take out the tariff via the following link.
We both get a 50 euro bonus for hardware. Visit https://invite.tibber.com/ojgfbx2e
In the tibber app, click at "I was invited" and enter the code ojgfbx2e in the app.
Please note that you need a smart meter or a tracker like Pulse https://tibber.com/de/store/produkt/pulse-ir for a hourly tariff.
Enter the first 4 digits of your meter number on that website to check Pulse compatibility. Of course you can use your bonus for the Pulse order. To do this, wait until the delivery date has been confirmed and the bonus has been credited.

If you need a cheap natural gas tariff or if you are not conviced to choose the dynamic tibber tariff, you can still support this project and choose a classic electricity tariff with this link to get 50 euro bonus for yourself and 50 euro bonus for this project: https://share.octopusenergy.de/glass-raven-58 .

Disclaimer:
This computer program is provided "as is" and the user bears the full risk of using it.
The author makes no representations or warranties of any kind concerning the accuracy,
reliability, completeness or suitability of the program for any particular purpose.
The author shall not be liable for any damages of any kind arising from the use or inability to use the program,
including but not limited to direct, indirect, incidental, special or consequential damages.

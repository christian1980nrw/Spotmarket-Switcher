<p align="center" width="100%">
    <img width="33%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/SpotmarketSwitcherLogo.png?raw=true"> 
</p>

[Čeština](README.cs.md)-[dánština](README.da.md)-[Deutsch ](README.de.md) - [Angličtina](README.md)-[španělština](README.es.md)-[estonština](README.et.md)-[finština](README.fi.md)-[francouzština](README.fr.md)-[řecký](README.el.md)-[italština](README.it.md)-[holandský](README.nl.md)-[norský](README.no.md)-[polština](README.pl.md)-[portugalština](README.pt.md) - [švédský](README.sv.md)-[japonský](README.ja.md)

## Vítejte v úložišti Spotmarket-Switcher!

Co tento software dělá?
Toto je skript shellu Linux a zapíná vaši nabíječku baterií a / nebo přepínatelné zásuvky ve správný čas, pokud jsou vaše hodinové ceny dynamické energie nízké.
Pomocí zásuvek pak můžete mnohem levněji zapnout zásobník teplé vody nebo můžete automaticky nabíjet bateriové úložiště v noci, když je v síti dostupná levná větrná energie.
Očekávaný solární výnos lze zohlednit pomocí meteorologického API a odpovídajícím způsobem rezervovaného akumulátoru.
Aktuálně jsou podporované systémy:

-   Produkty Shelly (jako např[Shelly Plug S](https://shellyparts.de/products/shelly-plus-plug-s)nebo[Shelly Plus](https://shellyparts.de/products/shelly-plus-1pm))
-   [AVMFritz!DECT200](https://avm.de/produkte/smart-home/fritzdect-200/)a[210](https://avm.de/produkte/smart-home/fritzdect-210/)vypínatelné zásuvky
-   [Victron](https://www.victronenergy.com/)Systémy ukládání energie Venus OS, jako je např[Řada MultiPlus-II](https://www.victronenergy.com/inverters-chargers)

Kód je jednoduchý, takže jej lze snadno přizpůsobit jiným systémům skladování energie, pokud jste schopni ovládat nabíjení pomocí příkazů shellu Linux.
Podívejte se prosím pod řádek 100 souboru controller.sh, abyste viděli, co může uživatel nakonfigurovat.

## Zdroj dat

Software v současnosti využívá hodinové ceny EPEX Spot poskytované třemi bezplatnými API (Tibber, aWATTar & Entso-E).
Integrované bezplatné Entso-E API poskytuje údaje o cenách energie v následujících zemích:
Albánie (AL), Rakousko (AT), Belgie (BE), Bosna a Herc. (BA), Bulharsko (BG), Chorvatsko (HR), Kypr (CY), Česká republika (CZ), Dánsko (DK), Estonsko (EE), Finsko (FI), Francie (FR), Gruzie (GE), Německo (DE), Řecko (GR), Maďarsko (HU), Irsko (IE), Itálie (IT), Kosovo (XK), Lotyšsko (LV), Litva (LT), Lucembursko (LU), Malta (MT), Moldavsko (MD), Černá Hora (ME), Nizozemsko (NL), Severní Makedonie (MK), Norsko (NO), Polsko (PL), Portugalsko (PT), Rumunsko (RO), Srbsko (RS), Slovensko (SK) , Slovinsko (SI), Španělsko (ES), Švédsko (SE), Švýcarsko (CH), Turecko (TR), Ukrajina (UA), Spojené království (UK) viz.[Transparentnost Platforma Entso-E](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![grafik](https://user-images.githubusercontent.com/6513794/224442951-c0155a48-f32b-43f4-8014-d86d60c3b311.png)

## Instalace

Nastavení Spotmarket-Switcheru je jednoduchý proces. Pokud již používáte počítač se systémem UNIX, jako je macOS, Linux nebo Windows se subsystémem Linux, nainstalujte software podle následujících kroků:

1.  Stáhněte si instalační skript z úložiště GitHub pomocí[tento hypertextový odkaz](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh)nebo ve svém terminálu spusťte následující příkaz:
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  Spusťte instalační skript s dalšími možnostmi, abyste připravili vše v podadresáři pro vaši kontrolu. Například:
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    Pokud používáte Victron Venus OS, měl by být správný DESTDIR`/`(kořenový adresář). Neváhejte prozkoumat nainstalované soubory v`/tmp/foo`.

Vezměte prosím na vědomí, že i když je tento software v současné době optimalizován pro OS Venus, lze jej přizpůsobit jiným variantám Linuxu, jako je Debian/Ubuntu na Raspberry Pi nebo jiné malé desce. Hlavním kandidátem určitě je[OpenWRT](https://www.openwrt.org). Používání stolního počítače je vhodné pro testovací účely, ale při nepřetržitém používání je jeho větší spotřeba energie znepokojivá.

### Přístup k OS Venus

Pokyny pro přístup k OS Venus najdete na<https://www.victronenergy.com/live/ccgx:root_access>.

### Spuštění instalačního skriptu

-   Pokud používáte Victron Venus OS:
    -   Po provedení`victron-venus-os-install.sh`, upravte proměnné pomocí textového editoru v`/data/etc/Spotmarket-Switcher/controller.sh`.
    -   Nastavte plán nabíjení ESS (viz dodaný snímek obrazovky). V tomto příkladu se baterie nabíjí v noci až na 50 %, pokud je aktivována, ostatní doby nabíjení během dne jsou ignorovány. Pokud nechcete, vytvořte plán na všech 24 hodin dne. Nezapomeňte jej po vytvoření deaktivovat. Ověřte, že systémový čas (jak je zobrazen v pravém horním rohu obrazovky) je přesný.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

Snímek obrazovky ukazuje konfiguraci automatického nabíjení během uživatelem definovaných časů. Ve výchozím nastavení deaktivováno, může být dočasně aktivováno skriptem.

-   Pokyny k instalaci Spotmarket-Switcher na systém Windows 10 nebo 11 pro testování bez zařízení Victron (pouze přepínatelné zásuvky).

    -   zahájení`cmd.exe`jako správce
    -   Vstupte`wsl --install -d Debian`
    -   Zadejte nové uživatelské jméno jako`admin`
    -   vložte nové heslo
    -   Vstupte`sudo su`a zadejte své heslo
    -   Vstupte`apt-get update && apt-get install wget curl`
    -   Pokračujte níže uvedeným popisem Linuxu


-   Pokud používáte systém Linux, jako je Ubuntu nebo Debian:
    -   Zkopírujte skript shellu (`controller.sh`) na vlastní místo a upravte proměnné podle svých potřeb.
    -   příkazy jsou`cd /path/to/save/ && wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/scripts/controller.sh && chmod +x ./controller.sh`a upravit`vi /path/to/save/controller.sh`
    -   Vytvořte crontab nebo jinou metodu plánování pro spuštění tohoto skriptu na začátku každé hodiny.
    -   Ukázka Crontabu:
          Ke spuštění řídicího skriptu každou hodinu použijte následující záznam crontab:
          Otevřete terminál a zadejte jej`crontab -e`a poté vložte následující řádek:`0 * * * * /path/to/controller.sh`

### Podpora a příspěvek

Pokud považujete tento projekt za hodnotný, zvažte prosím sponzorování a podporu dalšího rozvoje prostřednictvím těchto odkazů:

-   [Revolut](https://revolut.me/christqki2)
-   [PayPal](https://paypal.me/christian1980nrw)

Navíc, pokud jste v Německu a máte zájem přejít na dynamický tarif elektřiny, můžete projekt podpořit přihlášením pomocí tohoto[Tibber (doporučující odkaz)](https://invite.tibber.com/ojgfbx2e). Vy i projekt získáte bonus 50 eur na hardware. Vezměte prosím na vědomí, že pro hodinový tarif je vyžadován inteligentní měřič nebo Pulse-IR (<https://tibber.com/de/store/produkt/pulse-ir>) .

Pokud potřebujete tarif na zemní plyn nebo preferujete klasický tarif elektřiny, stále můžete projekt podpořit[Octopus Energy (doporučující odkaz)](https://share.octopusenergy.de/glass-raven-58).
Získáváte bonus 50 euro pro sebe a také pro projekt.
Octopus má tu výhodu, že smlouvy mají většinou pouze měsíční platnost. Jsou ideální například pro pozastavení tarifu na základě burzovních cen.

## Zřeknutí se odpovědnosti

Vezměte prosím na vědomí podmínky použití na<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/License.md>

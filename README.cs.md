<p align="center" width="100%">
    <img width="33%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/SpotmarketSwitcherLogo.png?raw=true"> 
</p>

[Čeština](README.cs.md)-[dánština](README.da.md)-[Němec](README.de.md)-[Angličtina](README.md)-[španělština](README.es.md)-[estonština](README.et.md)-[finština](README.fi.md)-[francouzština](README.fr.md)-[řecký](README.el.md)-[italština](README.it.md)-[holandský](README.nl.md)-[norský](README.no.md)-[polština](README.pl.md)-[portugalština](README.pt.md)-[švédský](README.sv.md)-[japonský](README.ja.md)

## Vítejte v úložišti Spotmarket-Switcher!

Co tento software dělá?
Spotmarket-Switcher je snadno použitelný softwarový nástroj, který vám pomůže ušetřit peníze na účtech za energii. Pokud máte chytrou nabíječku baterií nebo zařízení, jako jsou ohřívače vody, které se mohou automaticky zapínat a vypínat, je tento nástroj pro vás ideální! Chytře zapíná vaše zařízení, když jsou ceny energie nízké, zvláště užitečné, pokud se vaše náklady na energii mění každou hodinu.

Tento typický výsledek ukazuje schopnost Spotmarket-Switcheru efektivně automatizovat spotřebu energie, nejen šetřit náklady, ale také optimalizovat využití obnovitelných zdrojů energie. Je to skvělý příklad toho, jak lze chytrou technologii využít ke správě spotřeby energie udržitelnějším a nákladově efektivnějším způsobem. (modrá = použití baterie, červená = síť, žlutá = solární)

<p align="center" width="100%">
    <img width="50%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/Screenshot.jpg?raw=true"> 
</p>

-   Noční použití: Během noci, kdy byly ceny energie nejnižší, Spotmarket-Switcher chytře aktivoval přepínatelnou zásuvku pro zapnutí tepelného čerpadla pro teplou vodu (špička označená červeně). To ukazuje schopnost systému identifikovat a využívat nízkonákladová energetická období pro energeticky náročné úkoly.
-   Ekonomická efektivita při nabíjení baterií: Program se strategicky rozhodl v tuto chvíli nenabíjet úložiště baterií. Toto rozhodnutí bylo založeno na ekonomické kontrole, která zohledňovala ztráty z nabíjení a porovnávala je s průměrnými nebo nejvyššími cenami energie v daný den. Tento přístup zajišťuje, že nabíjení baterie probíhá pouze tehdy, když je to nákladově nejefektivnější.
-   Optimální využití baterie ve špičce: V tento den byly nejdražší hodiny energie ráno a večer. Během těchto období Spotmarket-Switcher využíval uloženou energii baterie (zobrazená modře), čímž se vyhnul vysokým nákladům na elektřinu.
-   Rezervace baterie pro hodiny s vysokými náklady: Po období s vysokými náklady byl systém ukládání energie (ESS) baterie vypnutý. Večer kolem 20:00 nebylo prázdno. Toto opatření bylo přijato za účelem rezervace dostatečné kapacity baterie pro nadcházející drahé hodiny příštího rána. To předvídá budoucí období s vysokými náklady a zajišťuje dostupnost akumulované energie pro kompenzaci těchto nákladů.

Proč používat Spotmarket-Switcher?

-   Ušetřete peníze: Zapne vaše zařízení, když je energie levnější, a sníží vaše účty.
-   Energeticky efektivní: Používáním energie, když je jí přebytek (jako jsou větrné noci), přispíváte k zelenější planetě.
-   Chytré využití: Automaticky nabijte své úložiště baterie nebo zapněte zařízení, jako jsou ohřívače vody, v nejlepší časy.

Aktuálně jsou podporované systémy:

-   Produkty Shelly (jako např[Shelly Plug S](https://shellyparts.de/products/shelly-plus-plug-s)nebo[Shelly Plus](https://shellyparts.de/products/shelly-plus-1pm))
-   [AVMFritz!DECT200](https://avm.de/produkte/smart-home/fritzdect-200/)a[210](https://avm.de/produkte/smart-home/fritzdect-210/)vypínatelné zásuvky
-   [Victron](https://www.victronenergy.com/)Systémy ukládání energie Venus OS, jako je např[Řada MultiPlus-II](https://www.victronenergy.com/inverters-chargers)

Začínáme:

-   Stáhnout a nainstalovat: Proces instalace je přímočarý. Stáhněte si skript, upravte pár nastavení a můžete začít.
-   Plán a relax: Nastavte to jednou a spustí se automaticky. Žádné každodenní starosti!

Zájem?

-   Podívejte se na naše podrobné pokyny pro různé systémy, jako je nastavení Victron Venus OS, Windows nebo Linux. Ujistili jsme se, že kroky lze snadno sledovat.
-   Přidejte se k nám a snažte se využívat energii chytřeji a efektivněji! V případě jakýchkoli dotazů, návrhů nebo zpětné vazby se neváhejte obrátit.

Kód je jednoduchý, takže jej lze snadno přizpůsobit jiným systémům skladování energie, pokud jste schopni ovládat nabíjení pomocí příkazů shellu Linux.
Podívejte se prosím na controller.sh a vyhledejte charger_command_turnon, abyste viděli, jak snadno se dá přizpůsobit.
Vytvořte prosím github fork a sdílejte své přizpůsobení, aby z něj mohli těžit ostatní uživatelé.

## Zdroj dat

Software v současné době využívá hodinové ceny EPEX Spot poskytované třemi bezplatnými API (Tibber, aWATTar & Entso-E).
Integrované bezplatné Entso-E API poskytuje údaje o cenách energie v následujících zemích:
Albánie (AL), Rakousko (AT), Belgie (BE), Bosna a Herc. (BA), Bulharsko (BG), Chorvatsko (HR), Kypr (CY), Česká republika (CZ), Dánsko (DK), Estonsko (EE), Finsko (FI), Francie (FR), Gruzie (GE), Německo (DE), Řecko (GR), Maďarsko (HU), Irsko (IE), Itálie (IT), Kosovo (XK), Lotyšsko (LV), Litva (LT), Lucembursko (LU), Malta (MT), Moldavsko (MD), Černá Hora (ME), Nizozemsko (NL), Severní Makedonie (MK), Norsko (NO), Polsko (PL), Portugalsko (PT), Rumunsko (RO), Srbsko (RS), Slovensko (SK) , Slovinsko (SI), Španělsko (ES), Švédsko (SE), Švýcarsko (CH), Turecko (TR), Ukrajina (UA), Spojené království (UK) viz.[Transparentnost Platforma Entso-E](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![Screenshot 2023-12-15 221401](https://github.com/christian1980nrw/Spotmarket-Switcher/assets/6513794/25992602-b0a2-48ff-bd4c-64a6f8182297)

## Instalace

Nastavení Spotmarket-Switcheru je jednoduchý proces. Pokud již používáte počítač se systémem UNIX, jako je macOS, Linux nebo Windows se subsystémem Linux, nainstalujte software podle následujících kroků:

1.  Download the install script from the GitHub repository by using [tento hypertextový odkaz](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh)nebo ve svém terminálu spusťte následující příkaz:
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  Spusťte instalační skript s dalšími možnostmi, abyste připravili vše v podadresáři pro vaši kontrolu. Například:
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    Pokud používáte Victron Venus OS, měl by být správný DESTDIR`/`(kořenový adresář). Neváhejte prozkoumat nainstalované soubory v`/tmp/foo`.
    Na Cerbo GX je souborový systém připojen pouze pro čtení. Vidět<https://www.victronenergy.com/live/ccgx:root_access>. Aby bylo možné do souborového systému zapisovat, musíte před spuštěním instalačního skriptu provést následující příkaz:
        /opt/victronenergy/swupdate-scripts/resize2fs.sh

Vezměte prosím na vědomí, že i když je tento software v současné době optimalizován pro OS Venus, lze jej přizpůsobit jiným variantám Linuxu, jako je Debian/Ubuntu na Raspberry Pi nebo jiné malé desce. Hlavním kandidátem určitě je[OpenWRT](https://www.openwrt.org). Používání stolního počítače je vhodné pro testovací účely, ale při nepřetržitém používání je jeho větší spotřeba energie znepokojivá.

### Přístup k OS Venus

Pokyny pro přístup k OS Venus najdete na<https://www.victronenergy.com/live/ccgx:root_access>.

### Spuštění instalačního skriptu

-   Pokud používáte Victron Venus OS:
    -   Poté proměnné upravte pomocí textového editoru`/data/etc/Spotmarket-Switcher/config.txt`.
    -   Nastavte plán nabíjení ESS (viz dodaný snímek obrazovky). V tomto příkladu se baterie nabíjí v noci až na 50 %, pokud je aktivována, ostatní doby nabíjení během dne jsou ignorovány. Pokud nechcete, vytvořte plán na všech 24 hodin dne. Nezapomeňte jej po vytvoření deaktivovat. Ověřte, že systémový čas (jak je zobrazen v pravém horním rohu obrazovky) je přesný.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

Snímek obrazovky ukazuje konfiguraci automatického nabíjení během uživatelem definovaných časů. Ve výchozím nastavení deaktivováno, může být dočasně aktivováno skriptem.

-   Pokyny k instalaci Spotmarket-Switcher na systém Windows 10 nebo 11 pro testování bez zařízení Victron (pouze přepínatelné zásuvky).

    -   zahájení`cmd.exe`jako správce
    -   Vstupte`wsl --install -d Debian`
    -   Zadejte nové uživatelské jméno jako`admin`
    -   vložte nové heslo
    -   Vstupte`sudo su`a zadejte své heslo
    -   Vstupte`apt-get update && apt-get install wget curl`
    -   Pokračujte níže uvedeným manuálem pro Linux (instalační skript není kompatibilní).
    -   Nezapomeňte, že pokud zavřete shell, Windows zastaví systém.


-   Pokud používáte systém Linux, jako je Ubuntu nebo Debian:
    -   Zkopírujte skript shellu (`controller.sh`) na vlastní místo a upravte proměnné podle svých potřeb.
    -   příkazy jsou`cd /path/to/save/ && curl -s -O "https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/scripts/{controller.sh,sample.config.txt,license.txt}" && chmod +x ./controller.sh && mv sample.config.txt config.txt`a k úpravě nastavení použijte`vi /path/to/save/config.txt`
    -   Vytvořte crontab nebo jinou metodu plánování pro spuštění tohoto skriptu na začátku každé hodiny.
    -   Ukázka Crontabu:
          Ke spuštění řídicího skriptu každou hodinu použijte následující záznam crontab:
          Otevřete terminál a zadejte jej`crontab -e`a poté vložte následující řádek:`0 * * * * /path/to/controller.sh`

### Podpora a příspěvek :+1:

Pokud považujete tento projekt za hodnotný, zvažte prosím sponzorování a podporu dalšího rozvoje prostřednictvím těchto odkazů:

-   [Revolut](https://revolut.me/christqki2)
-   [PayPal](https://paypal.me/christian1980nrw)

Pokud jste z Německa a máte zájem přejít na dynamický tarif elektřiny, můžete projekt podpořit přihlášením pomocí tohoto[Tibber (doporučující odkaz)](https://invite.tibber.com/ojgfbx2e)nebo zadáním kódu`ojgfbx2e`ve vaší aplikaci. Obdržíte vy i projekt**Bonus 50 euro na hardware**. Vezměte prosím na vědomí, že pro hodinový tarif je vyžadován inteligentní měřič nebo Pulse-IR (<https://tibber.com/de/store/produkt/pulse-ir>).
Pokud potřebujete tarif na zemní plyn nebo preferujete klasický tarif elektřiny, stále můžete projekt podpořit[Octopus Energy (doporučující odkaz)](https://share.octopusenergy.de/glass-raven-58).
Získáte bonus (nabídka se liší**mezi 50 a 120 eury**) pro sebe a také pro projekt.
Octopus má tu výhodu, že některé nabídky jsou bez minimální smluvní doby. Jsou ideální například pro pozastavení tarifu na základě burzovních cen.

Pokud jste z Rakouska, můžete nás podpořit pomocí[aWATTar Rakousko (doporučující odkaz)](https://www.awattar.at/services/offers/promotecustomers). Využijte prosím`3KEHMQN2F`jako kód.

## Zřeknutí se odpovědnosti

Vezměte prosím na vědomí podmínky použití na<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/License.md>

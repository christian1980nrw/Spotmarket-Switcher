<p align="center" width="100%">
    <img width="33%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/SpotmarketSwitcherLogo.png?raw=true"> 
</p>

[tchèque](README.cs.md)-[danois](README.da.md)-[Allemand](README.de.md)-[Anglais](README.md)-[Espagnol](README.es.md)-[estonien](README.et.md)-[finlandais](README.fi.md)-[Français](README.fr.md)-[grec](README.el.md)-[italien](README.it.md)-[Néerlandais](README.nl.md)-[norvégien](README.no.md)-[polonais](README.pl.md)-[Portugais](README.pt.md)-[suédois](README.sv.md)-[Japonais](README.ja.md)

## Bienvenue dans le référentiel Spotmarket-Switcher !

Que fait ce logiciel ?
Il s'agit d'un script shell Linux qui allume votre chargeur de batterie et/ou vos prises commutables au bon moment si vos prix horaires d'énergie dynamiques sont bas.
Vous pouvez ensuite utiliser les prises pour allumer un ballon d'eau chaude à moindre coût ou charger automatiquement la batterie la nuit lorsque de l'énergie éolienne bon marché est disponible sur le réseau.
Le rendement solaire attendu peut être pris en compte via une API météo et un stockage sur batterie réservé en conséquence.
Les systèmes pris en charge sont actuellement :

-   Produits Shelly (tels que[Prise Shelly S](https://shellyparts.de/products/shelly-plus-plug-s)ou[Shelly Plus](https://shellyparts.de/products/shelly-plus-1pm))
-   [AVMFritz!DECT200](https://avm.de/produkte/smart-home/fritzdect-200/)et[210](https://avm.de/produkte/smart-home/fritzdect-210/)prises commutables
-   [Victron](https://www.victronenergy.com/)Systèmes de stockage d'énergie Venus OS comme le[Série MultiPlus-II](https://www.victronenergy.com/inverters-chargers)

Le code est simple et peut facilement être adapté à d'autres systèmes de stockage d'énergie si vous êtes capable de contrôler la charge à l'aide de commandes shell Linux.
Veuillez jeter un œil sous la ligne 100 du fichier controller.sh afin de voir ce qui peut être configuré par l'utilisateur.

## La source de données

Le logiciel utilise actuellement les prix horaires EPEX Spot fournis par trois API gratuites (Tibber, aWATTar et Entso-E).
L'API Entso-E gratuite intégrée fournit des données sur les prix de l'énergie des pays suivants :
Albanie (AL), Autriche (AT), Belgique (BE), Bosnie-Herzégovine. (BA), Bulgarie (BG), Croatie (HR), Chypre (CY), République tchèque (CZ), Danemark (DK), Estonie (EE), Finlande (FI), France (FR), Géorgie (GE), Allemagne (DE), Grèce (GR), Hongrie (HU), Irlande (IE), Italie (IT), Kosovo (XK), Lettonie (LV), Lituanie (LT), Luxembourg (LU), Malte (MT), Moldavie (MD), Monténégro (ME), Pays-Bas (NL), Macédoine du Nord (MK), Norvège (NO), Pologne (PL), Portugal (PT), Roumanie (RO), Serbie (RS), Slovaquie (SK) , Slovénie (SI), Espagne (ES), Suède (SE), Suisse (CH), Turquie (TR), Ukraine (UA), Royaume-Uni (UK) voir[Plateforme Transparence Entso-E](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![grafik](https://user-images.githubusercontent.com/6513794/224442951-c0155a48-f32b-43f4-8014-d86d60c3b311.png)

## Installation

La configuration de Spotmarket-Switcher est un processus simple. Si vous exécutez déjà une machine UNIX, telle que macOS, Linux ou Windows avec le sous-système Linux, suivez ces étapes pour installer le logiciel :

1.  Téléchargez le script d'installation depuis le référentiel GitHub en utilisant[cet hyperlien](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh), ou exécutez la commande suivante dans votre terminal :
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  Exécutez le script d'installation avec des options supplémentaires pour préparer tout ce qui se trouve dans un sous-répertoire pour votre inspection. Par exemple:
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    Si vous utilisez Victron Venus OS, le DESTDIR correct devrait être`/`(le répertoire racine). N'hésitez pas à explorer les fichiers installés dans`/tmp/foo`.
    Sur un Cerbo GX, le système de fichiers est monté en lecture seule. Voir<https://www.victronenergy.com/live/ccgx:root_access>. Afin de rendre le système de fichiers accessible en écriture, vous devez exécuter la commande suivante avant d'exécuter le script d'installation :
        /opt/victronenergy/swupdate-scripts/resize2fs.sh

Veuillez noter que même si ce logiciel est actuellement optimisé pour le système d'exploitation Venus, il peut être adapté à d'autres versions de Linux, comme Debian/Ubuntu sur un Raspberry Pi ou une autre petite carte. Un candidat de choix est certainement[OuvrirWRT](https://www.openwrt.org). L'utilisation d'un ordinateur de bureau convient parfaitement à des fins de test, mais lorsqu'elle est utilisée 24 heures sur 24 et 7 jours sur 7, sa consommation d'énergie plus importante est préoccupante.

### Accès au système d'exploitation Venus

Pour obtenir des instructions sur l'accès au système d'exploitation Venus, veuillez vous référer à<https://www.victronenergy.com/live/ccgx:root_access>.

### Exécution du script d'installation

-   Si vous utilisez le système d'exploitation Victron Venus :
    -   Modifiez ensuite les variables avec un éditeur de texte dans`/data/etc/Spotmarket-Switcher/config.txt`.
    -   Configurez un calendrier de charge ESS (reportez-vous à la capture d'écran fournie). Dans l'exemple, la batterie se charge la nuit jusqu'à 50 % si elle est activée, les autres moments de charge de la journée sont ignorés. Si vous ne le souhaitez pas, créez un horaire pour les 24 heures de la journée. Pensez à le désactiver après la création. Vérifiez que l'heure du système (telle qu'elle apparaît en haut à droite de l'écran) est exacte.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

La capture d'écran montre la configuration de la recharge automatisée pendant les heures définies par l'utilisateur. Désactivé par défaut, peut être temporairement activé par le script.

-   Instructions pour installer le Spotmarket-Switcher sur un système Windows 10 ou 11 pour des tests sans appareils Victron (uniquement prises commutables).

    -   lancement`cmd.exe`en tant qu'administrateur
    -   Entrer`wsl --install -d Debian`
    -   Entrez un nouveau nom d'utilisateur comme`admin`
    -   entrer un nouveau mot de passe
    -   Entrer`sudo su`et tapez votre mot de passe
    -   Entrer`apt-get update && apt-get install wget curl`
    -   Continuez avec la description manuelle de Linux ci-dessous (le script d'installation n'est pas compatible).
    -   N'oubliez pas que si vous fermez le shell, Windows arrêtera le système.


-   Si vous utilisez un système Linux comme Ubuntu ou Debian :
    -   Copiez le script shell (`controller.sh`) vers un emplacement personnalisé et ajustez les variables en fonction de vos besoins.
    -   les commandes sont`cd /path/to/save/ &&  curl -s -O "https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/scripts/{controller.sh,sample.config.txt}" && mv sample.config.txt config.txt && chmod +x ./controller.sh`et pour éditer`vi /path/to/save/config.txt`
    -   Créez une crontab ou une autre méthode de planification pour exécuter ce script au début de chaque heure.
    -   Exemple de Crontab :
          Utilisez l'entrée crontab suivante pour exécuter le script de contrôle toutes les heures :
          Ouvrez votre terminal et entrez`crontab -e`, puis insérez la ligne suivante :`0 * * * * /path/to/controller.sh`

### Soutien et contribution :+1 :

Si vous trouvez ce projet utile, veuillez envisager de le parrainer et de soutenir son développement ultérieur via ces liens :

-   [Révolution](https://revolut.me/christqki2)
-   [Pay Pal](https://paypal.me/christian1980nrw)

Si vous résidez en Allemagne et souhaitez passer à un tarif d'électricité dynamique, vous pouvez soutenir le projet en vous inscrivant via ce lien.[Tibber (lien de parrainage)](https://invite.tibber.com/ojgfbx2e)ou en saisissant le code`ojgfbx2e`dans votre application. Vous et le projet recevrez**50 euros de bonus pour le matériel**. Veuillez noter qu'un compteur intelligent ou un Pulse-IR est requis pour un tarif horaire (<https://tibber.com/de/store/produkt/pulse-ir>) .
Si vous avez besoin d'un tarif de gaz naturel ou préférez un tarif d'électricité classique, vous pouvez toujours soutenir le projet[Octopus Energy (lien de parrainage)](https://share.octopusenergy.de/glass-raven-58).
Vous recevez un bonus (l'offre varie**entre 50 et 120 euros**) pour vous-même et aussi pour le projet.
Octopus a l'avantage que certaines offres sont sans durée minimale de contrat. Ils sont idéaux, par exemple, pour suspendre un tarif basé sur les cours boursiers.

Si vous venez d'Autriche, vous pouvez nous soutenir[aWATTar Autriche (lien de référence)](https://www.awattar.at/services/offers/promotecustomers)en utilisant`3KEHMQN2F`comme code.

## Clause de non-responsabilité

Veuillez noter les conditions d'utilisation sur<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/License.md>

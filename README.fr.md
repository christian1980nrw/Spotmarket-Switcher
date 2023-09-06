# Référentiel Spotmarket-Switcher

## Traduction du fichier README

-   [Anglais](README.md)
-   [Allemand](README.de.md)
-   [Français](README.fr.md)
-   [Espagnol](README.es.md)
-   [suédois](README.sv.md)
-   [norvégien](README.no.md)
-   [danois](README.da.md)

Bienvenue dans le référentiel Spotmarket-Switcher ! Ce logiciel est conçu pour améliorer les fonctionnalités de votre configuration énergétique en intégrant :

-   [Victron](https://www.victronenergy.com/)Systèmes de stockage d'énergie Venus OS
-   Produits Shelly (tels que Shelly Plug S ou Shelly Plus1PM)
-   AVM Fritz!DECT200 et 210 prises commutables

L'objectif principal de ce logiciel est de permettre à votre système de réagir aux prix de l'électricité du marché au comptant, lui permettant ainsi de prendre des décisions intelligentes telles que le chargement de la batterie et l'activation de l'alimentation en fonction de périodes de bas prix. Le rendement solaire attendu peut être pris en compte via une API météo et un stockage sur batterie réservé en conséquence.

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

Veuillez noter que même si ce logiciel est actuellement optimisé pour le système d'exploitation Venus, il peut être adapté à d'autres configurations, telles que le contrôle d'appareils domestiques via des commutateurs IP. Un développement futur pourrait améliorer la compatibilité avec d’autres systèmes.

### Accès au système d'exploitation Venus

Pour obtenir des instructions sur l'accès au système d'exploitation Venus, veuillez vous référer à<https://www.victronenergy.com/live/ccgx:root_access>.

### Exécution du script d'installation

-   Si vous utilisez le système d'exploitation Victron Venus :
    -   Exécuter`victron-venus-os-install.sh`pour télécharger et installer Spotmarket-Switcher.
    -   Modifiez les variables avec un éditeur de texte dans`/data/etc/Spotmarket-Switcher/controller.sh`.
    -   Configurez un calendrier de charge ESS (reportez-vous à la capture d'écran fournie). Dans l'exemple, la batterie se charge la nuit jusqu'à 50 % si elle est activée. Pensez à le désactiver après la création. Vérifiez que l'heure du système (comme indiqué dans la capture d'écran) est exacte.![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

-   Si vous utilisez un autre système d'exploitation :
    -   Copiez le script shell (`controller.sh`) vers un emplacement personnalisé et ajustez les variables en fonction de vos besoins.
    -   Créez une crontab ou une autre méthode de planification pour exécuter ce script au début de chaque heure.
    -   Exemple de Crontab :
          Utilisez l'entrée crontab suivante pour exécuter le script de contrôle toutes les heures :
          Ouvrez votre terminal et entrez`crontab -e`, puis insérez la ligne suivante :
            0 * * * * /path/to/controller.sh

### Soutien et contribution

Si vous trouvez ce projet utile, veuillez envisager de le parrainer et de soutenir son développement ultérieur via ces liens :

-   [Révolution](https://revolut.me/christqki2)
-   [Pay Pal](https://paypal.me/christian1980nrw)

De plus, si vous résidez en Allemagne et souhaitez passer à un tarif d'électricité dynamique, vous pouvez soutenir le projet en vous inscrivant via ce lien.[Tibber (lien de parrainage)](https://invite.tibber.com/ojgfbx2e). Vous et le projet recevrez un bonus de 50 euros pour le matériel. Veuillez noter qu'un compteur intelligent ou un Pulse-IR est requis pour un tarif horaire (<https://tibber.com/de/store/produkt/pulse-ir>) .

Si vous avez besoin d'un tarif de gaz naturel ou préférez un tarif d'électricité classique, vous pouvez toujours soutenir le projet[Octopus Energy (lien de parrainage)](https://share.octopusenergy.de/glass-raven-58).
Vous recevez un bonus de 50 euros pour vous et aussi pour le projet.
Octopus présente l'avantage que les contrats n'ont généralement qu'une durée mensuelle. Ils sont idéaux, par exemple, pour suspendre un tarif basé sur les cours boursiers.

## Clause de non-responsabilité

Veuillez noter les conditions d'utilisation sur<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/dev/License.md>

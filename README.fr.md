<p align="center" width="100%">
    <img width="33%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/SpotmarketSwitcherLogo.png?raw=true"> 
</p>

[tchèque](README.cs.md)-[danois](README.da.md)-[Allemand](README.de.md)-[Anglais](README.md)-[Espagnol](README.es.md)-[estonien](README.et.md)-[finlandais](README.fi.md)-[Français](README.fr.md)-[grec](README.el.md)-[italien](README.it.md)-[Néerlandais](README.nl.md)-[norvégien](README.no.md)-[polonais](README.pl.md)-[Portugais](README.pt.md)-[suédois](README.sv.md)-[Japonais](README.ja.md)

## Bienvenue dans le référentiel Spotmarket-Switcher !

Que fait ce logiciel ?
Spotmarket-Switcher est un outil logiciel facile à utiliser qui vous aide à économiser de l'argent sur vos factures d'énergie. Si vous disposez d'un chargeur de batterie intelligent ou d'appareils comme des chauffe-eau qui peuvent s'allumer et s'éteindre automatiquement, cet outil est parfait pour vous ! Il allume intelligemment vos appareils lorsque les prix de l'énergie sont bas, ce qui est particulièrement utile si vos coûts énergétiques changent toutes les heures.

Ce résultat typique met en valeur la capacité du Spotmarket-Switcher à automatiser efficacement la consommation d'énergie, non seulement en réduisant les coûts, mais également en optimisant l'utilisation des sources d'énergie renouvelables. C'est un excellent exemple de la façon dont la technologie intelligente peut être utilisée pour gérer la consommation d'énergie de manière plus durable et plus rentable. (bleu = utilisation de la batterie, rouge = réseau, jaune = solaire)

<p align="center" width="100%">
    <img width="50%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/Screenshot.jpg?raw=true"> 
</p>

-   Utilisation nocturne : Pendant la nuit, lorsque les prix de l'énergie étaient au plus bas, le Spotmarket-Switcher a intelligemment activé une prise commutable pour alimenter la pompe à chaleur à eau chaude (pic indiqué en rouge). Cela montre la capacité du système à identifier et à utiliser les périodes d'énergie à faible coût pour des tâches à forte intensité énergétique.
-   Efficacité économique du chargement des batteries : Le programme a stratégiquement décidé de ne pas charger les batteries de stockage pour le moment. Cette décision était basée sur un contrôle économique qui prenait en compte les pertes de charge et les comparait aux prix énergétiques moyens ou les plus élevés du moment. Cette approche garantit que la recharge de la batterie n'a lieu que lorsque cela est le plus rentable.
-   Utilisation optimale de la batterie pendant les heures de pointe : à ce jour, les heures les plus coûteuses en énergie étaient le matin et le soir. Pendant ces périodes, le Spotmarket-Switcher a utilisé l'énergie stockée dans la batterie (indiquée en bleu), évitant ainsi des coûts d'électricité élevés. Il s'agit d'une stratégie intelligente pour réduire les dépenses énergétiques en utilisant l'énergie stockée alors qu'il est plus coûteux de puiser sur le réseau.
-   Réservation de la batterie pour les heures à coût élevé : après les périodes à coût élevé, le système de stockage d'énergie (ESS) de la batterie a été désactivé. Il n'était pas vide le soir vers 20h00. Cette mesure a été prise pour réserver une capacité de batterie suffisante pour les heures coûteuses à venir du lendemain matin. Il s'agit d'une approche avant-gardiste qui anticipe les futures périodes de coûts élevés et garantit que l'énergie stockée est disponible pour compenser ces coûts.

Pourquoi utiliser Spotmarket-Switcher ?

-   Économisez de l'argent : il allume vos appareils lorsque l'énergie est moins chère, réduisant ainsi vos factures.
-   Efficacité énergétique : en utilisant l'énergie lorsqu'elle est excédentaire (comme les nuits venteuses), vous contribuez à une planète plus verte.
-   Utilisation intelligente : chargez automatiquement votre batterie de stockage ou allumez des appareils comme des chauffe-eau aux meilleurs moments.

Les systèmes pris en charge sont actuellement :

-   Produits Shelly (tels que[Prise Shelly S](https://shellyparts.de/products/shelly-plus-plug-s)ou[Shelly Plus](https://shellyparts.de/products/shelly-plus-1pm))
-   [AVMFritz!DECT200](https://avm.de/produkte/smart-home/fritzdect-200/)et[210](https://avm.de/produkte/smart-home/fritzdect-210/)prises commutables
-   [Victron](https://www.victronenergy.com/)Systèmes de stockage d'énergie Venus OS comme le[Série MultiPlus-II](https://www.victronenergy.com/inverters-chargers)

Commencer:

-   Télécharger et installer : Le processus d’installation est simple. Téléchargez le script, ajustez quelques paramètres et vous êtes prêt à partir.
-   Planifiez et détendez-vous : configurez-le une fois et il s'exécute automatiquement. Pas de tracas au quotidien !

Intéressé?

-   Consultez nos instructions détaillées pour différents systèmes tels que les configurations Victron Venus OS, Windows ou Linux. Nous nous sommes assurés que les étapes sont faciles à suivre.
-   Rejoignez-nous pour rendre la consommation d’énergie plus intelligente et plus rentable ! Pour toute question, suggestion ou commentaire, n'hésitez pas à nous contacter.

Le code est simple et peut facilement être adapté à d'autres systèmes de stockage d'énergie si vous êtes capable de contrôler la charge à l'aide de commandes shell Linux.
Veuillez jeter un œil au contrôleur.sh et recherchez charger_command_turnon afin de voir à quel point il peut être facilement adapté.
Veuillez créer un fork github et partager votre personnalisation afin que d'autres utilisateurs puissent en bénéficier.

## La source de données

Le logiciel utilise actuellement les prix horaires EPEX Spot fournis par trois API gratuites (Tibber, aWATTar et Entso-E).
L'API Entso-E gratuite intégrée fournit des données sur les prix de l'énergie des pays suivants :
Albanie (AL), Autriche (AT), Belgique (BE), Bosnie-Herzégovine. (BA), Bulgarie (BG), Croatie (HR), Chypre (CY), République tchèque (CZ), Danemark (DK), Estonie (EE), Finlande (FI), France (FR), Géorgie (GE), Allemagne (DE), Grèce (GR), Hongrie (HU), Irlande (IE), Italie (IT), Kosovo (XK), Lettonie (LV), Lituanie (LT), Luxembourg (LU), Malte (MT), Moldavie (MD), Monténégro (ME), Pays-Bas (NL), Macédoine du Nord (MK), Norvège (NO), Pologne (PL), Portugal (PT), Roumanie (RO), Serbie (RS), Slovaquie (SK) , Slovénie (SI), Espagne (ES), Suède (SE), Suisse (CH), Turquie (TR), Ukraine (UA), Royaume-Uni (UK) voir[Plateforme Transparence Entso-E](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show).

![Screenshot 2023-12-15 221401](https://github.com/christian1980nrw/Spotmarket-Switcher/assets/6513794/25992602-b0a2-48ff-bd4c-64a6f8182297)

## Installation

La configuration de Spotmarket-Switcher est un processus simple. Si vous exécutez déjà une machine UNIX, telle que macOS, Linux ou Windows avec le sous-système Linux, suivez ces étapes pour installer le logiciel :

1.  Téléchargez le script d'installation depuis le référentiel GitHub en utilisant[cet hyperlien](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh), ou exécutez la commande suivante dans votre terminal :
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  Exécutez le script d'installation avec des options supplémentaires pour préparer tout ce qui se trouve dans un sous-répertoire pour votre inspection. Par exemple:
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    Si vous utilisez Victron Venus OS, le DESTDIR correct devrait être`/`(le répertoire racine). N'hésitez pas à explorer les fichiers installés dans`/tmp/foo`.
    Sur un Cerbo GX, le système de fichiers est monté en lecture seule. Voir<https://www.victronenergy.com/live/ccgx:root_access>. Afin de rendre le système de fichiers accessible en écriture, vous devez exécuter la commande suivante avant d'exécuter le script d'installation :
        /opt/victronenergy/swupdate-scripts/resize2fs.sh

Veuillez noter que même si ce logiciel est actuellement optimisé pour le système d'exploitation Venus, il peut être adapté à d'autres versions de Linux, comme Debian/Ubuntu sur un Raspberry Pi ou une autre petite carte. Un candidat de choix est certainement[OuvrirWRT](https://www.openwrt.org). L'utilisation d'un ordinateur de bureau convient à des fins de test, mais lorsqu'elle est utilisée 24 heures sur 24 et 7 jours sur 7, sa consommation d'énergie plus importante est préoccupante.

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
    -   les commandes sont`cd /path/to/save/ && curl -s -O "https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/scripts/{controller.sh,sample.config.txt,license.txt}" && chmod +x ./controller.sh && mv sample.config.txt config.txt`et pour modifier vos paramètres, utilisez`vi /path/to/save/config.txt`
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

Si vous résidez en Autriche, vous pouvez nous soutenir en utilisant[aWATTar Autriche (lien de référence)](https://www.awattar.at/services/offers/promotecustomers). Veuillez utiliser`3KEHMQN2F`comme code.

## Clause de non-responsabilité

Veuillez noter les conditions d'utilisation sur<https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/License.md>

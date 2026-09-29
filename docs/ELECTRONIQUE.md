# Électronique : état du projet

Matériel déclaré : carte ESP32 sous FluidNC, broche alimentée en 24 V, module double BTS7960 envisagé pour l'inversion d'un moteur DC à balais. La référence exacte du moteur, son courant et le brochage de la carte restent à confirmer.

La fiche Infineon indique une plage de fonctionnement de 5,5 à 27,5 V pour le BTS7960. Le 24 V déclaré est dans cette plage ; cela ne valide pas à lui seul le module complet, son refroidissement, les transitoires ou l'adéquation au moteur. Le « 43 A » commercial n'est pas une garantie de courant continu pour la carte vendue.

## Informations manquantes

- `config.yaml` FluidNC actuel et version installée.
- Référence/schéma de la carte et sorties logiques réellement disponibles.
- Brochage du module BTS7960 acheté et caractéristiques de ses entrées.
- Référence du moteur, courant de démarrage/blocage et aptitude au fonctionnement inverse.
- Palpeur de longueur, détection de présence et arrêt du cycle en cas d'échec.

Aucun GPIO, câblage fil à fil, fichier de configuration ou G-code n'est inventé dans ce dépôt. Ne pas brancher la sortie de puissance « SPINDLE » sur une entrée logique du BTS7960. La logique d'inversion doit prévoir l'arrêt avant changement de sens.

La compatibilité électrique ne valide pas le serrage mécanique. Le mécanisme de logement sur ressort ne fournit pas, seul, un contrôle de couple.

## Sources

- [Infineon BTS7960](https://www.infineon.com/assets/row/public/documents/10/57/infineon-bts7960-ds-en.pdf)
- [FluidNC](https://github.com/bdring/FluidNC)
- [RapidChange, exigences du magasin linéaire](https://rapidchangeatc.com/shop/automatic-tool-changer/linear-magazines/)

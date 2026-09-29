# Impression et montage

## Nomenclature

| Pièce | Quantité | Fichier ou état |
|---|---:|---|
| Corps | 1 | `stl/bloc.stl` |
| Couvercle | 1 | `stl/plaque.stl` |
| Fond avec tubes de guidage | 1 | `stl/fond.stl` |
| Douille | 4 | `stl/douille.stl` |
| Ressort de compression | 4 | À sélectionner, voir CONCEPTION.md |
| Vis M5, écrous, rondelles | 4 jeux | Passage Ø5,5, longueur de serrage 63 mm hors quincaillerie/support |
| Fixation machine | Selon montage | À adapter au plateau réel |

Les vis traversantes solidarisent les trois niveaux. Leur longueur exacte dépend des rondelles, écrous et de la fixation machine. Elles ne sont pas représentées dans le source.

## Impression

Commencer par les calibres dans `calibres/`. Choisir l'ouverture qui entre sans forcer, puis reporter le jeu dans le source. Si la partie ronde de l'écrou bloque l'insertion, modifier son profil après mesure, pas seulement le jeu.

Pour les premiers essais dimensionnels : couche 0,2 mm, 4 à 6 périmètres, ajuster selon imprimante et matériau. Cela ne constitue pas une spécification de résistance au serrage.

- Douilles : collerette à plat sur le plateau.
- Fond : plaque à plat, tubes vers le haut.
- Couvercle : face inférieure à plat.
- Bloc : face inférieure à plat ; vérifier le surplomb interne de 2,8 mm sous le guide, ajouter des supports locaux si nécessaire et les retirer complètement.

Les jeux sont des hypothèses : contrôler le coulissement sur une douille avant d'imprimer tout l'ensemble.

## Montage hors tension

1. Introduire les douilles par le dessous du corps : les collerettes ne passent pas à travers le guide supérieur.
2. Aligner les ergots dans les rainures internes.
3. Placer les ressorts choisis autour des tubes du fond.
4. Positionner le fond et fermer le dessus par le couvercle.
5. Monter les quatre vis traversantes avec écrous et rondelles, sans déformer le bloc.
6. Vérifier manuellement le retour contre le couvercle et la course jusqu'aux butées du fond.
7. Approcher l'écrou hors tension, contrôler le passage et le dégagement de la broche.

Soutenir le fond au démontage : les mêmes vis maintiennent l'ensemble. Les ressorts sont préchargés une fois montés. Aucun outil coupant n'est nécessaire pour le premier essai de mouvement.

## Vérifications avant toute évolution

Les douilles ne doivent pas dépasser le dessous du couvercle au repos. Les ergots doivent rester engagés pendant toute la course. Contrôler que le ressort n'arrive pas à spires jointives avant la butée.

Le trou central n'assure aucune retenue d'une fraise desserrée. Prévoir une solution dédiée avant un essai automatique. Le prototype actuel doit rester en essais manuels ; il ne fournit aucune validation du couple de serrage.

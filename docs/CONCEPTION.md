# Conception mécanique V3

## Fonctionnement

Le ressort pousse la douille contre le dessous du couvercle. L'ouverture du couvercle est plus petite que le diamètre extérieur de la douille et plus grande que l'écrou à engager. L'ergot coulisse dans une rainure interne : il bloque la rotation et autorise la translation verticale.

Le tube creux du fond centre le ressort, laisse passer la fraise et arrête la collerette après 4 mm de descente. La grande chambre inférieure permet l'insertion de la collerette par-dessous. Le guide supérieur est ajusté sur le corps de la douille.

Ce montage élastique traite une partie du problème d'engagement, mais **ne définit pas le mécanisme d'impact ni le contrôle du couple**. Ne pas assimiler le logement hexagonal fixe à une douille RapidChange fonctionnelle.

## Positions verticales

Origine Z au-dessous du fond :

| Élément | Au repos | À course maximale |
|---|---:|---:|
| Dessus du fond | 6 mm | 6 mm |
| Dessous de la collerette | 37 mm | 33 mm |
| Dessus de la collerette | 40 mm | 36 mm |
| Dessus de la douille | 60 mm | 56 mm |
| Dessous du couvercle | 60 mm | 60 mm |
| Dessus du couvercle | 63 mm | 63 mm |

Le changement de diamètre du guide est à Z=40,5 mm : 0,5 mm de jeu évite de faire de la collerette la butée haute. Le couvercle retient directement la face supérieure des douilles. La fraise peut dépasser sous le fond : prévoir une zone libre.

## Paramètres principaux

```scad
ecrou_plats = 17;
ecrou_hauteur = 13;
jeu_ecrou = 0.4;             // total sur plats
passage_ecrou = 22;          // à confirmer par mesure
passage_outil = 10;          // à adapter à la fraise
course = 4;
diam_douille = 28;
jeu_guidage = 0.4;           // jeu diamétral total
hauteur_douille = 23;
diam_collerette = 32;
ep_couvercle = 3;
```

L'écrou photographié comporte des zones cylindriques. Mesurer son diamètre maximal et la hauteur réelle des méplats avant de considérer l'empreinte hexagonale comme adaptée. Le diamètre de 19,5 mm indiqué dans une proposition de code n'a pas été confirmé par une mesure.

L'ouverture du couvercle est évasée à Ø23,6 mm sur les derniers 0,8 mm. Elle conserve Ø22 mm dans sa partie droite. La prise commence 3 mm sous la surface au repos et 7 mm en bas de course. Contrôler le nez de broche et la longueur réellement engagée : la hauteur de l'écrou seule ne garantit pas l'accès.

## Ressorts : réservation géométrique uniquement

| Paramètre proposé | Valeur |
|---|---:|
| Diamètre extérieur | 22 mm |
| Diamètre du fil | 2 mm |
| Diamètre intérieur calculé | 18 mm |
| Longueur libre | 33 mm |
| Longueur installée | 31 mm |
| Longueur en butée basse | 27 mm |
| Précompression | 2 mm |

Ce n'est pas une référence à acheter. La raideur `k` n'est pas choisie : pour un ressort linéaire, l'effort serait `2k` N au repos et `6k` N en butée, avec `k` en N/mm. Définir l'effort admissible avant sélection. Vérifier aussi longueur à spires jointives, guidage, fatigue et tolérances.

## Points restant à développer

- Maintien de la fraise lorsque la pince est desserrée.
- Engagement reproductible du filetage et de l'écrou, sans coincement.
- Transmission du couple et résistance des douilles/ergots : les pièces imprimées ne sont pas validées pour le serrage.
- Détection de présence et contrôle des échecs.
- Mesure de longueur après changement.
- Fixation adaptée aux rainures et courses effectives de la CNC 3018.
- Séquence de changement et intégration FluidNC après validation mécanique.

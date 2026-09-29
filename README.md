# DiyATCCnc

Prototype DIY de magasin linéaire à quatre douilles sur ressort pour une **CNC 3018**. Conception paramétrique OpenSCAD, fichiers STL et documentation en français.

**Version mécanique actuelle : V3. Les douilles restent entièrement sous le couvercle**, même au repos. Le couvercle laisse passer les écrous et retient les douilles. Les ressorts autorisent une descente de 4 mm, et des ergots internes empêchent la rotation des douilles.

> État réel : prototype d'ajustement manuel, pas un changeur automatique opérationnel. Les ressorts ne sont pas sélectionnés, le serrage n'est pas validé et aucune retenue de fraise desserrée n'est prévue. Ne pas lancer de serrage motorisé dans les pièces imprimées.

## Télécharger et ouvrir

- [Source OpenSCAD complet](cad/ATC_4_douilles_ressorts.scad)
- STL : [bloc](stl/bloc.stl), [couvercle](stl/plaque.stl), [douille](stl/douille.stl), [fond](stl/fond.stl)
- [Montage et impression](docs/MONTAGE.md)
- [Dimensions et ressorts](docs/CONCEPTION.md)
- [Matériel et intégration FluidNC](docs/ELECTRONIQUE.md)
- [Notice détaillée V3](docs/NOTICE_V3.txt)
- [Calibres pour l'écrou de 17 mm](calibres/)
- [Historique et limites](docs/HISTORIQUE.md)

Imprimer **1 bloc, 1 couvercle, 1 fond et 4 douilles**. Dans GitHub, les fichiers STL peuvent être visualisés individuellement ; utiliser le téléchargement du fichier pour les ouvrir dans un trancheur.

Dans OpenSCAD, modifier `piece` :

```scad
piece = "assemblage"; // Vue complète
// "coupe"      : coupe de contrôle de l'intérieur
// "bloc"       : corps seul
// "plaque"     : couvercle seul
// "douille"    : douille seule, à imprimer 4 fois
// "fond"       : fond avec guides de ressort et butées
// "impression" : toutes les pièces disposées à plat
```

Utiliser F5 pour l'aperçu et F6 avant export STL. Les ressorts affichés sont schématiques et ne sont pas exportés. Exporter les pièces séparément, pas l'assemblage en contact.

Pour montrer la position basse :

```scad
enfoncement = 4; // entre 0 et course
```

## Matériel déclaré

| Élément | Information connue |
|---|---|
| Machine | CNC 3018, variante exacte non documentée |
| Carte | ESP32, firmware FluidNC déclaré par l'utilisateur |
| Broche | Alimentation 24 V ; référence et courant à confirmer |
| Commande envisagée | Module double BTS7960 |
| Écrou | Clé de 17 mm, hauteur mesurée 13 mm |
| Ressorts | Pas encore achetés |

Le diamètre extérieur maximal de l'écrou, la hauteur de ses méplats et le dégagement du nez de broche restent à mesurer. Une clé de 17 mm ne suffit pas à définir tout le profil.

## Dimensions de la V3

| Dimension | Valeur de départ |
|---|---:|
| Ensemble fixe | 180 × 44 × 63 mm |
| Corps seul | 180 × 44 × 54 mm |
| Fond / couvercle | 6 / 3 mm |
| Entraxe outils | 40 mm |
| Course de chaque douille | 4 mm |
| Passage des écrous dans le couvercle | Ø22 mm, provisoire |
| Empreinte d'écrou | 17,4 mm sur plats, profondeur 13,5 mm |
| Fixation | 4 trous Ø5,5 mm, entraxes 166 × 28 mm |

Ces dimensions, hors mesures d'écrou confirmées, sont des hypothèses de prototype. Vérifier notamment la hauteur disponible en Z sur la machine.

## Reproduire les exports

Installer OpenSCAD et Python 3, puis depuis le dépôt :

```bash
python3 scripts/export_stl.py
python3 scripts/verifier_stl.py
```

Les scripts utilisent uniquement la bibliothèque standard Python et l'exécutable OpenSCAD. `OPENSCAD` peut désigner son chemin complet. Les contrôles de maillage ne prouvent ni la résistance des pièces ni le fonctionnement du serrage.

## Références

- [XATC — dépôt](https://github.com/xpix/XATC)
- [XATC — carrousel](https://github.com/xpix/XATC/wiki/XATC-Carousel)
- [RapidChange ATC — magasins linéaires](https://rapidchangeatc.com/shop/automatic-tool-changer/linear-magazines/)
- [BTS7960 — documentation Infineon](https://www.infineon.com/assets/row/public/documents/10/57/infineon-bts7960-ds-en.pdf)
- [FluidNC — dépôt officiel](https://github.com/bdring/FluidNC)
- [OpenSCAD](https://openscad.org/)

Le projet s'inspire de ces principes mais n'est ni affilié à RapidChange ni une reproduction validée de son mécanisme. Aucune licence tierce n'est attribuée automatiquement aux fichiers de ce dépôt ; le propriétaire peut choisir une licence de diffusion.

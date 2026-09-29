# Historique de conception

- Calibres : ouvertures hexagonales 17,2 / 17,4 / 17,6 mm, pour essais statiques. Source et STL conservés dans `calibres/`.
- Premier bloc statique : 4 empreintes fixes, 180 × 40 × 30 mm, conservé dans `archives/bloc_statique/`. Ce n'est pas le montage à ressort actuel.
- V1 à ressort : douilles retenues par un épaulement intégré au corps.
- V2 : plaque supérieure démontable de 8 mm ; les douilles dépassaient de 12 mm. Cette disposition ne correspondait pas au besoin final.
- **V3 actuelle** : douilles entièrement sous le couvercle de 3 mm, ouvertures d'écrou Ø22 mm, rainures antirotation dans le corps. Course 4 mm. Hauteur totale 63 mm.

Les exports des V1/V2 à ressort ont été remplacés au fil des corrections ; ils ne sont pas présentés comme des fichiers historiques disponibles dans ce dépôt. Les dossiers principaux contiennent la V3.

## Validation effectuée

Les fichiers ont été calculés par OpenSCAD. Les maillages STL ont été contrôlés pour vérifier que chaque arête appartient à deux triangles. Les cotes verticales de repos et de course ont été vérifiées numériquement.

Il n'y a pas eu d'essai physique, de simulation d'efforts, de mesure de couple ou de validation de changement automatique. Un maillage fermé indique une propriété géométrique, pas une validation fonctionnelle.

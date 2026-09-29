// CNC 3018 - calibres statiques, PAS une douille ATC fonctionnelle.
// Unites : mm. 17 mm sur plats confirmes ; hauteur ecrou 13 mm.
// L'ecrou reel peut etre cylindrique avec plats partiels : verifier l'engagement.
// selection = -1 : les trois calibres ; 0, 1, 2 : une piece.
selection = -1;
sur_plats = 17;
hauteur_ecrou = 13;
jeux = [0.2, 0.4, 0.6]; // jeu TOTAL sur plats, pas par face
hauteur_calibre = 6; // volontairement court pour sonder la zone des plats
$fn = 96;
module calibre(i) {
    ouverture = sur_plats + jeux[i];
    difference() {
        cylinder(d=30, h=hauteur_calibre);
        translate([0,0,-0.1])
            cylinder(d=ouverture/cos(30), h=hauteur_calibre+0.2, $fn=6);
        // Gravure de la largeur nominale sur plats
        translate([0,-12,hauteur_calibre-0.5])
            linear_extrude(height=0.6)
                text(str(ouverture),size=2.6,halign="center",valign="center");
    }
}
if (selection < 0) {
    for (i=[0:2]) translate([i*34,0,0]) calibre(i);
} else {
    assert(selection>=0 && selection<=2);
    calibre(selection);
}

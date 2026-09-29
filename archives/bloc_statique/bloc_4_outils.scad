/* CNC 3018 - bloc lineaire 4 outils, prototype statique.
   Dimensions en mm. Pas une douille ATC RapidChange.
   Ne pas utiliser la rotation moteur pour serrer dans ce bloc.
   Ecrou utilisateur : 17 mm sur plats, hauteur 13 mm.
   Profil reel (parties rondes, hauteur des plats) a verifier.
*/
nb_outils = 4;
entraxe = 40;
sur_plats_ecrou = 17;
jeu_total = 0.4; // jeu total sur plats, pas par face
hauteur_ecrou = 13;
profondeur_logement = hauteur_ecrou + 0.5;
passage_fraise = 10; // trou traversant, adapter a l'outil
longueur = (nb_outils-1)*entraxe + 60;
largeur = 40;
hauteur = 30;
rayon_coin = 4;
diametre_vis = 5.5; // passage M5, sans lamage
marge_vis = 8;
chanfrein = 1;
$fn = 80;
module hexagone(af,h) { cylinder(d=af/cos(30),h=h,$fn=6); }
module corps() {
    linear_extrude(height=hauteur)
        offset(r=rayon_coin)
            square([longueur-2*rayon_coin,largeur-2*rayon_coin],center=true);
}
assert(nb_outils>=1 && floor(nb_outils)==nb_outils);
assert(profondeur_logement < hauteur);
assert(passage_fraise < sur_plats_ecrou);
assert(entraxe > (sur_plats_ecrou+jeu_total+2*chanfrein)/cos(30)+4);
difference() {
    corps();
    for(i=[0:nb_outils-1]) {
        x=(i-(nb_outils-1)/2)*entraxe;
        translate([x,0,-0.1]) cylinder(d=passage_fraise,h=hauteur+0.2);
        translate([x,0,hauteur-profondeur_logement])
            hexagone(sur_plats_ecrou+jeu_total,profondeur_logement+0.1);
        translate([x,0,hauteur-chanfrein])
            cylinder(d1=(sur_plats_ecrou+jeu_total)/cos(30),
                     d2=(sur_plats_ecrou+jeu_total+2*chanfrein)/cos(30),
                     h=chanfrein+0.01,$fn=6);
        translate([x,-15,hauteur-0.6])
            linear_extrude(height=0.7)
                text(str("T",i+1),size=4,halign="center",valign="center");
    }
    for(x=[-longueur/2+marge_vis,longueur/2-marge_vis])
        for(y=[-largeur/2+marge_vis,largeur/2-marge_vis])
            translate([x,y,-0.1]) cylinder(d=diametre_vis,h=hauteur+0.2);
}

/* CNC 3018 - prototype mecanique V3, douilles entierement sous le couvercle.
   Unites mm. Ecrou : 17 sur plats, hauteur 13.
   ATTENTION : prototype d'ajustement manuel, PAS un ATC valide.
   Ressorts, couple, maintien de fraise et profils reels restent a valider.
   Ne pas lancer de serrage motorise dans les empreintes imprimees.
   Inspiration : https://github.com/xpix/XATC
   https://rapidchangeatc.com/product-category/automatic-tool-changer/

   piece = "assemblage", "bloc", "douille", "fond", "plaque", "impression".
   F5 : apercu ; F6 : calcul ; exporter chaque piece separement en STL.
   Imprimer 1 bloc, 1 plaque, 1 fond et 4 douilles.
*/
piece = "assemblage";
$fn = 80;
nombre = 4;
entraxe = 40;
largeur = 44;
marge_extremite = 30;
rayon_coins = 3;

// Ecrou : seule la cote sur plats et sa hauteur sont confirmees.
ecrou_plats = 17;
ecrou_hauteur = 13;
jeu_ecrou = 0.4; // total sur plats
profondeur_empreinte = ecrou_hauteur + 0.5;
chanfrein = 1;
passage_outil = 10; // adapter au diametre de la fraise

// Douille et guidage (dimensions de prototype)
diam_douille = 28;
jeu_guidage = 0.4; // jeu diametral TOTAL
hauteur_douille = 23; // collerette comprise
diam_collerette = 32;
ep_collerette = 3;
diam_chambre = 34;
course = 4;
// Ergot axial : glisse dans une rainure et bloque la rotation.
largeur_ergot = 4;
saillie_ergot = 2;
jeu_ergot = 0.4;

// RESSORT PROVISOIRE : cotes reservees, pas une reference d'achat.
ressort_d_ext = 22;
ressort_fil = 2;
ressort_longueur_libre = 33;
precompression = 2;
// La raideur, la longueur a spires jointives et le couple restent a definir.

// Fond, guide superieur et fixation
ep_fond = 6;
ep_couvercle = 3;
passage_ecrou = 22; // provisoire : mesurer le diametre maximal reel
jeu_axial_collerette = 0.5; // le couvercle, et non la collerette, arrete la remontee
vis_d = 5.5; // 4 vis traversantes M5 + ecrous/rondelles externes
marge_vis_x = 7;
marge_vis_y = 8;
// Position de demonstration entre 0 (repos) et course.
enfoncement = 0;
afficher_ressorts = true;

longueur = (nombre-1)*entraxe + 2*marge_extremite;
ressort_longueur_installee = ressort_longueur_libre-precompression;
z_collerette = ep_fond + ressort_longueur_installee;
z_epaulement = z_collerette + ep_collerette + jeu_axial_collerette;
z_couvercle = z_collerette + hauteur_douille;
hauteur_totale_bloc = z_couvercle + ep_couvercle;
rayon_ergot_ext = diam_douille/2 + saillie_ergot;

assert(nombre>=1 && floor(nombre)==nombre);
assert(enfoncement>=0 && enfoncement<=course);
assert(ressort_longueur_installee>course);
assert(ressort_d_ext < diam_collerette);
assert(ressort_d_ext-2*ressort_fil > passage_outil+2);
assert(diam_collerette > diam_douille+jeu_guidage+2);
assert(diam_chambre > diam_collerette+0.4);
assert(entraxe > diam_chambre+3);
assert(largeur > diam_chambre+6);
assert(hauteur_douille-profondeur_empreinte>ep_collerette);
assert(diam_douille > (ecrou_plats+jeu_ecrou+2*chanfrein)/cos(30)+3);
assert(hauteur_douille-ep_collerette-jeu_axial_collerette>course);
assert(passage_ecrou > (ecrou_plats+jeu_ecrou)/cos(30));
assert(passage_ecrou < diam_douille-3);
assert(ep_couvercle>0);

function position(i) = (i-(nombre-1)/2)*entraxe;
module arrondi(l,p,h) {
 linear_extrude(height=h)
  offset(r=rayon_coins)
   square([l-2*rayon_coins,p-2*rayon_coins],center=true);
}
module trous_vis(h) {
 for(x=[-longueur/2+marge_vis_x,longueur/2-marge_vis_x])
  for(y=[-largeur/2+marge_vis_y,largeur/2-marge_vis_y])
   translate([x,y,-0.1]) cylinder(d=vis_d,h=h+0.2);
}
module empreinte_hex(af,h) { cylinder(d=af/cos(30),h=h,$fn=6); }

// Corps haut : insertion des douilles par DESSOUS (collerettes).
// Le guidage et la rainure antirotation sont entierement sous le couvercle.
module bloc() {
 h=z_couvercle-ep_fond;
 difference() {
  arrondi(longueur,largeur,h);
  trous_vis(h);
  for(i=[0:nombre-1]) translate([position(i),0,0]) {
   translate([0,0,-0.1])
    cylinder(d=diam_chambre,h=z_epaulement-ep_fond+0.1);
   translate([0,0,-0.1]) cylinder(d=diam_douille+jeu_guidage,h=h+0.2);
   translate([0,-(largeur_ergot+jeu_ergot)/2,-0.1])
    cube([rayon_ergot_ext+jeu_ergot/2,largeur_ergot+jeu_ergot,h+0.2]);
  }
 }
}

// Couvercle : ouvertures pour ECROUS uniquement, pas pour les douilles.
// Sa face inferieure retient directement le dessus des douilles.
module plaque() {
 difference() {
  arrondi(longueur,largeur,ep_couvercle);
  trous_vis(ep_couvercle);
  for(i=[0:nombre-1]) translate([position(i),0,0]) {
   translate([0,0,-0.1]) cylinder(d=passage_ecrou,h=ep_couvercle+0.2);
   translate([0,0,ep_couvercle-0.8])
    cylinder(d1=passage_ecrou,d2=passage_ecrou+1.6,h=0.81);
   translate([0,-18,ep_couvercle-0.6]) linear_extrude(height=0.7)
    text(str("T",i+1),size=3,halign="center",valign="center");
  }
 }
}

// Douille exportee avec collerette sur le plateau d'impression.
module douille() {
 difference() {
  union() {
   cylinder(d=diam_collerette,h=ep_collerette);
   translate([0,0,ep_collerette-0.01])
    cylinder(d=diam_douille,h=hauteur_douille-ep_collerette+0.01);
   translate([diam_douille/2-1,-largeur_ergot/2,ep_collerette-0.01])
    cube([saillie_ergot+1,largeur_ergot,hauteur_douille-ep_collerette+0.01]);
  }
  translate([0,0,-0.1]) cylinder(d=passage_outil,h=hauteur_douille+0.2);
  translate([0,0,hauteur_douille-profondeur_empreinte])
   empreinte_hex(ecrou_plats+jeu_ecrou,profondeur_empreinte+0.1);
  translate([0,0,hauteur_douille-chanfrein])
   cylinder(d1=(ecrou_plats+jeu_ecrou)/cos(30),
            d2=(ecrou_plats+jeu_ecrou+2*chanfrein)/cos(30),
            h=chanfrein+0.01,$fn=6);
 }
}

// Fond avec centrage annulaire du ressort et butee de course centrale.
// La butee touche la collerette apres "course" mm d'enfoncement.
module fond() {
 difference() {
  union() {
   arrondi(longueur,largeur,ep_fond);
   for(i=[0:nombre-1]) translate([position(i),0,ep_fond-0.01]) {
    // Tube central : centre le ressort et limite la descente.
    cylinder(d=ressort_d_ext-2*ressort_fil-0.8,
             h=ressort_longueur_installee-course+0.01);
   }
  }
  trous_vis(hauteur_totale_bloc);
  for(i=[0:nombre-1]) translate([position(i),0,-0.1])
   cylinder(d=passage_outil,h=hauteur_totale_bloc+0.2);
 }
}

// Ressorts SCHEMATIQUES, affiches uniquement en apercu, jamais en STL.
// Anneaux de visualisation : ne representent pas la geometrie a fabriquer.
module ressort_apercu(h) {
 for(j=[0:6]) translate([0,0,ressort_fil/2+j*(h-ressort_fil)/6])
  rotate_extrude($fn=48)
   translate([(ressort_d_ext-ressort_fil)/2,0]) circle(d=ressort_fil,$fn=12);
}
module assemblage() {
 color("SteelBlue",0.45) translate([0,0,ep_fond]) bloc();
 color("DimGray") fond();
 color("LightSteelBlue") translate([0,0,z_couvercle]) plaque();
 for(i=[0:nombre-1]) {
  color("Orange") translate([position(i),0,z_collerette-enfoncement]) douille();
  if($preview && afficher_ressorts)
   %translate([position(i),0,ep_fond])
    ressort_apercu(ressort_longueur_installee-enfoncement);
 }
}
if(piece=="bloc") bloc();
else if(piece=="fond") fond();
else if(piece=="plaque") plaque();
else if(piece=="douille") douille();
else if(piece=="impression") {
 bloc();
 translate([0,largeur+10,0]) fond();
 translate([0,2*(largeur+10),0]) plaque();
 for(i=[0:nombre-1]) translate([position(i),-largeur-2,0]) douille();
}
else if(piece=="coupe") difference() {
 assemblage();
 translate([-longueur,-largeur,-1]) cube([2*longueur,largeur,hauteur_totale_bloc+10]);
}
else if(piece=="assemblage") assemblage();
else assert(false,"piece inconnue");

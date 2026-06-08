//-------------------------------//
// Braço Robótico - Grip Paramétrico
//-------------------------------//

$fn = 40;

// ===== Variáveis ajustáveis =====

escala_garra = 1.4;      // aumenta ou reduz toda a garra
abertura = -15;          // ângulo de abertura
dupla_garra = false;     // gera uma ou duas garras

raio_base = 6;
altura_base = 8;
diametro_furo = 5;

// ===============================

Grip();

module Grip() {

    // Base de articulação
    difference() {
        cylinder(r=raio_base,h=altura_base);

        translate([0,0,-1])
        cylinder(
            d=diametro_furo,
            h=altura_base+2
        );
    }

    translate([0,0,altura_base])
    Hand2();
}

module Hand2() {

    Hand1();

    if (dupla_garra)
        rotate([0,0,180])
        Hand1();
}

module Hand1() {

    scale([escala_garra,escala_garra,escala_garra]) {

        hand();

        PL = [
            [-4,-4],
            [-6,-4],
            [-2,3],
            [2,3],
            [6,-4],
            [4,-4],
            [0,-2]
        ];

        translate([0,0,-1])
        linear_extrude(2)
        polygon(PL);
    }
}

module Fingers_2d() {

    translate([-1,-10]) {

        square([2,10]);

        translate([2,0])
        square([2,2]);

        translate([1.5,9])
        rotate(60)
        square([4,1.76]);
    }
}

module hand() {

    translate([0,0,-2.5]) {

        MirrorCopy([1,0,0])

        translate([-6,-4.67])
        rotate(abertura) {

            translate([0,0,.5])

            linear_extrude(4)
            Fingers_2d();

            linear_extrude(5)
            difference() {

                Fingers_2d();

                offset(-0.3)
                Fingers_2d();
            }

            translate([0.15,0])
            cylinder(r=.6,h=5);

            translate([0.15,-9,0])
            cylinder(r=.6,h=5);
        }
    }
}

module MirrorCopy(M) {

    children();

    mirror(M)
    children();
}
capInnerWidth=92;
capInnerDepth=17;

postOuterWidth=82;
postCurveHeight=11;
postCurveFlatCutHeight=4;

overlap=0.01;
$fn=50;

//difference() {
//    gapFillerBody();
    postTopCutout();
//}

module gapFillerBody() {
    cube([capInnerWidth, capInnerWidth, capInnerDepth]);
}

module postTopCutout() {
    curveMultiplier=3;
    curveSphereDia=postOuterWidth*curveMultiplier;
    translate([-postOuterWidth/2, -postOuterWidth/2,0])
        cube([postOuterWidth,postOuterWidth,capInnerDepth-postCurveHeight]);
    translate([0,0,capInnerDepth-postCurveHeight])
        difference() {
           translate([0,0,-curveSphereDia/2+postCurveHeight])
                sphere(d=curveSphereDia);
            // bottom cut
            translate([-curveSphereDia/2-overlap,-curveSphereDia/2-overlap,-curveSphereDia]) 
                cube([curveSphereDia+overlap*2,
                    curveSphereDia+overlap*2,
                    curveSphereDia+overlap]);
            translate([-curveSphereDia/2-overlap,
                    -curveSphereDia/2-overlap,
                    postCurveHeight-postCurveFlatCutHeight]) 
                cube([curveSphereDia+overlap*2,
                    curveSphereDia+overlap*2,
                    curveSphereDia+overlap]);
        
    }
}

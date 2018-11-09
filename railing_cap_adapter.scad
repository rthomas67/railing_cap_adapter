capInnerWidth=92;
capInnerDepth=17;

postOuterWidth=82;
postCurveHeight=11;
postCurveFlatCutHeight=4;

overlap=0.01;
$fn=50;

difference() {
    gapFillerBody();
    translate([0,0,-overlap])
        //scale([1,1,1.4])
        postTopCutout();
}

module gapFillerBody() {
    translate([-capInnerWidth/2,-capInnerWidth/2,0])
        cube([capInnerWidth, capInnerWidth, capInnerDepth]);
}

module postTopCutout() {
    curveMultiplier=3.95;
    curveSphereDia=postOuterWidth*curveMultiplier;
    hull() {
        // square part
        translate([-postOuterWidth/2, -postOuterWidth/2,0])
            cube([postOuterWidth,postOuterWidth,capInnerDepth-postCurveHeight]);
        
        // domed part
        difference() {
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
            // square off outer square
            translate([-postOuterWidth,-postOuterWidth,0])
                difference() {
                    cube([postOuterWidth*2,postOuterWidth*2,capInnerDepth]);
                    translate([postOuterWidth/2,postOuterWidth/2,-overlap])
                    cube([postOuterWidth,postOuterWidth,capInnerDepth+overlap*2]);
                }
        }
    }
}

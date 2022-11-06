package fx.gr;
import mt.bumdum.Lib;

import Fight;

class Mistral extends fx.GroupEffect{

	public function new( f, list ) {
		super(f,list);
		caster.playAnim("cast");
		spc = 0.03;
		goto(f.x, Scene.getPYMiddle());
	}

	public override function update() {
		super.update();
		switch(step) {
			case 0:
				caster.updateMove(coef);
				if(coef == 1) {
					nextStep();
					caster.backToDefault();
				}
			case 1:
				updateAura(4, caster.skinBox);
				for( i in 0...2) genRayConcentrate();
				if(coef == 1) {
					caster.skinBox.filters = [];
					//caster.playAnim("release");
					nextStep();
					spc = 0.015;
				}

			case 2:
				// GOUTTES DE VENT
				if(coef < 0.8) {
					for( i in 0...3 ) {
						var w = Cs.mcw*0.5;
						var p = new Part( Scene.me.dm.attach( "partWind", Scene.DP_FIGHTER ) );
						p.x = w+(Math.random()*150-100)*caster.intSide;
						p.y = Scene.getRandomPYPos();
						p.z = -15;
						p.vx = ( 9+Math.random()*9 ) * caster.intSide;
						p.vr = (Math.random()*2-1)*20;
						p.root.smc._x = Math.random()*40;
						p.root._rotation = Math.random()*360;
						p.timer = 10+Math.random()*20;
						p.root.smc._xscale = p.root.smc._yscale = 100+Math.random()*50;
						p.updatePos();
					}
				}
				if(coef == 1) {
					damageAll();
					end();
				}
		}
	}
}

package dungeons;


import haxepunk.Engine;
import haxepunk.HXP;

import dungeons.systems.RenderSystem.RenderLayers;

class Main extends Engine
{
    override public function init()
    {
       com.haxepunk.gui.Control.useSkin("gfx/ui/blueMagda.png");
        com.haxepunk.gui.Control.defaultLayer = RenderLayers.UI;
//        HXP.console.enable();
        trace('Random seed is ${haxepunk.math.Random.randomSeed}');
        HXP.scene = new GameScene();
		this.onResize.bind(onResizeHandler);
    }
	
	function onResizeHandler():Void {
	  if (HXP.width == 0) HXP.width = HXP.stage.stageWidth;
        if (HXP.height == 0) HXP.height = HXP.stage.stageHeight;
        // calculate scale from width/height values
        HXP.screen.scaleX = 1;
        HXP.screen.scaleY = 1;
		
        HXP.resize(HXP.stage.stageWidth, HXP.stage.stageHeight);
	}

    
}

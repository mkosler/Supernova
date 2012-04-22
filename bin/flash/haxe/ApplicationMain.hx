import Main;
import nme.Assets;
import nme.events.Event;


class ApplicationMain {
	
	static var mPreloader:NMEPreloader;

	public static function main () {
		
		var call_real = true;
		
		
		var loaded:Int = nme.Lib.current.loaderInfo.bytesLoaded;
		var total:Int = nme.Lib.current.loaderInfo.bytesTotal;
		
		if (loaded < total || true) /* Always wait for event */ {
			
			call_real = false;
			mPreloader = new NMEPreloader();
			nme.Lib.current.addChild(mPreloader);
			mPreloader.onInit();
			mPreloader.onUpdate(loaded,total);
			nme.Lib.current.addEventListener (nme.events.Event.ENTER_FRAME, onEnter);
			
		}
		
		
		if (call_real)
			Main.main();
	}

	static function onEnter (_) {
		
		var loaded:Int = nme.Lib.current.loaderInfo.bytesLoaded;
		var total:Int = nme.Lib.current.loaderInfo.bytesTotal;
		mPreloader.onUpdate(loaded,total);
		
		if (loaded >= total) {
			
			nme.Lib.current.removeEventListener(nme.events.Event.ENTER_FRAME, onEnter);
			mPreloader.addEventListener (Event.COMPLETE, preloader_onComplete);
			mPreloader.onLoaded();
			
		}
		
	}

	public static function getAsset (inName:String):Dynamic {
		
		
		if (inName=="gfx/plate.png")
			 
            return Assets.getBitmapData ("gfx/plate.png");
         
		
		if (inName=="gfx/healthbar.png")
			 
            return Assets.getBitmapData ("gfx/healthbar.png");
         
		
		if (inName=="gfx/debug/console_pause.png")
			 
            return Assets.getBitmapData ("gfx/debug/console_pause.png");
         
		
		if (inName=="gfx/debug/console_play.png")
			 
            return Assets.getBitmapData ("gfx/debug/console_play.png");
         
		
		if (inName=="gfx/debug/console_output.png")
			 
            return Assets.getBitmapData ("gfx/debug/console_output.png");
         
		
		if (inName=="gfx/debug/console_logo.png")
			 
            return Assets.getBitmapData ("gfx/debug/console_logo.png");
         
		
		if (inName=="gfx/debug/console_step.png")
			 
            return Assets.getBitmapData ("gfx/debug/console_step.png");
         
		
		if (inName=="gfx/debug/console_debug.png")
			 
            return Assets.getBitmapData ("gfx/debug/console_debug.png");
         
		
		if (inName=="gfx/background.png")
			 
            return Assets.getBitmapData ("gfx/background.png");
         
		
		if (inName=="gfx/planets/attack.png")
			 
            return Assets.getBitmapData ("gfx/planets/attack.png");
         
		
		if (inName=="gfx/planets/sun.png")
			 
            return Assets.getBitmapData ("gfx/planets/sun.png");
         
		
		if (inName=="gfx/planets/orbit2.png")
			 
            return Assets.getBitmapData ("gfx/planets/orbit2.png");
         
		
		if (inName=="gfx/planets/orbit1.png")
			 
            return Assets.getBitmapData ("gfx/planets/orbit1.png");
         
		
		if (inName=="gfx/planets/food.png")
			 
            return Assets.getBitmapData ("gfx/planets/food.png");
         
		
		if (inName=="gfx/planets/defend.png")
			 
            return Assets.getBitmapData ("gfx/planets/defend.png");
         
		
		if (inName=="gfx/resource.png")
			 
            return Assets.getBitmapData ("gfx/resource.png");
         
		
		if (inName=="gfx/upgrade.png")
			 
            return Assets.getBitmapData ("gfx/upgrade.png");
         
		
		if (inName=="font/04B_03__.ttf")
			 
			 return Assets.getFont ("font/04B_03__.ttf");
         
		
		
		return null;
		
	}
	
	
	private static function preloader_onComplete (event:Event):Void {
		
		mPreloader.removeEventListener (Event.COMPLETE, preloader_onComplete);
		
		nme.Lib.current.removeChild(mPreloader);
		mPreloader = null;
		
		Main.main ();
		
	}
	
}



	
		class NME_gfx_plate_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
	

	
		class NME_gfx_healthbar_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
	

	
		class NME_gfx_debug_console_pause_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
	

	
		class NME_gfx_debug_console_play_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
	

	
		class NME_gfx_debug_console_output_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
	

	
		class NME_gfx_debug_console_logo_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
	

	
		class NME_gfx_debug_console_step_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
	

	
		class NME_gfx_debug_console_debug_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
	

	
		class NME_gfx_background_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
	

	
		class NME_gfx_planets_attack_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
	

	
		class NME_gfx_planets_sun_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
	

	
		class NME_gfx_planets_orbit2_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
	

	
		class NME_gfx_planets_orbit1_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
	

	
		class NME_gfx_planets_food_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
	

	
		class NME_gfx_planets_defend_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
	

	
		class NME_gfx_resource_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
	

	
		class NME_gfx_upgrade_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
	

	
		class NME_font_04b_03___ttf extends nme.text.Font { }
	

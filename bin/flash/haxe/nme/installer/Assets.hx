package nme.installer;


import nme.display.BitmapData;
import nme.media.Sound;
import nme.net.URLRequest;
import nme.text.Font;
import nme.utils.ByteArray;
import ApplicationMain;


/**
 * ...
 * @author Joshua Granick
 */

class Assets {

	
	public static var cachedBitmapData:Hash<BitmapData> = new Hash<BitmapData>();
	
	private static var initialized:Bool = false;
	private static var resourceClasses:Hash <Dynamic> = new Hash <Dynamic> ();
	private static var resourceTypes:Hash <String> = new Hash <String> ();
	
	
	private static function initialize ():Void {
		
		if (!initialized) {
			
			resourceClasses.set ("gfx/plate.png", NME_gfx_plate_png);
			resourceTypes.set ("gfx/plate.png", "image");
			resourceClasses.set ("gfx/missile.png", NME_gfx_missile_png);
			resourceTypes.set ("gfx/missile.png", "image");
			resourceClasses.set ("gfx/healthbar.png", NME_gfx_healthbar_png);
			resourceTypes.set ("gfx/healthbar.png", "image");
			resourceClasses.set ("gfx/bullet.png", NME_gfx_bullet_png);
			resourceTypes.set ("gfx/bullet.png", "image");
			resourceClasses.set ("gfx/debug/console_pause.png", NME_gfx_debug_console_pause_png);
			resourceTypes.set ("gfx/debug/console_pause.png", "image");
			resourceClasses.set ("gfx/debug/console_play.png", NME_gfx_debug_console_play_png);
			resourceTypes.set ("gfx/debug/console_play.png", "image");
			resourceClasses.set ("gfx/debug/console_output.png", NME_gfx_debug_console_output_png);
			resourceTypes.set ("gfx/debug/console_output.png", "image");
			resourceClasses.set ("gfx/debug/console_logo.png", NME_gfx_debug_console_logo_png);
			resourceTypes.set ("gfx/debug/console_logo.png", "image");
			resourceClasses.set ("gfx/debug/console_step.png", NME_gfx_debug_console_step_png);
			resourceTypes.set ("gfx/debug/console_step.png", "image");
			resourceClasses.set ("gfx/debug/console_debug.png", NME_gfx_debug_console_debug_png);
			resourceTypes.set ("gfx/debug/console_debug.png", "image");
			resourceClasses.set ("gfx/mothership.png", NME_gfx_mothership_png);
			resourceTypes.set ("gfx/mothership.png", "image");
			resourceClasses.set ("gfx/background.png", NME_gfx_background_png);
			resourceTypes.set ("gfx/background.png", "image");
			resourceClasses.set ("gfx/planets/attack.png", NME_gfx_planets_attack_png);
			resourceTypes.set ("gfx/planets/attack.png", "image");
			resourceClasses.set ("gfx/planets/sun.png", NME_gfx_planets_sun_png);
			resourceTypes.set ("gfx/planets/sun.png", "image");
			resourceClasses.set ("gfx/planets/orbit2.png", NME_gfx_planets_orbit2_png);
			resourceTypes.set ("gfx/planets/orbit2.png", "image");
			resourceClasses.set ("gfx/planets/orbit1.png", NME_gfx_planets_orbit1_png);
			resourceTypes.set ("gfx/planets/orbit1.png", "image");
			resourceClasses.set ("gfx/planets/food.png", NME_gfx_planets_food_png);
			resourceTypes.set ("gfx/planets/food.png", "image");
			resourceClasses.set ("gfx/planets/defend.png", NME_gfx_planets_defend_png);
			resourceTypes.set ("gfx/planets/defend.png", "image");
			resourceClasses.set ("gfx/simpleship.png", NME_gfx_simpleship_png);
			resourceTypes.set ("gfx/simpleship.png", "image");
			resourceClasses.set ("gfx/resource.png", NME_gfx_resource_png);
			resourceTypes.set ("gfx/resource.png", "image");
			resourceClasses.set ("gfx/upgrade.png", NME_gfx_upgrade_png);
			resourceTypes.set ("gfx/upgrade.png", "image");
			resourceClasses.set ("font/04B_03__.ttf", NME_font_04b_03___ttf);
			resourceTypes.set ("font/04B_03__.ttf", "font");
			
			initialized = true;
			
		}
		
	}
	
	
	public static function getBitmapData (id:String, useCache:Bool = true):BitmapData {
		
		initialize ();
		
		if (resourceTypes.exists (id) && resourceTypes.get (id) == "image") {
			
			if (useCache && cachedBitmapData.exists (id)) {
				
				return cachedBitmapData.get (id);
				
			} else {
				
				var data = cast (Type.createInstance (resourceClasses.get (id), []), BitmapData);
				
				if (useCache) {
					
					cachedBitmapData.set (id, data);
					
				}
				
				return data;
				
			}
			
		} else {
			
			trace ("[nme.Assets] There is no BitmapData asset with an ID of \"" + id + "\"");
			
			return null;
			
		}
		
	}
	
	
	public static function getBytes (id:String):ByteArray {
		
		initialize ();
		
		if (resourceClasses.exists (id)) {
			
			return cast (Type.createInstance (resourceClasses.get (id), []), ByteArray);
			
		} else {
			
			trace ("[nme.Assets] There is no String or ByteArray asset with an ID of \"" + id + "\"");
			
			return null;
			
		}
		
	}
	
	
	public static function getFont (id:String):Font {
		
		initialize ();
		
		if (resourceTypes.exists (id) && resourceTypes.get (id) == "font") {
			
			return cast (Type.createInstance (resourceClasses.get (id), []), Font);
			
		} else {
			
			trace ("[nme.Assets] There is no Font asset with an ID of \"" + id + "\"");
			
			return null;
			
		}
		
	}
	
	
	public static function getSound (id:String):Sound {
		
		initialize ();
		
		if (resourceTypes.exists (id)) {
			
			if (resourceTypes.get (id) == "sound" || resourceTypes.get (id) == "music") {
				
				return cast (Type.createInstance (resourceClasses.get (id), []), Sound);
				
			}
			
		}
		
		trace ("[nme.Assets] There is no Sound asset with an ID of \"" + id + "\"");
		
		return null;
		
	}
	
	
	public static function getText (id:String):String {
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
	}
	
	
}
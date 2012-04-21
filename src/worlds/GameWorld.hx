package worlds;

// Library imports
import com.haxepunk.World;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.graphics.Image;

// Game imports
import ui.PlanetButton;
import entities.planets.SolarSystem;

class GameWorld extends World 
{
	public var solarSystem : SolarSystem;

	public function new()
	{
		super();

		addGraphic(new Backdrop("gfx/background.png"));

		solarSystem = new SolarSystem(100, 3);
		for (e in solarSystem.entities) {
			add(e);
		}

		// UI plates
		var plateLeft : Entity = addGraphic(new Image("gfx/plate.png"));
		var plateRight : Entity = addGraphic(new Image("gfx/plate.png"));

		plateLeft.x = -10;
		plateLeft.y = 0;

		plateRight.x = HXP.width - 90;
		plateRight.y = 0;

		add(new PlanetButton(25, 100, new Image("gfx/planets/food.png"), "food", 20, solarSystem.sun));
		add(new PlanetButton(25, 300, new Image("gfx/planets/attack.png"), "attack", 20, solarSystem.sun));
		add(new PlanetButton(25, 500, new Image("gfx/planets/defend.png"), "defend", 20, solarSystem.sun));
	}

	public override function update() : Void 
	{
		super.update();
	}
}
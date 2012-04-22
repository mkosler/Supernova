package worlds;

// Library imports
import com.haxepunk.World;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;

// Game imports
import ui.PlanetButton;
import ui.Cursor;
import entities.planets.SolarSystem;
import entities.planets.Sun;

class GameWorld extends World 
{
	public var solarSystem : SolarSystem;
	public var cursor : Cursor;
	private var foodButton : PlanetButton;
	private var foodText : Entity;
	private var attackButton : PlanetButton;
	private var attackText : Entity;
	private var defendButton : PlanetButton;
	private var defendText : Entity;

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
		plateLeft.layer = 0;

		plateRight.x = HXP.width - 90;
		plateRight.y = 0;
		plateRight.layer = 0;

		// Ugliest thing I have ever done
		var costString : String = "Cost: ";
		foodButton = cast(add(new PlanetButton(25, 100, new Image("gfx/planets/food.png"), "food", 20, solarSystem.sun)), PlanetButton);
		foodText = addGraphic(new Text(costString + foodButton.cost));
		foodText.x = foodButton.x - 10;
		foodText.y = foodButton.y + foodButton.height + 10;
		foodText.layer = 0;

		attackButton = cast(add(new PlanetButton(25, 300, new Image("gfx/planets/attack.png"), "attack", 20, solarSystem.sun)), PlanetButton);
		attackText = addGraphic(new Text(costString + attackButton.cost));
		attackText.x = attackButton.x - 10;
		attackText.y = attackButton.y + attackButton.height + 10;
		attackText.layer = 0;

		defendButton = cast(add(new PlanetButton(25, 500, new Image("gfx/planets/defend.png"), "defend", 20, solarSystem.sun)), PlanetButton);
		defendText = addGraphic(new Text(costString + defendButton.cost));
		defendText.x = defendButton.x - 10;
		defendText.y = defendButton.y + defendButton.height + 10;
		defendText.layer = 0;
		// /end ugly

		cursor = new Cursor();
		add(cursor);
	}

	public override function update() : Void 
	{
		super.update();
	}
}
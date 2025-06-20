import flixel.FlxGame;
import flixel.FlxG;
import flixel.util.FlxColor;

import arcade.states.theLoadingState;
import arcade.backend.FPSCounter;

class Main extends FlxGame
{
    public function new()
    {
        super(500, 500, theLoadingState, 1, 60, 60, false);

        FlxG.game.setWindowTitle("FNF - Catch The Notes");
        FlxG.bgColor = FlxColor.BLACK;
        FlxG.signals.gamePostDraw.add(showFPSCounter);
    }

    var fpsCounter:FPSCounter;

    function showFPSCounter():Void
    {
        if (fpsCounter == null)
        {
            fpsCounter = new FPSCounter();
            FlxG.stage.addChild(fpsCounter);
        }
    }
}

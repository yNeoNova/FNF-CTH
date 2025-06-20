package arcade.states;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;

class theCreditsState extends FlxState
{
    override public function create():Void
    {
        super.create();
        FlxG.cameras.bgColor = FlxColor.BLACK;

        var creditsText = new FlxText(0, 0, FlxG.width, "the game is still a beta, made by yNova btw", 24);
        creditsText.setFormat(Paths.font("Frisky"), 24, FlxColor.WHITE, "center");
        creditsText.screenCenter();
        add(creditsText);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.BACKSPACE)
        {
            FlxG.switchState(new theMainMenuState());
        }
    }
}
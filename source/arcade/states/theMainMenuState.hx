package arcade.states;

import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.group.FlxGroup;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.Lib;
import openfl.net.URLRequest;

class theMainMenuState extends FlxState
{
    var selected:Int = 0;
    var options:Array<String> = ["Start Game", "How To Play", "Credits", "Exit Game"];
    var optionTexts:Array<FlxText> = [];

    override public function create():Void
    {
        super.create();
        FlxG.cameras.bgColor = FlxColor.BLACK;

        // Title text
        var title = new FlxText(0, 20, FlxG.width, "FNF - CATCH THE NOTES", 30);
        title.setFormat(Paths.font("Frisky"), 30, FlxColor.WHITE, "center");
        add(title);

        // Menu Options
        for (i in 0...options.length)
        {
            var opt = new FlxText(0, 100 + i * 40, FlxG.width, options[i], 24);
            opt.setFormat(Paths.font("Frisky"), 24, (i == selected) ? FlxColor.RED : FlxColor.WHITE, "center");
            optionTexts.push(opt);
            add(opt);
        }

        // Version text bottom-left (now ONLY FNF-CN V-1.0)
        var version = new FlxText(5, FlxG.height - 25, 0, "FNF-CN V-1.0", 12);
        version.setFormat(Paths.font("Frisky"), 12, FlxColor.WHITE, "left");
        add(version);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.UP) changeSelection(-1);
        if (FlxG.keys.justPressed.DOWN) changeSelection(1);
        if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE) confirmSelection();

        if (FlxG.keys.justPressed.BACKSPACE)
        {
            FlxG.switchState(new theTitleState());
        }
    }

    function changeSelection(change:Int):Void
    {
        selected = (selected + change + options.length) % options.length;
        for (i in 0...optionTexts.length)
            optionTexts[i].color = (i == selected) ? FlxColor.RED : FlxColor.WHITE;
    }

    function confirmSelection():Void
    {
        switch (options[selected])
        {
            case "Start Game":
                // TODO: Replace this with the actual game state when ready
                FlxG.switchState(new yourGameStateHere());
            case "How To Play":
                Lib.getURL(new URLRequest("https://your-website.github.io/howtoplay"), "_blank");
            case "Credits":
                FlxG.switchState(new theCreditsState());
            case "Exit Game":
                Sys.exit(0);
        }
    }
}
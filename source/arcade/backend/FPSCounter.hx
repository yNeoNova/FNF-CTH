package arcade.backend;

import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;
import openfl.system.System;

class FPSCounter extends FlxSprite
{
    var fpsText:FlxText;
    var memText:FlxText;

    public function new()
    {
        super();
        makeGraphic(120, 50, FlxColor.BLACK);
        setAlpha(0.5);

        x = 5;
        y = 5;
        scrollFactor.set(0, 0);

        fpsText = new FlxText(10, 5, 110, "", 16);
        fpsText.setFormat(Paths.font("vcr"), 16, FlxColor.WHITE, "left");
        fpsText.scrollFactor.set(0, 0);

        memText = new FlxText(10, 25, 110, "", 16);
        memText.setFormat(Paths.font("vcr"), 16, FlxColor.WHITE, "left");
        memText.scrollFactor.set(0, 0);

        addChild(fpsText);
        addChild(memText);

        FlxG.signals.gamePostUpdate.add(updateStats);
    }

    private function updateStats():Void
    {
        fpsText.text = "FPS: " + FlxG.framerate.intValue;

        var memUsed = System.totalMemory / (1024 * 1024);
        memText.text = "Memory: " + Std.string(Math.round(memUsed * 10) / 10) + " MB";
    }

    override public function destroy():Void
    {
        super.destroy();
        FlxG.signals.gamePostUpdate.remove(updateStats);
    }
}

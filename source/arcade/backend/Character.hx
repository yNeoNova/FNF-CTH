package arcade.backend;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxRandom;
import tjson.TJSON;
import flixel.graphics.frames.FlxAtlasFrames;

class Character extends FlxSprite
{
    public var lastKey:String = "right";
    var animData:Array<Dynamic>;

    public function new(jsonPath:String, ?x:Float = 0, ?y:Float = 0)
    {
        super(x, y);

        // Load JSON from assets/charsOffsets/
        var jsonData = TJSON.parse(sys.io.File.getContent('assets/charsOffsets/' + jsonPath));
        animData = jsonData.CharAnims;

        frames = FlxAtlasFrames.fromSparrow(Paths.image(jsonData.CharInfo.image_path), Paths.xml(jsonData.CharInfo.image_path));

        for (anim in animData)
            animation.addByPrefix(anim.AnimTag, anim.AnimInXML, anim.AnimFPS, anim.isLooped);

        antialiasing = jsonData.CharInfo.antialiasing;
        setGraphicSize(Math.floor(width * jsonData.CharInfo.char_scale));
        updateHitbox();

        playIdle();
    }

    public function playIdle():Void
    {
        if (lastKey == "left")
            animation.play("idle Left");
        else
            animation.play("idle Right");
    }

    public function updateCharacter():Void
    {
        if (FlxG.keys.pressed.LEFT)
        {
            if (animation.curAnim == null || animation.curAnim.name != "Walk Left")
                animation.play("Walk Left");
            lastKey = "left";
        }
        else if (FlxG.keys.pressed.RIGHT)
        {
            if (animation.curAnim == null || animation.curAnim.name != "Walk Right")
                animation.play("Walk Right");
            lastKey = "right";
        }
        else
        {
            if (FlxRandom.chanceRoll(0.1))
                animation.play("uhh");
            else
                playIdle();
        }
    }
}
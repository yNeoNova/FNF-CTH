package arcade.states;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.Assets;

import arcade.states.theTitleState;

class theLoadingState extends FlxState
{
    var titleText:FlxText;
    var assetText:FlxText;
    var phraseTopLeft:FlxText;
    var phraseTopRight:FlxText;
    var phraseBottomLeft:FlxText;
    var phraseBottomRight:FlxText;

    var bfSprite:FlxSprite;

    var assetsToLoad:Array<String> = [
        Paths.image("chars/bf"),
        Paths.font("Frisky"),
        Paths.music("load")
    ];

    var loadedAssets:Int = 0;

    override public function create():Void
    {
        super.create();

        FlxG.cameras.bgColor = FlxColor.BLACK;

        titleText = new FlxText(0, 50, FlxG.width, "Loading Some Assets", 28);
        titleText.setFormat(Paths.font("Frisky"), 28, FlxColor.WHITE, CENTER);
        add(titleText);

        assetText = new FlxText(0, titleText.y + 40, FlxG.width, "", 10);
        assetText.setFormat(Paths.font("Frisky"), 10, FlxColor.WHITE, CENTER);
        add(assetText);

        var rawLines = Assets.getText(Paths.text("loading/cool")).split("\n");
        var coolPhrases = rawLines
            .map(function(line) return line.trim())
            .filter(function(line) return line.length > 0);

        phraseTopLeft = createCornerText(5, 5, randomPhrase(coolPhrases));
        phraseTopRight = createCornerText(FlxG.width - 5, 5, randomPhrase(coolPhrases), RIGHT);
        phraseBottomLeft = createCornerText(5, FlxG.height - 24, randomPhrase(coolPhrases));
        phraseBottomRight = createCornerText(FlxG.width - 5, FlxG.height - 24, randomPhrase(coolPhrases), RIGHT);

        add(phraseTopLeft);
        add(phraseTopRight);
        add(phraseBottomLeft);
        add(phraseBottomRight);

        bfSprite = new FlxSprite();
        bfSprite.frames = FlxAtlasFrames.fromSparrow(
            Paths.image("chars/bf"),
            Paths.file("assets/images/chars/bf.xml")
        );
        bfSprite.animation.addByPrefix("idle", "BF idle", 24, true);
        bfSprite.animation.play("idle");
        bfSprite.setGraphicSize(Std.int(FlxG.height / 2));
        bfSprite.updateHitbox();
        bfSprite.screenCenter(X);
        bfSprite.y = FlxG.height / 2 - bfSprite.height / 2;
        add(bfSprite);

        loadNextAsset();
    }

    function loadNextAsset():Void
    {
        if (loadedAssets >= assetsToLoad.length)
        {
            assetText.text = "Finished Loading! Starting the game...";
            FlxTween.tween(this, { alpha: 0 }, 1.5, {
                onComplete: function(_) {
                    FlxG.switchState(new theTitleState());
                }
            });
            return;
        }

        var currentAsset = assetsToLoad[loadedAssets];
        assetText.text = "Loading: " + currentAsset;

        new FlxTimer().start(0.2, function(_) {
            loadedAssets++;
            loadNextAsset();
        });
    }

    function createCornerText(x:Float, y:Float, text:String, align:FlxTextAlign = LEFT):FlxText
    {
        var txt = new FlxText(x, y, 0, text, 24);
        txt.setFormat(Paths.font("Frisky"), 24, FlxColor.WHITE, align);
        return txt;
    }

    function randomPhrase(phrases:Array<String>):String
    {
        return phrases[Std.int(Math.random() * phrases.length)];
    }
}

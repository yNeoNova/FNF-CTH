package arcade.backend;

import flixel.group.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.math.FlxMath;

class HUD extends FlxTypedGroup<Dynamic>
{
    public var hp:Float = 100; // Starts at 100%
    public var maxHP:Float = 100;

    var cubeBG:FlxSprite;
    var icon:FlxSprite;
    var bar:FlxSprite;
    var hpText:FlxText;

    public function new()
    {
        super();

        // Cube background
        cubeBG = new FlxSprite(-514, 262, Paths.image("theHUD/cube"));
        add(cubeBG);

        // Player icon
        icon = new FlxSprite(-515, 260, Paths.image("theHUD/icons/bf"));
        add(icon);

        // Health bar
        bar = new FlxSprite(-141, 212, Paths.image("theHUD/bar"));
        bar.color = FlxColor.RED; // Color the bar red instead of default black
        add(bar);

        // HP Text ("Name: Bf | Health: XX%")
        hpText = new FlxText(-141, 190, 300, "", 16);
        hpText.setFormat(Paths.font("Frisky"), 16, FlxColor.WHITE, "left");
        add(hpText);

        updateHUD();
    }

    public function updateHUD():Void
    {
        // Clamp HP between 0 and maxHP
        hp = FlxMath.bound(hp, 0, maxHP);

        // Resize the bar by adjusting scale.x based on HP %
        bar.scale.x = hp / maxHP;

        // Color brightness based on HP % (fades darker with lower HP)
        var brightness = FlxMath.bound(hp / maxHP, 0.2, 1); // Avoid fully black → 20% brightness minimum
        bar.color = FlxColor.fromRGBFloat(brightness, 0, 0);

        // Update text
        var percent = Math.floor((hp / maxHP) * 100);
        hpText.text = 'Name: Bf | Health: ${percent}%';
    }

    public function damage(amount:Float):Void
    {
        hp -= amount;
        updateHUD();
    }
}
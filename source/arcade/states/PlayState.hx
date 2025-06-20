package arcade.states;

import flixel.FlxState;
import flixel.FlxSprite;
import backend.Character;
import arcade.backend.HUD;
import flixel.group.FlxGroup;
import flixel.util.FlxTimer;
import flixel.FlxG;

class PlayState extends FlxState
{
    var bf:Character;
    var hud:HUD;
    var notes:FlxGroup;
    var glitchNotes:FlxGroup;
    var background:FlxSprite;

    override public function create():Void
    {
        super.create();

        // BG Image (grayscale, already styled)
        background = new FlxSprite(0, 0);
        background.loadGraphic(Paths.image("notes/bg/BG"));
        add(background);

        // Player
        bf = new Character("BF.json", 200, 300);
        add(bf);

        // HUD
        hud = new HUD();
        add(hud);

        // Notes groups
        notes = new FlxGroup();
        glitchNotes = new FlxGroup();
        add(notes);
        add(glitchNotes);

        // Start spawning notes
        new FlxTimer().start(1, spawnNote, 0); // spawn notes every 1 second
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        bf.updateCharacter();

        for (note in notes.members)
            if (note != null) note.y += 200 * elapsed;

        for (gNote in glitchNotes.members)
            if (gNote != null) gNote.y += 250 * elapsed;
    }

    function spawnNote(tmr:FlxTimer):Void
    {
        var directions = ["down", "left", "up", "right"];
        var dir = FlxG.random.getObject(directions);

        var note = new FlxSprite();
        note.loadGraphic(Paths.image("notes/pixelGray_" + dir));
        note.setPosition(FlxG.random.float(0, FlxG.width - note.width), -note.height);
        notes.add(note);

        // 10% chance of glitch note spawning alongside
        if (FlxG.random.bool(10))
        {
            var glitch = new FlxSprite();
            glitch.loadGraphic(Paths.image("notes/glitch/pixelGray_g" + dir));
            glitch.setPosition(FlxG.random.float(0, FlxG.width - glitch.width), -glitch.height);
            glitchNotes.add(glitch);
        }
    }
}
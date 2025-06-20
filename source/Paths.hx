package;

class Paths
{
    public static inline function image(fileWithoutExt:String):String
        return 'assets/images/' + fileWithoutExt + '.png';

    public static inline function sound(fileWithoutExt:String):String
        return 'assets/sounds/' + fileWithoutExt + '.ogg';

    public static inline function music(fileWithoutExt:String):String
        return 'assets/music/' + fileWithoutExt + '.ogg';

    public static inline function font(fileWithoutExt:String):String
        return 'assets/fonts/' + fileWithoutExt + '.ttf';

    public static inline function text(fileWithoutExt:String):String
        return 'assets/data/texts/' + fileWithoutExt + '.txt';

    public static inline function video(fileWithoutExt:String):String
        return 'assets/videos/' + fileWithoutExt + '.mp4';

    // Raw file path — no extension appended
    public static inline function file(path:String):String
        return path;
}

package 
{
	import org.flixel.*;
	
	/**
	 * This class creates the Sky > FlxTilemap 
	 * @author Néstor Villalobos
	 */
	public class Sky extends FlxTilemap
	{
		[Embed(source = "/assets/tileMap/mapCSV_Level1_Sky.csv",mimeType="application/octet-stream")] public var skyCSV:Class;
		[Embed(source = "/assets/sprites/backdrop.png")] public var skyTilesPNG:Class;
		
		public function Sky()
		{
			super();
			loadMap(new skyCSV, skyTilesPNG, 192, 336);
			setTileProperties(1, FlxObject.NONE);
			scrollFactor.x = 0.4;
			y = -50;
		}
	}
}
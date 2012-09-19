package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	public class WaterTileMap extends FlxTilemap
	{
		[Embed(source = '/tiles/black-tile.png')] private var Graphic:Class;
		//TileMap CSV Class
		[Embed(source = '/tileMap/mapCSV_Group1_water.csv' , mimeType = "application/octet-stream")] private var CSV:Class;
		public function WaterTileMap() 
		{
			loadMap( new CSV, Graphic, 38, 38);
			allowCollisions = FlxObject.UP;
		}
		
	}

}
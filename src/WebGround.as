package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	public class WebGround extends FlxSprite
	{
		[Embed(source = '/sprites/telarañaSuelo(127x18).png')] private var Graphic:Class;
		
		public function WebGround(x:uint,y:uint) 
		{
			this.x = x;
			this.y = y;
			loadGraphic(Graphic, true, true, 127, 18, true);
		}
		
	}

}
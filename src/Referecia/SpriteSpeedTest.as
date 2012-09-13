package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	public class SpriteSpeedTest extends FlxSprite
	{
		[Embed(source = '/sprites/speedTest(2000x153).png')] private var Graphic:Class;
		
		public function SpriteSpeedTest(x:uint, y:uint) {
			this.x = x;
			this.y = y*16;
			loadGraphic(Graphic, true, false, 2000, 153);
			
			
		} 
		
		
	}

}
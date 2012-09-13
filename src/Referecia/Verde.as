package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	public class Verde extends FlxSprite
	{
		[Embed(source = '/sprites/verde(300x150).png')] private var Graphic:Class;
		public function Verde(x:uint, y:uint) 
		{
			this.x = x;
			this.y = y*16;
			loadGraphic(Graphic, true, false, 300, 150);
		}
		
	}

}
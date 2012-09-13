package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	public class BackGround extends FlxSprite
	{
		[Embed(source = '/sprites/cloudBack.png')] private var Graphic:Class;
		public function BackGround(x:uint, y:uint) 
		{
			this.x = x;
			this.y = y;
			loadGraphic(Graphic, false, false, 400, 300);

		}
		
	}

}
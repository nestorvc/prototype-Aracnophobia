package principal
{
	import org.flixel.*;
	
	public class Box extends FlxSprite
	{
		
		public function Box(X:Number, Y:Number) 
		{
			super(X, Y);
			
			makeGraphic(10,12,0xffaa1111);
			acceleration.y = 400;
			drag.x = 200;
			moves = false;
		}
	}
}



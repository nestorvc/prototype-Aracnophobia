package 
{
	import org.flixel.*;

	/**
	 * This class creates the Spider > FlxSprite
	 * @author Néstor Villalobos
	 */
	public class Spider extends FlxSprite
	{
		//Image source for the spider sprite
		[Embed(source = '/assets/sprites/arana.png')] private var aranaPNG:Class;
		
		/**
		 * The constructor of this class.
		 * Creates a Spider > FlxSprite object.
		 * By default values have been setted to the maxVelocity, acceleration and drag properties.
		 * @param Number X coordinate
		 * @param Number Y coordinate
		 */
		public function Spider(X:Number, Y:Number) 
		{
			super(X, Y);
			loadGraphic(aranaPNG, false, false, 120, 240, true);
			
			maxVelocity.x = 75;
			maxVelocity.y = 100;
			/*acceleration.y = 200;*/
			drag.x = maxVelocity.x*2;
		}
	}
}
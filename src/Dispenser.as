package 
{
	import org.flixel.FlxEmitter;
	
	/**
	 * This class creates the debris caused by the destruction left from Spider
	 * @author Néstor Villalobos
	 */
	public class Dispenser extends FlxEmitter
	{
		//Image source for the debris sprite
		[Embed(source='/assets/sprites/gibs.png')] private var ImgGibs:Class;
		
		/**
		 * The constructor of this class.
		 * Creates a FlxEmitter object.
		 * @param Number X coordinate
		 * @param Number Y coordinate
		 * @param Number Max size of particles allowed in this FlxEmitter > FlxGroup. If 0, it is dynamic. 
		 */
		public function Dispenser(X:Number=0, Y:Number=0, Size:Number=0)
		{
			super(X, Y, Size);		
			
			setSize(15,15);
			setXSpeed(-100,100);
			setYSpeed(-20,20);
			gravity = 500;
			bounce = 0.3;
			makeParticles(ImgGibs,200,16,true,0.8);
			start(false,100,0.035);		
		}
	}
}
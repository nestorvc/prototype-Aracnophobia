package principal
{
	import org.flixel.FlxGame;

	[SWF(width="640", height="240", backgroundColor="#000000")]
	
	/**
	 * This class creates the game Aracnophobia > FlxGame 
	 * @author Néstor Villalobos
	 */
	public class Aracnophobia extends FlxGame
	{
		/**
		 * The constructor of this class.
		 * Creates an Aracnophobia > FlxGame object.
		 * By default sets a game of 320x240px, but with zoom X2.
		 * Also sets a 60 FPS.
		 */
		public function Aracnophobia()
		{
			super(320, 120, PlayState, 2, 60, 60);			
			forceDebugger = true;
		}
	}
}
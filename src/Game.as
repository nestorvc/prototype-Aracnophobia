package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	[SWF(width="640", height="360", backgroundColor="#0000FF")]
	public class Game extends FlxGame
	{
		
		public function Game() 
		{
			super( 640, 360,StartState, 1, 60, 60);
			forceDebugger = true;
		}
		
	}
	


}
package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	[SWF(width="800", height="600", backgroundColor="#0000FF")]
	public class Game extends FlxGame
	{		
		public function Game() {
			super( 400, 120,StartState, 2, 60, 60);
			forceDebugger = true;
		}		
	}
}
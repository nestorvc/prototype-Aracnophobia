package principal
{
	import org.flixel.*;
	
	/**
	 * This class creates the game over stage OverStage > FlxState 
	 * @author Néstor Villalobos
	 */
	public class OverState extends FlxState
	{
		public function OverState()
		{
			super();
		}
		
		override public function create():void
		{
			// Background color
			FlxG.bgColor = 0x000000;
			var text:FlxText = new FlxText(130, 50, 100, "GAME OVER");
			
			add(text);
		}
	}
}
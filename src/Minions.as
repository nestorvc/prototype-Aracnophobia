package
{
	import org.flixel.*;
	
	public class Minions extends FlxGroup
	{
		private var fatherMinion:FlxObject;
		
		public function Minions(father:FlxObject, MaxSize:uint=0)
		{
			super(MaxSize);			
			this.fatherMinion = father;
		}
		
		public function launch():void
		{
			var tempMinion:FlxBasic;
			if(getFirstDead() != null){
				tempMinion = getFirstDead();
				var tempMinion2:Minion = tempMinion as Minion;					
				tempMinion2.revive();
				tempMinion2.x = fatherMinion.x+fatherMinion.width;
				tempMinion2.y = fatherMinion.y+fatherMinion.height/2;
				tempMinion2.velocity.y = -tempMinion2.maxVelocity.y;
				tempMinion2.eject();
			} else {
				add(new Minion(fatherMinion.x+fatherMinion.width-20,fatherMinion.y+fatherMinion.height/2));
			}
		}
	}
}
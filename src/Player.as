package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	public class player  extends FlxSprite
	{
	[Embed(source = '/sprites/bichinNuevo(42x71).png')] private var Graphic:Class;
	//image for the player's weapon
	[Embed(source = '/sprites/bullet(15x15).png')] private var WeaponPNG:Class;
	//weapon variable
	public var bullet:FlxWeapon;
	
		public function player(x:uint, y:uint, bulletAmount:uint) 
		{
			this.x = x;
			this.y = y;
			loadGraphic(Graphic, true, true, 42, 71, true);
			addAnimation("Run", [0, 1, 2, 0, 1, 3], 10, false);
			addAnimation("Hurt", [1, 1, 1, 1], 10, true);
			addAnimation("Jump", [0], 0, true);
			addAnimation("RunSmall", [8, 9, 10, 8, 9, 11], 10, true);
			
			//weapon creation with player's x and y position
			bullet = new FlxWeapon("bullet", this, "x", "y");
			//creating weapon sprite with image and providing ammo amount
			bullet.makeImageBullet(bulletAmount, WeaponPNG);
			//bullet direction and speed
			bullet.setBulletDirection(FlxWeapon.BULLET_RIGHT, 400);
			
			maxVelocity.x = 280;
			maxVelocity.y = 420;
			acceleration.y = 460;
			drag.x = maxVelocity.x * 1.5;
			
		}
		
		override public function update():void 
		{

			super.update();
		}
	}

}
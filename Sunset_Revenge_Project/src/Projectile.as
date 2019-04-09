package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	import net.flashpunk.graphics.Spritemap;
	
	public class Projectile extends Entity
	{
		
		[Embed(source="img/bullet.png")]
		private const BULLET_IMG:Class;
		
		[Embed(source="img/knife.png")]
		private const KNIFE_IMG:Class;
		
		private var projectileImage:Image;
		public var isShoot:Boolean;
		public var timeShoot:Number;
		public var controlTimer:Number;
		public var dir:Number;
		public var isBullet:Boolean;
			
		public function Projectile(px:Number = 0, py:Number = 0,pt:Boolean = true,pd:Number = 0) 
		{
			projectileImage = pt ? new Image(BULLET_IMG) : new Image(KNIFE_IMG);
			super(px, py, projectileImage);
			isShoot = false;
			setHitbox(17,10,10,0)
			type = "Bullet";
			timeShoot =  4;
			controlTimer = 0;
			dir = pd;
		}
		
		override public function update():void
		{			
			if (dir)
				x += 250 * FP.elapsed;
			else
				x -= 250 * FP.elapsed;
			/*
			trace(controlTimer);
			if (isShoot) {
				x -= 250 * FP.elapsed;
			}
			else {
				controlTimer++;
				x = this.x + 100;
			}
				
			if (x < 0)
				isShoot = false;
			
			if (Bullet.collide("Barbara", Bullet.x, Bullet.y)) {
				isShoot = false;
			}
			
			
			if (controlTimer == timeShoot) {
				//enemyAnim.play("attack", true);
				controlTimer = 0;
				isShoot = true;
			}
			*/
			
		}
		
	}

}
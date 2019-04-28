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

		public var _remote:Boolean;
		public var _directionL:Boolean;
		public var _targetx:Number;
		public var _targety:Number;
			
		public function Projectile(px:Number = 0, py:Number = 0, pt:Number = 0) 
		{
			projectileImage = pt ? new Image(KNIFE_IMG) : new Image(BULLET_IMG);
			super(px, py, projectileImage);
			if(pt)
				setHitbox(68, 12, 0, 0);
			else
				setHitbox(20, 10, 10, 0);
			type = pt ? "Knife" :"Bullet";
			_remote = false;
			_targetx = 0;
			_targety = 0;
		}
		
		public function setRemote(b:Boolean):void {
			_remote = b;
		}
		
		public function setDirection(d:Boolean):void {
			_directionL= d;
		}
		
		public function setFlip(f:Boolean):void {
			projectileImage.flipped = f;
		}
		
		public function setTarget(px:Number = 0, py:Number = 0):void {
			_targetx = px - x;
			_targety = py - y;
			projectileImage.angle = FP.angle(px, py, x, y);
		}
		
		override public function update():void
		{		
			
			if (_remote) {
				x += Math.cos(Math.atan2(_targety,_targetx))  * 300 * FP.elapsed;
				y += Math.sin(Math.atan2(_targety, _targetx)) * 300 * FP.elapsed;
			}else {
				if (_directionL)
					x -= 500 * FP.elapsed * 1;
				else
					x += 500 * FP.elapsed * 1;
			}
		
		}
		
		public function destroy():void
		{
			// Here we could place specific destroy-behavior for the Bullet.
			FP.world.remove(this);
		}
		
	}

}
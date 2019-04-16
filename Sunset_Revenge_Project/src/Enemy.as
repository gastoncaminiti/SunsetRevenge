package 
{
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.Entity;

	
	public class Enemy extends People
	{
		
		[Embed(source = "img/Enemies.png")]
		private const ENEMI_ANIM:Class;
		
		public  var _aura:Entity;
		private var _shoot:Boolean;
		private var _firerate:Number;
		private var _clockfire:Number;

		public function Enemy(px:Number = 0, py:Number = 0, ax:Number = 200, ay:Number = 200, t:Number = 0) 
		{
			super(px, py, ENEMI_ANIM, 180, 180, "Enemy");
			if (t){
				addAnimation("stand", [7], 10, false);
				addAnimation("walk", [0, 1, 2, 3, 4, 5], 12, false);
				addAnimation("shoot", [6, 5], 5, false);
				addAnimation("shootdown", [8], 5, false);
				addAnimation("dead", [35,36], 5, false);
			}else {
				addAnimation("stand", [17], 10, false);
				addAnimation("walk", [10, 11, 12, 13, 14, 15], 12, false);
				addAnimation("shoot", [16, 15], 5, false);
				addAnimation("shootdown", [18], 5, false);
				addAnimation("dead", [37,38], 5, false);
			}
			playAnimation("stand");
			_aura = new Entity(x, y);
			_aura.setHitbox(ax, ay,ax/2,0);
			_aura.type = "aura";
			_shoot = false;
			_firerate = 18;
			_clockfire = 0;
			setLife(3);
  		}
 
		public function stand():void{
			playAnimation("stand");
		}
		
		public function run():void {
			moveHorizontal("walk",30);
		}
		
		public function shoot():void {
			playAnimation("shoot");
			_shoot = true;
		}
		
		public function shootDown():void {
			playAnimation("shootdown");
			_shoot = true;
		}
		
		public function isTouchAura():Boolean {
			return _aura.collide("Player", _aura.x, _aura.y) as People;
		}
		
		public function canShoot():Boolean {
			return !_shoot;
		}
		
		public function hurt():void {
			setLife(getLife() - 1);
		}
		
		public function isHurt():void {
			var p:Projectile = isTouchProjectile("Knife");
			if (p) {
				hurt();
				p.destroy();
			}
		}
		
		override public function update():void
		{		
			_aura.x = x;
			_aura.y = y;
			
			if (!isTouchAura() && !isDead())
				playAnimation("stand");

			if (_shoot) 
				_clockfire++;
				
			if (_clockfire == _firerate){
				_shoot = false;
				_clockfire = 0;
			}
			
			isHurt();
			
			if (isDead()){
				playAnimation("dead");
				if (collidable) {
					x -= 20;
					y -= 5;
					collidable = false;
					_aura.collidable = false;
				}
			}	
		}

	}

}
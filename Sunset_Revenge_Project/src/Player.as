package 
{
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.Entity;
	import flash.geom.Rectangle;
	import net.flashpunk.utils.Draw;
	
	public class Player extends People
	{
		
		[Embed(source = "img/Player.png")]
		private const PLAYER_ANIM:Class;
		
		public  var _shield:Entity;
		private var _shoot:Boolean;
		private var _firerate:Number;
		private var _clockfire:Number;
		private var _specialreq:Number;
		private var _blockcount:Number;
		
		public function Player(px:Number = 0, py:Number = 0) 
		{
			super(px, py, PLAYER_ANIM, 170, 170, "Player");
			addAnimation("stand", [0], 10, false);
			addAnimation("walk", [0, 1, 2, 1], 10, true);
			addAnimation("crouch", [3], 10, false);
			addAnimation("block", [17], 10, false);
			addAnimation("jump", [7], 10, false);
			addAnimation("melee_atack", [0, 4, 0], 10, false);
			addAnimation("range_atack", [0, 5, 6], 10, false);
			addAnimation("special_atack", [8,9,10,11,8,9,10,11], 10, false);
			addAnimation("dead", [12,13], 0.5, false);
			addAnimation("win", [15,16], 8, false);
			playAnimation("stand");
			setFlip(true);
			_shield = new Entity(x, y);
			_shield.setHitbox(20, 80,-120,-24);
			_shield.type = "shield";
			_shield.collidable = false;
			_shoot = false;
			_firerate = 14;
			_clockfire = 0;
			_blockcount = 0;
			_specialreq = 3;
			setLife(3);
  		}
 
		public function stand():void {
			_shield.collidable = false;
			setHitbox(34, 136, -56, -28);
			_shield.setHitbox(20, 80,-120,-24);
			playAnimation("stand");
		}
		
		public function walkLeft():void{
			setFlip(false);
			setDirection(false);
			_shield.collidable = false;
			setHitbox(34, 136, -56,-28);
			moveHorizontal("walk",10);
		}
		
		public function walkRight():void{
			setFlip(true);
			setDirection(true);
			_shield.collidable = false;
			setHitbox(34, 136, -56,-28);
			moveHorizontal("walk",10);
		}
 
		public function shoot():void{
			playAnimation("range_atack");
			_shoot = true;
		}
		
		public function canShoot():Boolean {
			return !_shoot;
		}
		
		public function canSpecial():Boolean {
			return _specialreq <= _blockcount;
		}
		
		public function block():void {
			_shield.collidable = true;
			if (getFlip())
				_shield.setHitbox(20, 100, -120, -24);
			else
				_shield.setHitbox(20, 100, -20, -24);
			
			playAnimation("block");
		}
		
		public function crouch():void {
			setHitbox(40, 50, -60,-100);
			playAnimation("crouch");
		}

		public function jump():void {
			if(getJump()){
				playAnimation("jump");
				y -= 180;
				setJump(false);
			}
			
		}

		public function atack():void {
			_shield.collidable = true;
			if(getFlip())
				_shield.setHitbox(80, 100, -120, -24);
			else
				_shield.setHitbox(80, 100, 30, -24);
			playAnimation("melee_atack");
		}
		
		public function specialatack():void {
			setHitbox(0, 0, 0, 0);
			_blockcount = 0;
			playAnimation("special_atack");
		}
		
		public function isWalk():Boolean{
			return isAnimation("walk");
		}
		
		public function hurt():void {
			setLife(getLife() - 1);
		}
		
		public function isHurt():void {
			var p:Projectile = isTouchProjectile("Bullet");
			if (p) {
				hurt();
				p.destroy();
			}
		}
		
		public function isBlock():void {
			var p:Projectile = _shield.collide("Bullet", _shield.x, _shield.y) as Projectile;
			if (p) {
				_blockcount++;
				p.destroy();
			}
		}
		
		public function isFloor():void {
			var p:Platform = isTouchFloor("Platform");
			if (p) {
				setGravity(false);
				setJump(true);
				y = p.y - 140;
			}
			else 
				setGravity(true);
		}
		
		override public function update():void
		{	
			_shield.x = x;
			_shield.y = y;
			
			
			if (_shoot) 
				_clockfire++;
				
			if (_clockfire == _firerate){
				_shoot = false;
				_clockfire = 0;
			}
			
			isHurt();
			isBlock();
			isFloor();
			
			if (getGravity() && !isAnimation("special_atack")) {
				y += 5;
				playAnimation("jump");
			}
			
			if (isDead()) {
				playAnimation("dead");
				if (collidable) {
					x -= 20;
					y -= 5;
					collidable = false;
					_shield.collidable = false;
				}
			}
			
		}
	}

}
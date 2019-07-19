package gameclass 
{
	import gameclass.People;
	import gameclass.Platform;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.Entity;
	import flash.geom.Rectangle;
	import net.flashpunk.utils.Draw;
	
	import gamemanager.CameraManager;
	
	public class Player extends gameclass.People
	{
		[Embed(source = "../asset/img/Player.png")]
		private const PLAYER_ANIM:Class;
		
		public  var _shield:Entity;
		private var _shoot:Boolean;
		private var _firerate:Number;
		private var _clockfire:Number;
		private var _specialreq:Number;
		private var _blockcount:Number;
		private var _currentblockcount:Number;
		
		private var MARGIN_LIMIT:int = 20;
		public 	var PLAYER_SIZE:int = 170;
		private var PLAYER_READY_LIFE:int = 5;
		private var PLAYER_FIRERATE:int = 16;
		private var PLAYER_BLOCK_LIMIT:int = 2;
		private var PLAYER_SPECIAL_NEED:int = 3;
		private var PLAYER_MOVE_SPEED:int = 600;
		private var PLAYER_JUMP_FORCE:int = 250;
		private var PLAYER_GRAVITY:int = 8;
		
		public function Player(px:Number = 0, py:Number = 0) 
		{
			super(px, py, PLAYER_ANIM, PLAYER_SIZE, PLAYER_SIZE, "Player");
			addAnimation("stand", [0], 10, false);
			addAnimation("walk", [0, 1, 2, 1], 12, true);
			addAnimation("crouch", [3], 10, false);
			addAnimation("block", [17], 10, false);
			addAnimation("jump", [7], 10, false);
			addAnimation("melee_atack", [0, 4, 0], 10, false);
			addAnimation("range_atack", [0, 5, 6], 12, false);
			addAnimation("range_jump_atack", [20, 21], 10, false);
			addAnimation("special_atack", [8,9,10,11,8,9,10,11], 20, false);
			addAnimation("dead", [12,13,13,13], 2, false);
			addAnimation("win", [18,19], 6, true);
			playAnimation("stand");
			setFlip(true);
			_shield = new Entity(x, y);
			_shield.setHitbox(20, 80,-120,-24);
			_shield.type = "shield";
			_shield.collidable = false;
			_shoot = false;
			_firerate = PLAYER_FIRERATE;
			_clockfire = 0;
			_blockcount = 0;
			_specialreq = PLAYER_SPECIAL_NEED;
			setLife(PLAYER_READY_LIFE);
  		}
 
		public function stand():void {
			_shield.collidable = false;
			setHitbox(34, 136, -56, -28);
			_shield.setHitbox(20, 80,-120,-24);
			playAnimation("stand");
		}
		
		public function can_walk():Boolean {
			if (!isAnimation("block") && !isAnimation("crouch") && !isAnimation("special_atack") && !isAnimation("range_atack"))
				return true;
			else
				return false;
		}

		public function untouch_limit_left():Boolean {
			return x > CameraManager.MAP_LIMIT_X_MIN - PLAYER_SIZE/2 + MARGIN_LIMIT ;
		}

		public function untouch_limit_right():Boolean {
			return x < CameraManager.MAP_LIMIT_X_MAX - PLAYER_SIZE - MARGIN_LIMIT ;
		}
		
		public function walkLeft():void{
			setFlip(false);
			setDirection(false);
			_shield.collidable = false;
			setHitbox(34, 136, -56,-28);
			moveHorizontal("walk",PLAYER_MOVE_SPEED);
		}
		
		public function walkRight():void{
			setFlip(true);
			setDirection(true);
			_shield.collidable = false;
			setHitbox(34, 136, -56,-28);
			moveHorizontal("walk",PLAYER_MOVE_SPEED);
		}
 
		public function shoot():void {
			playAnimation(getJump() ? "range_atack" : "range_jump_atack");
			_shoot = true;
		}
		
		public function canShoot():Boolean {
			if (!_shoot && !isAnimation("block") && !isAnimation("crouch") && !isAnimation("special_atack") && !isAnimation("melee_atack"))
				return true;
			else
				return false;
		}
		
		public function canSpecial():Boolean {
			return _specialreq <= _blockcount;
		}
		
		public function get_blocks():Number {
			return  _blockcount;
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
			_shield.collidable = false;
			setHitbox(40, 70, -60,-100);
			playAnimation("crouch");
		}

		public function jump():void {
			if(getJump()){
				playAnimation("jump");
				y -= PLAYER_JUMP_FORCE;
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
			_blockcount -= PLAYER_SPECIAL_NEED;
			playAnimation("special_atack");
		}
		
		public function isWalk():Boolean{
			return isAnimation("walk");
		}
		
		public function hurt():void {
			if(getLife() != 0) setLife(getLife() - 1);
		}
		
		public function addlife():void {
			setLife(getLife() + 1);
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
			var p:gameclass.Platform = isTouchFloor("Platform");
			if (p) {
				setGravity(false);
				setJump(true);
				y = p.y - PLAYER_SIZE *.95;
				}
			else 
				setGravity(true);
		}
		
		public function isReset():Boolean {
			var p:gameclass.Platform = isTouchFloor("Reset");
			if (p) return true; else return false;
		}
		
		public function isPlayerDeadEnd():Boolean {
			if (isAnimation("dead") && endAnimation())
				return true;
			else
				return false;
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
			
			if (getGravity() && !isAnimation("special_atack") && !isAnimation("range_jump_atack")) {
				y += PLAYER_GRAVITY;
				playAnimation("jump");
			}
			
			if (isDead()) {
				if (!isAnimation("dead")) playAnimation("dead");
				setHitbox(40, 70, -60,-100);
			}
			
			if (isAnimation("range_atack") && endAnimation())
				playAnimation("stand");
				
			if (isAnimation("melee_atack") || isAnimation("block"))
				_shield.collidable = true;
			else
				_shield.collidable = false;
		}
	}
}
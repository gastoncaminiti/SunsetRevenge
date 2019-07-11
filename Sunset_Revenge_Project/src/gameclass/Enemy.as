package gameclass 
{
	/* DEFINICION DE LIBRERIAS FLASHPUNK */
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.Entity;
	/* DEFINICION DE LIBRERIAS DEL VIDEOJUEGO */
	import gameclass.People
	import gamemanager.DataManager;

	/* 	CLASE ENEMIGO
		Comportamiento de detección del jugador y disparos, común a vaqueros y jefes
	*/		
	public class Enemy extends People
	{
		
		public  var _aura:Entity;
		private var _shoot:Boolean;
		private var _firerate:Number;
		private var _clockfire:Number;
		private var _pointshoot:Number;
		private var _pointmelee:Number;
		private var SIZEIMG:Number = 180;

		public function Enemy(new_x:Number, new_y:Number,NEW_IMG:Class, aura_x:Number = 200, aura_y:Number = 200, new_life:Number = 3,new_points:Number = 100, new_pointm:Number = 300) 
		{
			super(new_x, new_y, NEW_IMG, SIZEIMG, SIZEIMG, "Enemy");
			_aura = new Entity(x, y);
			_aura.setHitbox(aura_x, aura_y,aura_x/2,0);
			_aura.type = "aura";
			_shoot = false;
			_firerate = 18;
			_clockfire = 0;
			_pointshoot = new_points;
			_pointmelee = new_pointm;
			setLife(new_life);
  		}
		
		public function set_firerate(new_firerate:Number = 18):void {
			_firerate = new_firerate;
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
			var p: Projectile = isTouchProjectile("Knife");
			if (p) {
				hurt();
				p.destroy();
				DataManager.addScore(_pointshoot);
			}
			
			if (collide("shield", x, y)) {
				hurt();
				DataManager.addScore(_pointmelee);
			}
		}
		
		public function update_aura():void {
			_aura.x = x;
			_aura.y = y;
		}
		
		public function get_clock():Number {
			return _clockfire;
		}
		
		public function get_firerate():Number {
			return _firerate;
		}
		
		public function step_clock():void {
			_clockfire++;
		}
		
		public function reset_clock():void {
			_clockfire = 0;
		}
		
		public function reset_shoot():void {
			_shoot = false;
		}
		
		public function not_collidable():void {
			collidable = false;
			_aura.collidable = false;
		}
	}
}
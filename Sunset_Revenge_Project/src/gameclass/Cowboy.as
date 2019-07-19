package gameclass 
{
	import gameclass.Enemy;
	
	public class Cowboy extends Enemy
	{
		
		[Embed(source = "../asset/img/Cowboy.png")]
		private const COWBOY_ANIM:Class;

		public function Cowboy(px:Number = 0, py:Number = 0, ax:Number = 200, ay:Number = 200, new_flip:Boolean = false, new_firerate:Number = 18, new_type:Number = 0) 
		{
			super(px, py, COWBOY_ANIM, ax, ay);
			if (new_type){
				addAnimation("stand", [7], 10, false);
				addAnimation("walk", [0, 1, 2, 3, 4, 5], 12, false);
				addAnimation("shoot", [6, 5], 5, false);
				addAnimation("shootdown", [8], 5, false);
				addAnimation("dead", [35, 36], 5, false);
				setShootdownStatus(true);
			}else {
				addAnimation("stand", [17], 10, false);
				addAnimation("walk", [10, 11, 12, 13, 14, 15], 12, false);
				addAnimation("shoot", [16, 15], 5, false);
				addAnimation("shootdown", [18], 5, false);
				addAnimation("dead", [37, 38], 5, false);
				setShootdownStatus(false);
			}
			setFlip(new_flip);
			flip_aura();
			set_firerate(new_firerate);
			playAnimation("stand");
		}
   
		override public function update():void
		{		
			/* ACTUALIZAR LA POSICION DEL AURA DEL ENEMIGO */
			update_aura();
			
			if (!isTouchAura() && !isDead())
				playAnimation("stand");

			if (!canShoot()) 
				step_clock();
				
			if (get_clock() == get_firerate()){
				reset_shoot();
				reset_clock();
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
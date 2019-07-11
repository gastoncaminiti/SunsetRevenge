package gameclass 
{
	import gameclass.Enemy;

	public class Boss extends Enemy
	{
		
		[Embed(source = "../asset/img/Steve.png")]
		private const BOSS_ANIM:Class;
		
		

		public function Boss(px:Number = 0, py:Number = 0, ax:Number = 200, ay:Number = 200,  new_type:Number = 0) 
		{
			super(px, py, BOSS_ANIM, ax, ay, 10, 200, 400);
			switch(new_type) {
				case 0:
					addAnimation("stand", [2], 10, false);
					addAnimation("walk", [13, 15, 16,17], 12, false);
					addAnimation("shoot", [13, 14], 5, false);
					addAnimation("shootdown", [7,6], 5, false);
					addAnimation("dead", [8,9,10], 5, false);
				break;
			}
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
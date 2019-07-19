package gameclass 
{
	import gameclass.Enemy;
	import gamemanager.DataManager;

	public class Boss extends Enemy
	{
		
		[Embed(source = "../asset/img/Bosses.png")]
		private const BOSS_ANIM:Class;
		/* DEFINICION DE VARIBLES DE CONTROL DE ACCION */
		private var index_phase:int;
		private var actual_phase:int;
		private var life_status_index:Array;
		private var _clockreaction:Number;
		private var COOLDOWN:Number = 120;
		private var DAMAGE_CONTROL:Number = 0.2;
		private var UNIT_MOVE_X:Number = 200;
		private var GRAVITY:Number = 10;
		/*DEFINICION DE BANDERAS DE ACCION */
		private var can_walk:Boolean;
		private var can_slide:Boolean;
		private var can_jumpshoot:Boolean;
		private var can_rider:Boolean;
		private var in_action:Boolean;
		private var repeat_action:Boolean;
		/*DEFINICION DE VALORES AUXILIARES DE POSICION */
		private var _originx:Number;
		private var _originy:Number;

		public function Boss(px:Number = 0, py:Number = 0, ax:Number = 200, ay:Number = 200, new_life:Number = 10, new_type:String = "Steve") 
		{
			super(px, py, BOSS_ANIM, ax, ay, new_life, 500, 1000);
			switch(new_type) {
				case "Steve":
					addAnimation("stand", [2], 10, false);
					addAnimation("walk", [13, 15, 16,17], 12, true);
					addAnimation("shoot", [13, 14], 5, false);
					addAnimation("shootdown", [7,6], 5, false);
					addAnimation("dead", [8, 9, 10], 5, false);
					can_walk = true;
					can_slide = false;
					can_jumpshoot = false;
					can_rider = false;
					index_phase = 1;
					setFlip(true);
					flip_aura();
					set_firerate(25);
				break;
				case "Bob":
					addAnimation("stand", [19], 10, false);
					addAnimation("shoot", [30, 31], 5, false);
					addAnimation("shootdown", [36, 37], 5, false);
					addAnimation("slide", [24, 25], 5, false);
					addAnimation("jump", [26, 27, 28, 29], 5, false);
					addAnimation("dead", [38, 39], 5, false);
					can_walk = false;
					can_slide = true;
					can_jumpshoot = false;
					can_rider = false;
					index_phase = 2;
				break;
				case "Cormano":
					addAnimation("stand", [40], 10, false);
					addAnimation("shoot", [51, 52], 5, false);
					addAnimation("shootdown", [41, 42], 5, false);
					addAnimation("jumpshoot", [55, 56], 5, false);
					addAnimation("slide", [46, 46], 5, false);
					addAnimation("jump", [47,48,49,50], 5, false);
					addAnimation("dead", [63, 64], 5, false);
					can_walk = false;
					can_slide = true;
					can_jumpshoot = true;
					can_rider = false;
					index_phase = 3;
				break;
				case "Billy":
					addAnimation("stand", [65,66,67], 10, false);
					addAnimation("shoot", [79, 80], 5, false);
					addAnimation("shootdown", [68, 69], 5, false);
					addAnimation("jumpshoot", [83, 84], 5, false);
					addAnimation("slide", [73, 74], 5, false);
					addAnimation("jump", [75, 76, 77, 78], 5, false);
					addAnimation("rider", [101,102], 5, false);
					addAnimation("dead", [107, 88], 5, false);
					can_walk = false;
					can_slide = true;
					can_jumpshoot = true;
					can_rider = true;
					index_phase = 4;
				break;
			}
			_originx = px;
			_originy = py;
			DataManager.setLevelWin(false);
			life_status_index = new Array();
			/*DEFINICION DE FRANJAS DE VIDA PARA CAMBIO DE ACCION (CADA % DE DAÑO RECIBIDO) */
			for (var i:int = 0; i < index_phase ; i++) 
				life_status_index.push(new_life * (1 - DAMAGE_CONTROL - (DAMAGE_CONTROL * i)));
			actual_phase = 0;
			_clockreaction = 0;
			in_action = true;
			repeat_action = false;
			playAnimation("stand");
  		}
		
		override public function update():void
		{	
			if (!isDead()){
				/* ACTUALIZAR LA POSICION DEL AURA DEL ENEMIGO */
				update_aura();
				/* ACTUALIZAR ESTADO DEL JEFE EN FUNCION DEL DAÑO RECIBIDO*/
				if (getLife() < life_status_index[actual_phase]){
					if (actual_phase < index_phase){
						actual_phase++;
						in_action = true;
					}
				}
				/* ----------------------- ACTUALIZAR ACCIONES DEL JEFE -----------------------*/
				/* ACCION DE CAMINAR Y DISPARAR (STEVE) */
				if (can_walk && in_action && actual_phase == 1) {
					set_firerate(20);
					if (getFlip()) {
						if(x < _originx + UNIT_MOVE_X){
							setDirection(true);
							moveHorizontal("walk", UNIT_MOVE_X)
						}else {
							setFlip(false);
							flip_aura();
						}
					}else {
						if(x > _originx - UNIT_MOVE_X){
							setDirection(false);
							moveHorizontal("walk", UNIT_MOVE_X)
						}else {
							setFlip(true);
							flip_aura();
						}
						
					}
				}
				/* ACTUALIZAR TEMPORIZADOR DEL JEFE */
				if (repeat_action) 
					_clockreaction++;
					
				if (_clockreaction == COOLDOWN) {
					_clockreaction = 0;
					repeat_action = false;
				}
					
				if (!isTouchAura() && !isDead() && !in_action)
					playAnimation("stand");

				if (!canShoot()) 
					step_clock();
					
				if (get_clock() == get_firerate()){
					reset_shoot();
					reset_clock();
				}
				isHurt();
			}else{
				playAnimation("dead");
				DataManager.setLevelWin(true);
				not_collidable();
			}	
		}

	}
}



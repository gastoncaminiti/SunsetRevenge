package 
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Entity;
	
	public class GameWorld extends World
	{
		
		/*
		[Embed(source="font/rocknroll.ttf", fontFamily="Roll",embedAsCFF="false")]  
		public static var FONT_TITLE:Class;  
		
		[Embed(source="img/backgroundD.png")]
		protected const BACKD_IMG:Class;
		[Embed(source="img/backgroundN.png")]
		protected const BACKN_IMG:Class;
		protected var backDImage:Image;
		protected var backNImage:Image;
		protected var background:Entity;
		
		protected var plataforma_a:Plataforma;
		protected var coin:Coin;
		
		protected var sol:Sol;
		protected var luna:Luna;
		protected var planta1:GrupoPlantas;
		
		protected var isDay:Boolean;
		protected var isChange:Boolean;
		protected var isAdd:Boolean;
		protected var nChange:Number;
		protected var timeChange:Number;
		
		protected var textTime:String;
		protected var day:Number;
		
		protected var info_text:Text;
		protected var signal:Signal;
		

		[Embed(source = "sound/fondo.mp3")]	
		protected const MUS_MP3:Class;
		protected var musfx:Sfx;
		*/
		[Embed(source="img/Background_Nivel0.png")]
		protected const BACK_IMG:Class;
		protected var backImage:Image;
		protected var background:Entity;
		protected var player:Player;
		protected var enem:Enemy;
		protected var enem2:Enemy;
	
		/* CONTENEDORES DE OBJETOS */
		protected var projectiles:Array;
		private var _aux_projectile:Projectile;

		public function GameWorld() 
		{
			/*

			background = new Entity(0, 0, backDImage);
			this.plataforma_a = new Plataforma(140, 400);
			this.coin = new Coin(550, 360);
			
			this.sol = new Sol(600, 50);
			this.luna = new Luna(600, 50);
			this.signal = new Signal(700, 250);
			this.nChange = 0;
			this.isDay = true;
			this.isAdd = false;
			this.isChange = false;
			this.timeChange = 0;
			this.day = 1;
			this.luna.visible = false;
			this.planta1 = new GrupoPlantas(385, 435, 270);
			this.textTime = "Mañana";
			
			info_text = new Text("Día "+int(day)+" - "+textTime, 0, 0, 600,50);
			info_text.x = 25;
			info_text.y = 20; 
			info_text.color = 0x231f1f;
			info_text.font = "Roll";
			info_text.size = 50;

			musfx = new Sfx(MUS_MP3);
			musfx.play();
			musfx.loop();
			*/
			backImage = new Image(BACK_IMG);
			background = new Entity(0, 0, backImage);
			this.player = new Player(100, 440);
			this.enem = new Enemy(400, 180,220,300);
			this.enem2 = new Enemy(640, 180,220,300,1);
			this.add(background);
			this.add(player);
			this.add(enem);
			this.add(enem2);
			
			//Test de Agregado de proyectiles.
			this.projectiles = new Array();
			this.addList(projectiles);
			/*
			this.add(plataforma_a);
			this.add(coin);
			this.add(sol);
			this.add(luna);
			this.addList(planta1.partes);
			this.addGraphic(info_text);
			*/
		}
		
		override public function update():void
		{
			/*
			musfx.volume = 0.2;
			if (Input.check(Key.Q) && !isChange && day !=1) {
				if (isDay)
					isDay = false;
				else
					isDay = true;
				isChange = true;
				nChange++;
				isAdd = false;
				if (day != 0) day -= 0.5;
			}
			
			if (Input.check(Key.E) && !isChange) {
				if (isDay)
					isDay = false;
				else
					isDay = true;
				isChange = true;
				nChange++;
				isAdd = true;
				day += 0.5;
			}

			if (isChange)
				timeChange+= FP.elapsed;
			
			if (isDay && timeChange  >= 0.5) {
				isChange = false;
				background.graphic = backDImage;
				timeChange = 0;
				this.textTime = "Mañana";
				this.sol.visible = true;
				this.luna.visible = false;
				if (isAdd)
					planta1.addPlant();
				else
					planta1.popPlant();
					
				info_text.text = "Día " + int(day) + " -  " + textTime;
			}
			
			if (!isDay && timeChange >= 0.5) {
				isChange = false;
				background.graphic = backNImage;
				timeChange = 0;
				this.textTime = "Noche";
				this.sol.visible = false;
				this.luna.visible = true;
				if (isAdd)
					planta1.addPlant();
				else
					planta1.popPlant();
					
				info_text.text = "Día " + int(day) + " -  " + textTime;
			}
			
			if (player.isReset)
				FP.world = new GameWorld();
			*/
				
			if (!enem.canShoot() && enem.endAnimation())
				this.enem.stand();
			if (!enem2.canShoot() && enem2.endAnimation())
				this.enem2.stand();
			
			if (enem.isTouchAura() && enem.canShoot()){
				this.enem.shoot();
				_aux_projectile = new Projectile(this.enem.x, this.enem.y + 50);
				_aux_projectile.setDirection(true);
				this.projectiles.push(_aux_projectile);
			}
			
			if (enem2.isTouchAura() && enem2.canShoot()){
				this.enem2.shootDown();
				_aux_projectile = new Projectile(this.enem2.x + 15, this.enem2.y + 100);
				_aux_projectile.setRemote(true);
				_aux_projectile.setTarget(player.x + 90,player.y);
				this.projectiles.push(_aux_projectile);
			}
			
			if (Input.check(Key.K)){
				this.enem.run();
				this.enem2.run();
			}
			
			
			if (Input.check(Key.J)){
				this.enem.shootDown();
				this.enem2.shootDown();
			}
			
			if (!Input.check(Key.ANY) && player.isWalk())
				player.stand();

			if (!Input.check(Key.ANY) && player.endAnimation())
				player.stand();
			else {
				if (Input.check(Key.A))
					player.walkLeft();
				if (Input.check(Key.D))
					player.walkRight();
				if (Input.check(Key.S))
					player.crouch();		
				if (Input.check(Key.Q))
					player.block();
				if (Input.check(Key.W))
					player.jump();
				if (Input.check(Key.E))
					player.atack();
				if (Input.check(Key.F)) {
					player.shoot();
					_aux_projectile = new Projectile(this.player.x + 120 , this.player.y + 50, 1);
					this.projectiles.push(_aux_projectile);
				}
				if (Input.check(Key.R)){
					player.specialatack();	
					_aux_projectile = new Projectile(this.player.x + 120 , this.player.y + 50, 1);
					this.projectiles.push(_aux_projectile);
				}
			}
	
			super.update();
			this.removeAll();
			this.add(background);
			this.addList(projectiles);
			this.add(player);
			this.add(enem);
			this.add(enem2);
			this.add(enem._aura);
			this.add(enem2._aura);
			
			/*
			if (player.isWin) this.add(signal);
			
			this.add(plataforma_a);
			this.add(coin);
			this.add(sol);
			this.add(luna);
			this.addList(planta1.partes);
			this.addGraphic(info_text);
			
			/*
			if (player.x > 780 && player.isWin) {
				musfx.stop();
				FP.world = new GameWorldN1();
			}
			*/
			
		}
		
	}

}
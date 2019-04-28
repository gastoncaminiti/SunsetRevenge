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
		protected var textTime:String;
		protected var day:Number;
		
		
		protected var signal:Signal;
		

		[Embed(source = "sound/fondo.mp3")]	
		protected const MUS_MP3:Class;
		protected var musfx:Sfx;
		*/
		[Embed(source="img/Level1Map.jpg")]
		protected const BACK_IMG:Class;
		protected var backImage:Image;
		protected var background:Entity;
		protected var player:Player;
		/* CONTENEDORES DE OBJETOS */
		protected var projectiles:Array;
		/* CONTENEDORES DE PLATAFORMAS */
		protected var  platforms:Array;
		/* CONTENEDORES DE ENEMIGOS */
		protected var  enemies:Array;
		
		private var _aux_projectile:Projectile;

		/* HUB */
		[Embed(source="font/westtest.ttf", fontFamily="West",embedAsCFF="false")]  
		public static var FONT_TITLE:Class;  
		protected var _infotext:Text;
		[Embed(source="img/HUBborder.png")]
		protected const BORDER_IMG:Class;
		protected var _bordertext:Entity;
		protected var _borderImage :Image;
		
		public function GameWorld() 
		{
			/*
			this.signal = new Signal(700, 250);
			musfx = new Sfx(MUS_MP3);
			musfx.play();
			musfx.loop();
			*/
			backImage = new Image(BACK_IMG);
			background = new Entity(0, 0, backImage);
			this.player = new Player(250, 280);
			_infotext = new Text(" "+ Datamanager.getScore() , 28, 28, 300,50);
			_infotext.color = 0x532100;
			_infotext.font = "West";
			_infotext.size = 26;
			_borderImage = new Image(BORDER_IMG);
			_bordertext = new Entity(5, 5, _borderImage);
			
			this.add(background);
			this.add(player);
			this.add(_bordertext);
			this.addGraphic(_infotext);
			//Test de Agregado de proyectiles.
			this.projectiles = new Array();
			this.addList(projectiles);
			// Definición de Plataformas
			this.platforms = new Array();
			this.platforms.push(new Platform(0, 400, 1220, 10));
			this.platforms.push(new Platform(1387, 490, 50, 10));
			this.platforms.push(new Platform(1495, 490, 135, 10));
			this.platforms.push(new Platform(1738, 490, 50, 10));
			this.platforms.push(new Platform(1895, 490, 195, 10));
			this.platforms.push(new Platform(2240, 490, 50, 10));
			this.platforms.push(new Platform(2390, 490, 180, 10));
			this.platforms.push(new Platform(2860, 380, 520, 10));
			this.platforms.push(new Platform(3587, 366, 190, 10));
			this.platforms.push(new Platform(3520, 616, 2570, 10));
			this.platforms.push(new Platform(4800, 393, 150, 10));
			this.platforms.push(new Platform(5386, 535, 240, 10));
			this.platforms.push(new Platform(2825, 1180, 3760, 10));
			this.platforms.push(new Platform(6010, 1006, 230, 10));
			this.platforms.push(new Platform(5673, 829, 230, 10));
			this.platforms.push(new Platform(5258, 1006, 230, 10));
			this.platforms.push(new Platform(4807, 828, 347, 10));
			this.platforms.push(new Platform(1148, 1070, 1423, 10));
			this.platforms.push(new Platform(0, 1093, 1400, 10));
			// Definición de Enemigos
			this.enemies = new Array();
			this.enemies.push(new Enemy(989, 254, 220, 300));
			this.enemies.push(new Enemy(2420, 350, 220, 300));
			this.enemies.push(new Enemy(3648, 190, 220, 300));
			this.enemies.push(new Enemy(4476, 480, 220, 300));
			this.enemies.push(new Enemy(4844, 220, 220, 300));
			this.enemies.push(new Enemy(5468, 370, 220, 300));
			this.enemies.push(new Enemy(5758, 654, 220, 300));
			this.enemies.push(new Enemy(4931, 654, 220, 300));
			this.enemies.push(new Enemy(2992, 1025, 220, 300));
			this.enemies.push(new Enemy(3115, 1025, 220, 300));
			this.addList(platforms);
			this.addList(enemies);
		}
		
		override public function update():void
		{
			/*
			musfx.volume = 0.2;

			if (player.isReset)
				FP.world = new GameWorld();
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
			*/		
			for (var k:String in enemies){
				if (!enemies[k].canShoot() && enemies[k].endAnimation() && !enemies[k].isDead())
					this.enemies[k].stand();
				
				if (enemies[k].isTouchAura() && enemies[k].canShoot()){
					this.enemies[k].shoot();
					_aux_projectile = new Projectile(this.enemies[k].x, this.enemies[k].y + 50);
					_aux_projectile.setDirection(true);
					this.projectiles.push(_aux_projectile);
				}	
			}
			
			if(!player.isDead()){
				if (!Input.check(Key.ANY) && player.isWalk())
					player.stand();

				if (!Input.check(Key.ANY) && player.endAnimation())
					player.stand();
				else {
					if (Input.check(Key.LEFT))
						player.walkLeft();
					if (Input.check(Key.RIGHT))
						player.walkRight();
					if (Input.check(Key.DOWN))
						player.crouch();	
					if (Input.check(Key.UP))
						player.jump();
					if (Input.check(Key.Q))
						player.block();
					if (Input.check(Key.W))
						player.atack();
					if (Input.check(Key.E) && player.canShoot()) {
						player.shoot();
						_aux_projectile = new Projectile(player.getFlip() ? this.player.x + 130 : this.player.x - 5 , this.player.y + 60, 1);
						_aux_projectile.setFlip(player.getFlip());
						_aux_projectile.setDirection(!player.getFlip());
						this.projectiles.push(_aux_projectile);
					}
					if (Input.check(Key.R) && player.canSpecial()){
						player.specialatack();	
						_aux_projectile = new Projectile(this.player.x + 85 , this.player.y + 85, 1);
						_aux_projectile.setRemote(true);
						_aux_projectile.setTarget(player.x + 85, 0);
						this.projectiles.push(_aux_projectile);
						_aux_projectile = new Projectile(this.player.x + 85 , this.player.y + 85, 1);
						_aux_projectile.setRemote(true);
						_aux_projectile.setTarget(player.x + 85,600);
						this.projectiles.push(_aux_projectile);
						_aux_projectile = new Projectile(this.player.x + 85 , this.player.y + 85, 1);
						_aux_projectile.setRemote(true);
						_aux_projectile.setTarget(0,player.y + 85);
						this.projectiles.push(_aux_projectile);
						_aux_projectile = new Projectile(this.player.x + 85 , this.player.y + 85, 1);
						_aux_projectile.setRemote(true);
						_aux_projectile.setTarget(800,player.y + 85);
						this.projectiles.push(_aux_projectile);
						/*----------------*/
						_aux_projectile = new Projectile(this.player.x + 60, this.player.y + 85, 1);
						_aux_projectile.setRemote(true);
						_aux_projectile.setTarget(-85, 0);
						this.projectiles.push(_aux_projectile);
						_aux_projectile = new Projectile(this.player.x + 60 , this.player.y + 85, 1);
						_aux_projectile.setRemote(true);
						_aux_projectile.setTarget(0,600);
						this.projectiles.push(_aux_projectile);
						_aux_projectile = new Projectile(this.player.x + 60 , this.player.y + 85, 1);
						_aux_projectile.setRemote(true);
						_aux_projectile.setTarget(800,0);
						this.projectiles.push(_aux_projectile);
						_aux_projectile = new Projectile(this.player.x + 60 , this.player.y + 85, 1);
						_aux_projectile.setRemote(true);
						_aux_projectile.setTarget(800,600);
						this.projectiles.push(_aux_projectile);
						
					}
				}
			}
			
			
			Cameramanager.setCameraConfig(player.x, player.y, 300, 400);
			Cameramanager.followCamera();
			
			_infotext.text = "Score:" + Datamanager.getScore();
			_bordertext.x = Cameramanager.getCameraX();
			_bordertext.y =  Cameramanager.getCameraY();
			_infotext.x = _bordertext.x + 20;
			_infotext.y = _bordertext.y + 25;
			
			trace(FP.elapsed);
			
			super.update();
			this.removeAll();
			this.add(background);
			this.add(_bordertext);
			this.addList(projectiles);
			this.addList(platforms);
			this.addList(enemies);
			for (var j:String in enemies) 
				this.add(enemies[j]._aura);
			this.add(player);
			this.add(player._shield);
			this.addGraphic(_infotext);
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
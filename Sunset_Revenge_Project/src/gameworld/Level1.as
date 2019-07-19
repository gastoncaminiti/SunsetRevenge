package gameworld 
{
	/* DEFINICION DE LIBRERIAS FLASHPUNK */
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Entity;
	/* DEFINICION DE LIBRERIAS DEL VIDEOJUEGO */
	import gameclass.*
	import gamemanager.*
	
	public class Level1 extends World
	{
	
		/* VARIABLES DE SONIDOS DEL NIVEL */
		[Embed(source = "../asset/sound/stage1.mp3")]	
		protected const MUS_MP3:Class;
		[Embed(source = "../asset/sound/shoot.mp3")]	
		protected const SHOOT_MP3:Class;
		[Embed(source = "../asset/sound/knife.mp3")]	
		protected const KNIFE_MP3:Class;
		[Embed(source = "../asset/sound/win.mp3")]	
		protected const WIN_MP3:Class;
		protected var musfx:Sfx;
		protected var shootfx:Sfx;
		protected var knifefx:Sfx;
		protected var winfx:Sfx;
		/* VARIABLES DE ENTIDADES BASICAS */
		[Embed(source="../asset/img/Level1Map.jpg")]
		protected const BACK_IMG:Class;
		protected var backImage:Image;
		protected var background:Entity;
		protected var player:Player;
		/*VARIABLE CONTENEDORES DE OBJETOS */
		protected var projectiles:Array;
		protected var life_gui:Array;
		protected var special_gui:Array;
		/*VARIABLE CONTENEDORES DE PLATAFORMAS */
		protected var  platforms:Array;
		/*VARIABLE CONTENEDORES DE ENEMIGOS */
		protected var  enemies:Array;
		private var _aux_projectile:Projectile;
		/* VARIABLES DEL HUB */
		[Embed(source="../asset/font/westtest.ttf", fontFamily="West",embedAsCFF="false")]  
		public static var FONT_TITLE:Class;  
		protected var _infotext:Text;
		protected var _usertext:Text;
		[Embed(source="../asset/img/HUBborder.png")]
		protected const BORDER_IMG:Class;
		protected var _bordertext:Entity;
		protected var _borderImage :Image;
		
		public function Level1() 
		{
			/* CONFIGURACION DE SONIDO DEL NIVEL */
			musfx 	= new Sfx(MUS_MP3);
			shootfx = new Sfx(SHOOT_MP3);
			knifefx = new Sfx(KNIFE_MP3);
			winfx 	= new Sfx(WIN_MP3);
			musfx.play();
			musfx.loop();
			/* CONFIGURACION DE INFORMACION DEL NIVEL */
			DataManager.set_stage(1);
			backImage = new Image(BACK_IMG);
			background = new Entity(0, 0, backImage);
			this.player = new Player(300, 300);
			_infotext = new Text(" "+ gamemanager.DataManager.getScore() , 28, 28, 500,50);
			_infotext.color = 0x532100;
			_infotext.font = "West";
			_infotext.size = 26;
			_usertext = new Text(DataManager.get_username() , 28, 28, 300,50);
			_usertext.color = 0xffffff;
			_usertext.font = "West";
			_usertext.size = 20;
			_borderImage = new Image(BORDER_IMG);
			_bordertext = new Entity(5, 5, _borderImage);
			/* DEFINICION DE PLATAFORMAS DEL NIVEL */
			this.platforms = new Array();
			this.platforms.push(new Platform(0, 455, 1220, 90)); 
			this.platforms.push(new Platform(1200, 590, 1680, 10,0)); 	// Reset Area I
			this.platforms.push(new Platform(1383, 500, 60, 20));
			this.platforms.push(new Platform(1495, 500, 120, 20));
			this.platforms.push(new Platform(1733, 500, 60, 20));
			this.platforms.push(new Platform(1902, 500, 190, 20));
			this.platforms.push(new Platform(2230, 500, 60, 20));
			this.platforms.push(new Platform(2390, 500, 170, 20)); 		// End Risk Platform
			this.platforms.push(new Platform(2850, 400, 530, 20));
			this.platforms.push(new Platform(3320, 430, 190, 190));
			this.platforms.push(new Platform(3587, 366, 190, 10));
			this.platforms.push(new Platform(3525, 605, 2570, 20));
			this.platforms.push(new Platform(4800, 393, 150, 10));
			this.platforms.push(new Platform(5386, 535, 240, 10));		// End First Level
			this.platforms.push(new Platform(2825, 1170, 3777, 20));
			this.platforms.push(new Platform(6010, 1006, 230, 10));
			this.platforms.push(new Platform(5258, 1006, 230, 10));
			this.platforms.push(new Platform(2524, 1200, 300, 10,0)); 	// Reset Area II
			this.platforms.push(new Platform(1180, 1060, 1365, 20));
			this.platforms.push(new Platform(0, 1070, 1200, 20));
			/* DEFINICION DE PROYECTILES DEL NIVEL */
			this.projectiles = new Array();
			/* DEFINICION DE ENEMIGOS DEL NIVEL */
			this.enemies = new Array();
			this.enemies.push(new Cowboy(980, 290, 	350, 120,false,40)); 	//E1 (LEVEL DESING REFERENCE).
			this.enemies.push(new Cowboy(2400, 340, 350, 120, false,35));	//E2
			this.enemies.push(new Cowboy(3640, 180, 450, 120,false,30));	//E3
			this.enemies.push(new Cowboy(4400, 450, 420, 120,false,30));	//E4
			this.enemies.push(new Cowboy(4820, 210, 300, 370,false,30,1));	//E5
			this.enemies.push(new Cowboy(5456, 360, 420, 120,false,25));	//E6
			this.enemies.push(new Cowboy(6075, 820, 420, 120,true,25));		//E7	
			this.enemies.push(new Cowboy(5341, 826, 420, 120,true,25));		//E8
			this.enemies.push(new Cowboy(3705, 660, 300, 440,true,30,1));	//E9
			this.enemies.push(new Cowboy(3390, 1010, 420, 120,true,30));	//E10
			this.enemies.push(new Cowboy(3738, 1010, 420, 120,true,30));	//E11
			this.enemies.push(new Boss(490, 905, 620, 300, 20, "Steve")) 	//BOSS
			/* DEFINICION DE INTERFAZ DE VIDA */
			this.life_gui = new Array();
			for (var i:int = 0; i < player.getLife(); i++) 
				this.life_gui.push(new Feather(200 + (Feather.get_size() * i), 200));
			this.special_gui = new Array();
			/* VINCULANDO ELEMENTOS AL WORLD */
			this.add(background);
			this.add(player);
			this.add(_bordertext);
			this.addGraphic(_infotext);			
			this.addList(platforms);
			this.addList(enemies);
			this.addList(projectiles);
		}
		
		override public function update():void
		{
			/* ACTUALIZACION DE SONIDO*/
			if (musfx.playing) 	 musfx.volume = 0.4;
			if (shootfx.playing) shootfx.volume = 0.5;
			if (knifefx.playing) knifefx.volume = 0.6;
			/* ACTUALIZACION DE ESTADO DE ENEMIGOS */
			for (var k:String in enemies){
				if (!enemies[k].canShoot() && enemies[k].endAnimation() && !enemies[k].isDead())
					this.enemies[k].stand();
				if (enemies[k].isTouchAura() && enemies[k].canShoot()) {
					if (enemies[k].isShootdownStatus() ) {
						if (!this.enemies[k].getFlip() && this.enemies[k].x > player.x + 40) {
							this.enemies[k].shootDown();
							_aux_projectile = new Projectile(this.enemies[k].x + 10 , this.enemies[k].y + 120);
							_aux_projectile.setRemote(true);
							_aux_projectile.setTarget(player.x + player.PLAYER_SIZE/2, player.y);
							this.projectiles.push(_aux_projectile);
							shootfx.play();
						}
						
						if (this.enemies[k].getFlip() && this.enemies[k].x < player.x) {
							this.enemies[k].shootDown();
							_aux_projectile = new Projectile(this.enemies[k].getFlip() ? this.enemies[k].x + 130 : this.enemies[k].x - 5 , this.enemies[k].y + 40);
							_aux_projectile.setRemote(true);
							_aux_projectile.setTarget(player.x + player.PLAYER_SIZE/2, player.y);
							this.projectiles.push(_aux_projectile);
							shootfx.play();
						}
					}else {
						this.enemies[k].shoot();
						_aux_projectile = new Projectile(this.enemies[k].getFlip() ? this.enemies[k].x + 130 : this.enemies[k].x - 5 , this.enemies[k].y + 60);
						_aux_projectile.setFlip(this.enemies[k].getFlip());
						_aux_projectile.setDirection(!this.enemies[k].getFlip());
						this.projectiles.push(_aux_projectile);
						shootfx.play();
					}
				}	
			}
			/* ACTUALIZACION DE ESTADO DEL JUGADOR */
			if(!player.isDead() && !DataManager.isLevelWin()){
				if (!Input.check(Key.ANY) && player.isWalk())
					player.stand();
				if (!Input.check(Key.ANY) && player.endAnimation())
					player.stand();
				else {
					if (Input.check(Key.LEFT)  && player.can_walk() && player.untouch_limit_left() && !Input.check(Key.RIGHT))
						player.walkLeft();
					if (Input.check(Key.RIGHT) && player.can_walk() && player.untouch_limit_right() && !Input.check(Key.LEFT))
						player.walkRight();
					if (Input.check(Key.DOWN))
						player.crouch();	
					if (Input.check(Key.UP))
						player.jump();
					if (Input.check(Key.Q))
						player.block();
					if (Input.check(Key.W)){
						player.atack();
						knifefx.play();
					}
					if (Input.check(Key.E) && player.canShoot()) {
						player.shoot();
						_aux_projectile = new Projectile(player.getFlip() ? this.player.x + 130 : this.player.x - 5 , this.player.y + 60, 1);
						_aux_projectile.setFlip(player.getFlip());
						_aux_projectile.setDirection(!player.getFlip());
						this.projectiles.push(_aux_projectile);
						knifefx.play();
					}
					if (Input.check(Key.R) && player.canSpecial()){
						player.specialatack();	
						_aux_projectile = new Projectile(this.player.x + 85 , this.player.y + 85, 1);
						_aux_projectile.setRemote(true);
						_aux_projectile.setTarget(CameraManager.getCameraX(), CameraManager.getCameraY()); //P1
						this.projectiles.push(_aux_projectile);
						_aux_projectile = new Projectile(this.player.x + 85 , this.player.y + 85, 1);
						_aux_projectile.setRemote(true);
						_aux_projectile.setTarget(CameraManager.getCameraX(),CameraManager.getCameraY() + FP.height/2); //P2
						this.projectiles.push(_aux_projectile);
						_aux_projectile = new Projectile(this.player.x + 85 , this.player.y + 85, 1);
						_aux_projectile.setRemote(true);
						_aux_projectile.setTarget(CameraManager.getCameraX(),CameraManager.getCameraY() + FP.height); //P3
						this.projectiles.push(_aux_projectile);
						_aux_projectile = new Projectile(this.player.x + 85 , this.player.y + 85, 1);
						_aux_projectile.setRemote(true);
						_aux_projectile.setTarget(CameraManager.getCameraX() + FP.width/2,CameraManager.getCameraY());//P4
						this.projectiles.push(_aux_projectile);
						_aux_projectile = new Projectile(this.player.x + 60, this.player.y + 85, 1);
						_aux_projectile.setRemote(true);
						_aux_projectile.setTarget(CameraManager.getCameraX() + FP.width,CameraManager.getCameraY()); //P5
						this.projectiles.push(_aux_projectile);
						_aux_projectile = new Projectile(this.player.x + 60 , this.player.y + 85, 1);
						_aux_projectile.setRemote(true);
						_aux_projectile.setTarget(CameraManager.getCameraX() + FP.width,CameraManager.getCameraY() + FP.height/2);//P6
						this.projectiles.push(_aux_projectile);
						_aux_projectile = new Projectile(this.player.x + 60 , this.player.y + 85, 1);
						_aux_projectile.setRemote(true);
						_aux_projectile.setTarget(CameraManager.getCameraX() + FP.width,CameraManager.getCameraY() + FP.height); //P7
						this.projectiles.push(_aux_projectile);
						_aux_projectile = new Projectile(this.player.x + 60 , this.player.y + 85, 1);
						_aux_projectile.setRemote(true);
						_aux_projectile.setTarget(CameraManager.getCameraX() + FP.width/2,CameraManager.getCameraY() + FP.height);//P8
						this.projectiles.push(_aux_projectile);
						knifefx.play();
					}
				}
			}
			/* ACTUALIZACION DE ESTADO DE LA CAMARA */
			CameraManager.setCameraConfig(player.x, player.y, 300, 400);
			CameraManager.followCamera();
			/* ACTUALIZACION DE ESTADO DEL HUB (SCORE TEXT) */
			_infotext.text = "Score:" + DataManager.getScore();
			_usertext.text = DataManager.get_username();
			_bordertext.x = CameraManager.getCameraX();
			_bordertext.y = CameraManager.getCameraY();
			_infotext.x = _bordertext.x + 20;
			_infotext.y = _bordertext.y + 22;
			_usertext.x = _bordertext.x + 20;
			_usertext.y = _bordertext.y + 5;
			/* ACTUALIZACION DE ESTADO DEL HUB (LIFE BAR)*/
			if (this.life_gui.length > player.getLife())
					this.life_gui.pop();
			if (this.life_gui.length < player.getLife())
					this.life_gui.push(new Feather(200,200));
			/* ACTUALIZACION DE ESTADO DEL HUB (SPECIAL BAR)*/
			if (this.special_gui.length > player.get_blocks())
				this.special_gui.pop();
			if (this.special_gui.length < player.get_blocks())
				this.special_gui.push(new Feather(200,200,0));
			/* ACTUALIZACION DE ESTADO DEL HUB (POSICION BARs)*/	
			for (var h:int = 0; h < this.life_gui.length ; h++) 
			{
				this.life_gui[h].x = _bordertext.x + 280 + (Feather.get_size() * h)
				this.life_gui[h].y = _bordertext.y ;
			}
			for (var g:int = 0; g < this.special_gui.length ; g++) 
			{
					this.special_gui[g].x = _bordertext.x + 280 + (Feather.get_size() * g)
					this.special_gui[g].y = _bordertext.y + Feather.get_size();
			}
			/* VINCULANDO ELEMENTOS AL WORLD */
			super.update();
			this.removeAll();
			this.add(background);
			this.addList(projectiles);
			this.addList(platforms);
			this.addList(enemies);
			for (var j:String in enemies) 
				this.add(enemies[j]._aura);
			this.add(player);
			this.add(player._shield);
			if (!DataManager.isLevelWin()) {
				this.add(_bordertext);
				this.addList(life_gui);
				this.addList(special_gui);
			}
			this.addGraphic(_infotext);
			this.addGraphic(_usertext);
			/* CONDICIONES DE INTERRUPCION DEL NIVEL */
			if (DataManager.isLevelWin()) {
				if (musfx.playing)	musfx.stop();
				if (!winfx.playing) winfx.play();
				player.playAnimation("win");
				_infotext.text = "Highscore x" + DataManager.getScore();
				_infotext.size = 46;
				_infotext.x = CameraManager.getCameraX() + 200;
				_infotext.y = CameraManager.getCameraY() + 50;
				_usertext.text = "Press Enter " + DataManager.get_username();
				_usertext.x = CameraManager.getCameraX() + 300;
				_usertext.y = CameraManager.getCameraY() + 100;
				if (Input.check(Key.ENTER)) {
					winfx.stop();
					FP.world = new Credit();
				}
			}
			if (player.isPlayerDeadEnd() || player.isReset()) {
				DataManager.resetScore();
				FP.world = new Level1();
				musfx.stop();
			}
			
		}
		
	}

}
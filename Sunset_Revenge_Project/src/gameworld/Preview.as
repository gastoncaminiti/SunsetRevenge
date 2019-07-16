package gameworld 
{
	/* DEFINICION DE LIBRERIAS FLASHPUNK */
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.graphics.Spritemap;
	
	import gamemanager.DataManager;
	
	public class Preview extends World
	{
		[Embed(source = "../asset/img/Preview.png")]
		private const INTRO_IMG:Class;
		[Embed(source = "../asset/img/AvatarSteve.png")]
		private const STEVE_IMG:Class;
		[Embed(source = "../asset/img/AvatarBob.png")]
		private const BOB_IMG:Class;
		[Embed(source = "../asset/img/AvatarCormano.png")]
		private const CORMANO_IMG:Class;
		[Embed(source = "../asset/img/AvatarBilly.png")]
		private const BILLY_IMG:Class;
		[Embed(source="../asset/font/westtest.ttf", fontFamily="West",embedAsCFF="false")]  
		private const FONT_TITLE:Class;  
		[Embed(source = "../asset/sound/preview.mp3")]	
		
		private const MUS_MP3:Class;
		private var _introImage:Image;
		private var _introEntity:Entity;
		private var _bossImage:Image;
		private var _bossEntity:Entity;
		private var _infotext:Text;
		private var _stagetext:Text;
		private var _bosstext:Text;
		private var _musfx:Sfx;
		private var _tween:VarTween;
		private var _bossName:String;
		
		public function Preview() 
		{
				_introImage = new Image(INTRO_IMG);
				_introEntity = new Entity(0, 0, _introImage);
					
				switch(DataManager.get_stage()) {
					case 1:
						_bossImage = new Image(STEVE_IMG);
						_bossName  = "Steve";
						_bosstext = new Text(_bossName, 0, 0, 500, 40);
						_bosstext.x = 340;
						_bosstext.color = 0x7e7a08;
					break;
					case 2:
						_bossImage = new Image(BOB_IMG);
						_bossName  = "Bob";
						_bosstext = new Text(_bossName, 0, 0, 500, 40);
						_bosstext.x = 374;
						_bosstext.color = 0x157204;
					break;
					case 3:
						_bossImage = new Image(CORMANO_IMG);
						_bossName  = "Cormano";
						_bosstext = new Text(_bossName, 0, 0, 500, 40);
						_bosstext.x = 310;
						_bosstext.color = 0xa706ae;
					break;
					case 4:
						_bossImage = new Image(BILLY_IMG);
						_bossName  = "Billy";
						_bosstext = new Text(_bossName, 0, 0, 500, 40);
						_bosstext.x = 352;
						_bosstext.color = 0x0a0fa2;
					break;
				}	
				
				_bosstext.y = 240; 
				_bosstext.font = "West";
				_bosstext.size = 46;
				
				_bossEntity = new Entity(358, 120, _bossImage);
				
				_stagetext = new Text("Stage "+DataManager.get_stage(), 0, 0, 500,100);
				_stagetext.x = 284;
				_stagetext.y = 50; 
				_stagetext.font = "West";
				_stagetext.color = 0x501104;
				_stagetext.size = 60;
				
				_infotext = new Text("Press Enter", 0, 0, 500,40);
				_infotext.x = 20;
				_infotext.y = 570; 
				_infotext.color = 0xffffff;
				_infotext.size = 25;
			
				_musfx = new Sfx(MUS_MP3);
				_musfx.play();
			
				_tween = new VarTween();
				_tween.tween(_infotext, "alpha", 1, 2);
				
				this.add(_introEntity);
				this.add(_bossEntity);
				this.addGraphic(_stagetext);
				this.addGraphic(_bosstext);
				this.addGraphic(_infotext);
				this.addTween(_tween);
		}
		
		override public function update():void
		{

			_musfx.volume = 0.4;
			
			if (_infotext.alpha == 0)
				_tween.tween(_infotext, "alpha", 1, 2);
			if (_infotext.alpha == 1)
				_tween.tween(_infotext, "alpha", 0, 2);
			
			if (Input.pressed(Key.ENTER)) {
				_musfx.stop();
				FP.world = new Credit();
			}
			super.update();
		}
	}

}
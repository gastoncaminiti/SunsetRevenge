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
	
	public class Credit extends World
	{
		[Embed(source = "../asset/img/Credit.png")]
		private const INTRO_IMG:Class;
 
		[Embed(source = "../asset/sound/credit.mp3")]	
		protected const MUS_MP3:Class;
		
		[Embed(source="../asset/font/westtest.ttf", fontFamily="West",embedAsCFF="false")]  
		private const FONT_TITLE:Class; 
		
		private var _introImage:Image;
		private var _introEntity:Entity;
		private var _infotext:Text;
		private var _musfx:Sfx;
		private var _tween:VarTween;
		
		public function Credit() 
		{
				_introImage = new Image(INTRO_IMG);
				_introEntity = new Entity(0, 0, _introImage);
				
				_infotext = new Text("Adios Amigo!", 0, 0, 600,100);
				_infotext.x = 140;
				_infotext.y = 150; 
				_infotext.font = "West";
				_infotext.color = 0xf8e800;
				_infotext.size = 80;
				
				_musfx = new Sfx(MUS_MP3);
				_musfx.play();
				_musfx.loop();
				
				_tween = new VarTween();
				_tween.tween(_infotext, "alpha", 1, 2);
				
				this.add(_introEntity);
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

			super.update();
		}
	}

}
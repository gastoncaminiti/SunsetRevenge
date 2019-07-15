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
	
	public class Opening extends World
	{
		[Embed(source = "../asset/img/Opening.png")]
		private const OPENING_ANIM:Class;
		
		private var _openingAnim:Spritemap;
		private var _introEntity:Entity;
		
		
		[Embed(source = "../asset/sound/opening.mp3")]	
		protected const MUS_MP3:Class;
		
		protected var musfx:Sfx;
		
		public function Opening() 
		{
				_openingAnim = new Spritemap(OPENING_ANIM, 800, 600);
				_introEntity = new Entity(0, 0, _openingAnim);
				_openingAnim.add("intro", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 1.2, false)
				_openingAnim.play("intro");
				
				musfx = new Sfx(MUS_MP3);
				musfx.play();
				musfx.loop();
				
				
				this.add(_introEntity);
		}
		
		override public function update():void
		{

			musfx.volume = 0.4;
			if (Input.pressed(Key.ENTER)) {
				musfx.stop();
				FP.world = new Landing();
			}
			super.update();
		}
	}

}
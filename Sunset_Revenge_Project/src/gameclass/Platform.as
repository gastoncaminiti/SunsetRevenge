package gameclass 
{
	import net.flashpunk.Entity;
	
	
	/* 	CLASE PLATAFORMA
		Definicion de plataformas y zonas de reset.
	*/	
	
	public class Platform extends Entity
	{
		
		public function Platform(px:Number = 0, py:Number = 0,w:Number = 0, h:Number = 0 , t:Number = 1) 
		{
			super(px, py);
			setHitbox(w,h,0,0);
			type = t ? "Platform" : "Reset";
		}
		
	}

}
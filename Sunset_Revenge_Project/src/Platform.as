package 
{
	import net.flashpunk.Entity;
	
	public class Platform extends Entity
	{
		
		public function Platform(px:Number = 0, py:Number = 0,w:Number = 0, h:Number = 0) 
		{
			super(px, py);
			setHitbox(w,h,0,0);
			type = "Platform";
		}
		
	}

}
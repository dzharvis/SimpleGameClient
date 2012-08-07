package game.player.graphics 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class Tank extends Sprite 
	{
		[Embed(source = "pics/tank.png")]
		private var TankBitmap:Class;
		
		private var tank:Bitmap = new TankBitmap();
		public function Tank() 
		{
			super();
			addChild(tank);
			tank.x -= tank.width / 2;
			tank.y -= tank.height / 2;
			
		}
		
	}

}
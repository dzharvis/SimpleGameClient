package game.player 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class Tank extends Sprite 
	{
		[Embed(source = "tank.png")]
		private var TankBitmap:Class;
		
		private var tank:Bitmap = new TankBitmap();
		public function Tank() 
		{
			super();
			addChild(tank);
		}
		
	}

}
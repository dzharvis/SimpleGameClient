package game.world 
{
	import flash.display.Shape;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class BlackTile extends Shape 
	{
		
		public function BlackTile() 
		{
			super();
			graphics.beginFill(0x333333);
			graphics.drawRect(0, 0, 100, 100);
		}
		
	}

}
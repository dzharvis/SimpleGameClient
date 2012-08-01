package game.player 
{
	import flash.display.Sprite;
	import game.world.MainMap;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class Player extends Sprite 
	{
		private var tank:Tank;
		private var map:MainMap;
		private var index:int = -1;
		
		public function Player(map:MainMap) 
		{
			super();
			this.map = map;		
		}
		
	}

}
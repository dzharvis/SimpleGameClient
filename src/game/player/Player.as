package game.player 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import game.world.MainMap;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class Player extends Sprite 
	{
		private var tank:Tank = new Tank();
		private var map:MainMap;
		public var index:int = -1;
		
		public static var LEFT:String = "left";
		public static var RIGHT:String = "right";
		public static var UP:String = "up";
		public static var DOWN:String = "down";
		
		private var up:Boolean = false;
		private var right:Boolean = false;
		private var down:Boolean = false;
		private var left:Boolean = false;
		
		private var speed:int = 3;
		
		public function Player(map:MainMap, index:int) 
		{
			super();
			this.map = map;
			this.index = index;
			addChild(tank);
		}
		
		public function setSpeed(s:int):void {
			speed = s;
		}
		
		public function addDirection(direction:String):void {
			switch(direction) {
				case UP: {
					up = true;
					break;
				}
				case RIGHT: {
					right = true;
					break;
				}
				case DOWN: {
					down = true;
					break;
				}
				case LEFT: {
					left = true;
					break;
				}
			}
			
			addEventListener(Event.ENTER_FRAME, moveAnim);
		}
		
		public function removeDirection(direction:String):void {
			switch(direction) {
				case UP: {
					up = false;
					break;
				}
				case RIGHT: {
					right = false;
					break;
				}
				case DOWN: {
					down = false;
					break;
				}
				case LEFT: {
					left = false;
					break;
				}
			}
			if (up == false && right == false && down == false && left == false) removeEventListener(Event.ENTER_FRAME, moveAnim);
		}
		
		private function moveAnim(e:Event):void 
		{
			if (up) {
				y -= speed;
				return
			}
			if (right) {
				x += speed;
			}
			if (down) {
				y += speed;
			}
			if (left) {
				x -= speed;
			}
		}
		
		
		
	}

}
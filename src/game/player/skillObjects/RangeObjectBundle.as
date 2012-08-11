package game.player.skillObjects {
	import flash.display.Bitmap;
	import game.player.Player;
	import game.WorldManager;
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class RangeObjectBundle {
		
		public var skillName:String;
		public var btm:Bitmap;
		public var skillDeployer:Player;
		public var target:Player;
		public var dispatch:Boolean = false;
		public var manager:WorldManager;
		public var skillIndex:int;
		public var speed:Number;
		
		public function RangeObjectBundle() {
			
		}
		
	}

}
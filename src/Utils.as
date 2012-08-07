package  {
	import game.player.Player;
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class Utils {
		
		public function Utils() {
			
		}
		
		public static function calcDistance(p1:Player, p2:Player):Number {
			var _x:Number = p2.x - p1.x;
			var _y:Number = p2.y - p1.y;
			return Math.sqrt((_x*_x) + (_y*_y));
		}
		
	}

}
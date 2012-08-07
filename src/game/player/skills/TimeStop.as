package game.player.skills {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import game.player.Player;
	import game.WorldManager;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class TimeStop extends Skill {
		[Embed(source = "pics/Time.jpg")]
		private var Time:Class;
		private var timeBitmap:Bitmap = new  Time();		
		private var timeIcon:Sprite = new Sprite();
		
		private var _cooldownTime:int = 2000;
		
		public function TimeStop(manager:WorldManager) {
			addChild(timeIcon);
			timeBitmap.smoothing = true;
			timeIcon.addChild(timeBitmap);
			timeIcon.scaleX = timeIcon.scaleY = 100/timeIcon.width;
			super(manager);
			_cooldown = 60000;
			setDistance(600);
		}
		
		
	}

}
package game.player.skills {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import game.player.Player;
	import game.player.skills.basic.Skill;
	import game.WorldManager;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class TimeStop extends Skill {
		[Embed(source = "pics/Time.jpg")]
		private var Time:Class;
		private var timeBitmap:Bitmap = new  Time();
		
		public function TimeStop(manager:WorldManager) {

			super(manager, 300, 60000, 0, "time stop", timeBitmap);
		}
		override public function deploy(b:Object):void {
			if (manager.getPlayer(b.values[0]) == manager.getPlayer()) {
				beginCooldown();
			}
		}
	}

}
package game.player.skills {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import game.Bundle;
	import game.player.Player;
	import game.WorldManager;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class SkillBar extends Sprite {
		
		
		
		private var manager:WorldManager;
		private var timeStop:TimeStop;
		private var rocket:SelfGuidedRocket;

		
		
		public function SkillBar(manager:WorldManager) {
			super();
			timeStop = new TimeStop(manager);
			rocket = new SelfGuidedRocket(manager);
			this.manager = manager;
			addChild(timeStop);
			addChild(rocket);
			rocket.x = timeStop.width + 5;
			timeStop.addEventListener(MouseEvent.CLICK, slowTimeListener);
			rocket.addEventListener(MouseEvent.CLICK, rocketListener);
		}
		
		public function deploySkill(type:String):void {
			
		}
		
		private function rocketListener(e:MouseEvent=null):void {
			if (manager.target == null) {
				return;
			} else {
				var b:Bundle = new Bundle("rocket");
				manager.sendBundle(b);
				var p:Player = manager.getPlayer();
			}	
			
		}	
		
		private function slowTimeListener(e:MouseEvent=null):void {
			if (timeStop.skillAvailable()) {
				var b:Bundle = new Bundle("slow time");
				manager.sendBundle(b);
				timeStop.beginCooldown();
			}
			
		}
		
	}

}
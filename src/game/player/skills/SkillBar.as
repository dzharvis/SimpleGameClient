package game.player.skills {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
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
		private var mStage:Stage;

		
		
		public function SkillBar(manager:WorldManager) {
			super();
			timeStop = new TimeStop(manager);
			rocket = new SelfGuidedRocket(manager);
			this.manager = manager;
			//this.mStage = stage;
			addChild(timeStop);
			addChild(rocket);
			rocket.x = timeStop.width + 5;
			timeStop.addEventListener(MouseEvent.CLICK, slowTimeListener);
			rocket.addEventListener(MouseEvent.CLICK, rocketListener);
		}
		
		public function deploySkill(b:Object):void {
			var _who:Player = manager.getPlayer(b.values[0]);
			var _target:Player = manager.getPlayer(b.values[1]);
			var skillIndex:int = b.values[2];
			
			if (_who == manager.getPlayer()) {
				if(rocket.skillAvailable()){
					rocket.deploy(_who, _target, true, skillIndex);
					rocket.beginCooldown();
				}
			} else {
				rocket.deploy(_who, _target, false, -1);
			}
			
			
		}
		
		private function rocketListener(e:MouseEvent=null):void {
			if (manager.target == null) {
				return;
			} else {
				if(rocket.distance >= Utils.calcDistance(manager.getPlayer(), manager.target)){
					var b:Bundle = new Bundle("rocket permission");
					manager.sendBundle(b);
					var p:Player = manager.getPlayer();
				}
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
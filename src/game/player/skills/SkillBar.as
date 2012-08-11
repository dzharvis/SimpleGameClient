package game.player.skills {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import game.Bundle;
	import game.player.Player;
	import game.player.skills.basic.Skill;
	import game.WorldManager;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class SkillBar extends Sprite {
		
		private var manager:WorldManager;
		private var timeStop:TimeStop;
		private var rocket:SelfGuidedRocket;
		private var heavy:HeavyMissile;
		private var heavyArmor:HeavyArmor;
		
		public function SkillBar(manager:WorldManager) {
			super();
			timeStop = new TimeStop(manager);
			rocket = new SelfGuidedRocket(manager);
			heavy = new HeavyMissile(manager);
			heavyArmor = new HeavyArmor(manager);
			addChild(heavyArmor);
			addChild(heavy);
			this.manager = manager;
			addChild(timeStop);
			addChild(rocket);
			rocket.x = timeStop.width + 5;
			heavy.x = rocket.x + rocket.width + 5;
			heavyArmor.x = heavy.x + heavy.width + 5;
		}
		
		public function handleBundle(bundle:Object):void {
			var s:Skill;
			switch (bundle.header) {
				case "rocket":  {
					s = rocket;
					break;
				}
				case "slow time": {
					s = timeStop;
					break;
				}
				case "heavy missile": {
					s = heavy;
					break;
				}
				case "heavy armor": {
					s = heavyArmor;
					break;
				}
			}
			if (s != null) s.deploy(bundle);
		}
	
	}

}
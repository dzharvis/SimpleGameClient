package game.player.skills.basic {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import game.player.skillObjects.RangeObjectBundle;
	import game.WorldManager;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class RangeSkill extends Skill {
		
		public function RangeSkill(manager:WorldManager, distance:Number, cooldown:int, speed:Number, name:String, icon:Bitmap) {
			super(manager, distance, cooldown, speed, name, icon);
		
		}
		
		protected function constructSkillBundle(b:Object, btm:Bitmap):RangeObjectBundle {
			var skillBundle:RangeObjectBundle = new RangeObjectBundle();
			
			skillBundle.skillDeployer = manager.getPlayer(b.values[0]);
			skillBundle.target = manager.getPlayer(b.values[1]);
			skillBundle.skillIndex = b.values[2];
			skillBundle.btm = btm;
			skillBundle.manager = manager;
			skillBundle.skillName = skillName;
			skillBundle.speed = speed;
			
			if (skillBundle.skillDeployer == manager.getPlayer()) {
				skillBundle.dispatch = true;				
			}
			return skillBundle;
		}
		
		override public function skillAvailable():Boolean {
			if (manager.target == null)
				return false;
			if (super.skillAvailable()) {
				if (getDistance() >= Utils.calcDistance(manager.getPlayer(), manager.target)) {
					return true;
				} else {
					return false;
				}
			}
			return false;
		}
	
	}

}
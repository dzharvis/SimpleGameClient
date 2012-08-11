package game.player.skills {
	import flash.display.Bitmap;
	import game.player.skillObjects.RangeHeavyObject;
	import game.player.skillObjects.RangeObjectBundle;
	import game.player.skills.basic.RangeSkill;
	import game.WorldManager;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class HeavyMissile extends RangeSkill {
		
		[Embed(source = "pics/heavyIcon.jpg")]
		private var Heavy:Class;
		private var heavyIcon:Bitmap = new Heavy();
		
		[Embed(source="pics/heavy.png")]
		private var HeavyBtm:Class;
		private var heavyObj:Bitmap = new HeavyBtm();
		
		public function HeavyMissile(manager:WorldManager) {
			super(manager, 250, 10000, .1, "heavy missile", heavyIcon);
			
		}
		
		override public function deploy(b:Object):void {
			
			var rangeObjBundle:RangeObjectBundle = constructSkillBundle(b, heavyObj);
			if (rangeObjBundle.skillDeployer == manager.getPlayer()) {
				beginCooldown();
			}			
			var r:RangeHeavyObject = new RangeHeavyObject(rangeObjBundle);
			manager.addChild(r);
			r.deploy();
		}
		
	}

}
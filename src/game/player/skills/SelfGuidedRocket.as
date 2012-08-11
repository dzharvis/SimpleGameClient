package game.player.skills {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import game.player.Player;
	import game.player.skillObjects.RangeHeavyObject;
	import game.player.skillObjects.RangeObject;
	import game.player.skillObjects.RangeObjectBundle;
	import game.player.skills.basic.RangeSkill;
	import game.WorldManager;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class SelfGuidedRocket extends RangeSkill {
		[Embed(source="pics/RocketJeep.jpg")]
		private var Rocket:Class;
		private var rocketBitmap:Bitmap = new  Rocket();
		
		[Embed(source = "pics/rkaaxelgear.png")]
		private var RocketGraphics:Class;
		private var rocketGr:Bitmap = new  RocketGraphics();
		
		public function SelfGuidedRocket(manager:WorldManager) {		
			super(manager, 250, 500, .3, "rocket", rocketBitmap);
		}
		
		override public function deploy(b:Object):void {
			
			var rangeObjBundle:RangeObjectBundle = constructSkillBundle(b, rocketGr);
			if (rangeObjBundle.skillDeployer == manager.getPlayer()) {
				beginCooldown();
			}			
			var r:RangeObject = new RangeObject(rangeObjBundle);
			manager.addChild(r);
			r.deploy();
		}
		
	}

}
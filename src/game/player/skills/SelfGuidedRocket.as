package game.player.skills {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import game.player.Player;
	import game.player.skillObjects.RocketObject;
	import game.WorldManager;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class SelfGuidedRocket extends Skill {
		[Embed(source="pics/RocketJeep.jpg")]
		private var Rocket:Class;
		private var rocketBitmap:Bitmap = new  Rocket();		
		private var rocketIcon:Sprite = new Sprite();
		
		private var _cooldownTime:int = 2000;
		private var mStage:Stage;
		private var manager:WorldManager;
		private var target:Player;
		private var event:Boolean;
		
		public function SelfGuidedRocket(manager:WorldManager) {
			this.manager = manager;
			addChild(rocketIcon);			
			rocketBitmap.smoothing = true;
			rocketIcon.addChild(rocketBitmap);
			rocketIcon.scaleX = rocketIcon.scaleY = 100/rocketIcon.width;
			super(manager);
			setDistance(500);
		}
		
		public function deploy(who:Player, target:Player, event:Boolean, skillIndex:int):void {
			var r:RocketObject = new RocketObject(who, target, event, manager, skillIndex);
			manager.addChild(r);
			r.deploy();			
		}
		
	}

}
package game.player.skills {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import game.player.Player;
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
		
		public function SelfGuidedRocket(manager:WorldManager) {
			addChild(rocketIcon);			
			rocketBitmap.smoothing = true;
			rocketIcon.addChild(rocketBitmap);
			rocketIcon.scaleX = rocketIcon.scaleY = 100/rocketIcon.width;
			super(manager);
			setDistance(500);
		}
		
	}

}
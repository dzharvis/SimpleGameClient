package game.player.skillObjects {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import game.Bundle;
	import game.player.Player;
	import game.WorldManager;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class RangeObject extends Sprite {
		private var iniX:Number;
		private var iniY:Number;
		private var btm:Bitmap;

		protected var bundle:RangeObjectBundle;
		private var startTime:Number;
		
		public function RangeObject(bundle:RangeObjectBundle) {
			this.bundle = bundle;
			this.btm = new Bitmap(bundle.btm.bitmapData.clone());		
			addChild(this.btm);
		}
		
		public function deploy():void {
			addEventListener(Event.ENTER_FRAME, rocketFly);
			iniX = bundle.skillDeployer.x;
			iniY = bundle.skillDeployer.y;
			startTime = new Date().getTime();
		}
		
		protected function getUnitVector():MyVector {
			var vec:MyVector = new MyVector(bundle.target.x - x, bundle.target.y - y);
			return vec.unitVector;
		}
		
		private function rocketFly(e:Event):void {
			if (bundle.target == null) {
				removeEventListener(Event.ENTER_FRAME, rocketFly);
				if(this.parent!=null) bundle.manager.removeChild(this);
				return;
			}
			var unitVec:MyVector = getUnitVector();
			
			var timeDiff:Number = new Date().getTime() - startTime;
			startTime = new Date().getTime();
			
			x = iniX + (timeDiff * unitVec.x * bundle.speed);
			y = iniY + (timeDiff * unitVec.y * bundle.speed);
			
			iniX = x;
			iniY = y;
			
			rotation = unitVec.getRotation();
			
			if (hitTestObject(bundle.target.tank)) {
				removeEventListener(Event.ENTER_FRAME, rocketFly);
				bundle.manager.removeChild(this);
				if (bundle.dispatch) {
					var b:Bundle = new Bundle(bundle.skillName, "skill");
					b.pushValue("hit");
					b.pushValue(bundle.skillIndex);
					bundle.manager.sendBundle(b);
				}
			}
		}
		
		
	}

}
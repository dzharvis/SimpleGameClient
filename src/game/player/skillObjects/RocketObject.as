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
	public class RocketObject extends Sprite {
		static public const SPEED:Number = .2;
		private var who:Player;
		private var target:Player;
		private var event:Boolean;
		
		[Embed(source = "pics/rkaaxelgear.png")]
		private var RObject:Class;
		private var btm:Bitmap = new RObject();
		private var manager:WorldManager;
		private var skillIndex:int;
		private var iniX:Number;
		private var iniY:Number;
		private var startTime:Number;
		
		public function RocketObject(who:Player, target:Player, event:Boolean, manager:WorldManager, skillIndex:int) {
			this.skillIndex = skillIndex;
			this.manager = manager;
			this.event = event;
			this.target = target;
			this.who = who;			
			addChild(btm);
		}
		
		public function deploy():void {
			addEventListener(Event.ENTER_FRAME, rocketFly);
			iniX = who.x;
			iniY = who.y;
			startTime = new Date().getTime();
		}
		
		private function rocketFly(e:Event):void {
			var vec:MyVector = new MyVector(target.x - x, target.y - y);
			var unitVec:MyVector = vec.unitVector;
			
			var timeDiff:Number = new Date().getTime() - startTime;
			startTime = new Date().getTime();
			
			x = iniX + (timeDiff * unitVec.x * SPEED);
			y = iniY + (timeDiff * unitVec.y * SPEED);
			
			iniX = x;
			iniY = y;
			
			rotation = unitVec.getRotation();
			
			if (hitTestObject(target.tank)) {
				removeEventListener(Event.ENTER_FRAME, rocketFly);
				manager.removeChild(this);
				if (event) {
					var b:Bundle = new Bundle("rocket hit", "skill");
					b.pushValue(skillIndex);
					manager.sendBundle(b);
				}
			}
		}
		
		
	}

}
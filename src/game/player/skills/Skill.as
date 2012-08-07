package game.player.skills {
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;
	import game.player.Player;
	import game.WorldManager;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class Skill extends Sprite {
		
		protected var _cooldown:int;
		protected var _distance:int;
		private var lastTimeUsed:Number;
		private var timer:Timer;
		private var shadow:Sprite = new Sprite();
		private var timeLeft:TextField = new TextField();
		private var manager:WorldManager;
		private var circle:Shape = new Shape;
		
		public function Skill(manager:WorldManager) {
			super();
			this.manager = manager;
			_cooldown = 5000;
			_distance = 200;
			lastTimeUsed = new Date().getTime()-3600000;
			shadow.graphics.beginFill(0x000000, .5);
			shadow.graphics.drawRect(0, 0, width, height);
			timeLeft.autoSize = TextFieldAutoSize.LEFT;
			timeLeft.textColor = 0xffffff;
			timeLeft.selectable = false;
			shadow.addChild(timeLeft);
			circle.graphics.lineStyle(5, 0x00ff00);
			circle.graphics.drawCircle(0, 0, _distance);
			addEventListener(MouseEvent.MOUSE_OVER, overListener);
			addEventListener(MouseEvent.MOUSE_OUT, outListener);
		}
		
		private function outListener(e:MouseEvent):void {
			manager.getPlayer().removeChild(circle);
		}
		
		
		private function overListener(e:MouseEvent):void {
			manager.getPlayer().addChild(circle);
		}
		
		public function get cooldown():int {
			return _cooldown;
		}
		
		public function get distance():int {
			return _distance;
		}
		
		protected function setDistance(value:int):void {
			_distance = value;
			circle.graphics.clear();
			circle.graphics.lineStyle(5, 0x00ff00);
			circle.graphics.drawCircle(0, 0, _distance);
		}
		
		public function beginCooldown():void {
			lastTimeUsed = new Date().getTime();
			timer = new Timer(1000, cooldown / 1000);
			timer.addEventListener(TimerEvent.TIMER, countDown);			
			addChild(shadow);
			timer.start();
		}
		
		private function countDown(e:TimerEvent):void {
			
			timeLeft.text = (int)((cooldown - (new Date().getTime() - lastTimeUsed)) / 1000);
			
			timeLeft.scaleX = timeLeft.scaleY = 1;
			if (timeLeft.width / timeLeft.height / height > width / height) {
				timeLeft.scaleX = timeLeft.scaleY = width / timeLeft.width;
			} else {
				timeLeft.scaleX = timeLeft.scaleY = height / timeLeft.height;
			}
			timeLeft.x = width / 2 - timeLeft.width / 2;
			timeLeft.y = height / 2 - timeLeft.height / 2;
			if (skillAvailable()) {
				timer.stop();
				removeChild(shadow);
				timeLeft.text = "";
			}
		}
		
		public function skillAvailable():Boolean {
			if ((new Date().getTime() - lastTimeUsed) >= cooldown) return true;
			return false;
		}
		
		
	}

}
package game.player.skills.basic {
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;
	import game.Bundle;
	import game.player.Player;
	import game.WorldManager;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class Skill extends Sprite {
		
		private var cooldown:int;
		private var distance:int;
		private var lastTimeUsed:Number;
		private var timer:Timer;
		private var shadow:Sprite = new Sprite();
		private var timeLeft:TextField = new TextField();
		protected var manager:WorldManager;
		private var circle:Shape = new Shape;
		private var icon:Bitmap;
		protected var speed:Number;
		protected var skillName:String;
		
		public function Skill(manager:WorldManager, distance:Number, cooldown:int, speed:Number, skillName:String, icon:Bitmap) {
			super();
			this.speed = speed;
			this.icon = icon;
			this.skillName = skillName;
			this.manager = manager;
			this.cooldown = cooldown;
			this.distance = distance;
			lastTimeUsed = new Date().getTime() - cooldown;
			
			addChild(icon);
			icon.smoothing = true;
			icon.scaleX = icon.scaleY = 100 / icon.width;
			
			shadow.graphics.beginFill(0x000000, .5);
			shadow.graphics.drawRect(0, 0, width, height);
			timeLeft.autoSize = TextFieldAutoSize.LEFT;
			timeLeft.textColor = 0xffffff;
			timeLeft.selectable = false;
			shadow.addChild(timeLeft);
			circle.graphics.lineStyle(5, 0x00ff00);
			circle.graphics.drawCircle(0, 0, distance*2);
			addEventListener(MouseEvent.MOUSE_OVER, overListener);
			addEventListener(MouseEvent.MOUSE_OUT, outListener);
			addEventListener(MouseEvent.CLICK, clickListener);
		}
		
		private function clickListener(e:MouseEvent):void {
			if(skillAvailable()){
				var b:Bundle = new Bundle(skillName, "skill");
				b.pushValue("permission");
				manager.sendBundle(b);
			}
		}
		
		private function outListener(e:MouseEvent):void {
			manager.getPlayer().removeChild(circle);
		}
		
		public function deploy(b:Object):void {
			
		}
		
		
		
		private function overListener(e:MouseEvent):void {
			manager.getPlayer().addChild(circle);
		}
		
		public function getCooldown():int {
			return cooldown;
		}
		
		public function getDistance():int {
			return distance;
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
				if(shadow.parent!=null) removeChild(shadow);
				timeLeft.text = "";
			}
		}
		
		public function skillAvailable():Boolean {
			if ((new Date().getTime() - lastTimeUsed) >= cooldown) return true;
			return false;
		}
		
		
	}

}
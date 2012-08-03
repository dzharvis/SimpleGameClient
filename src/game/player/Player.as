package game.player 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import game.world.MainMap;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class Player extends Sprite 
	{
		private var tank:Tank = new Tank();
		private var map:MainMap;
		public var index:int = -1;
		
		private var nickname:String;
		
		public static var LEFT:String = "left";
		public static var RIGHT:String = "right";
		public static var UP:String = "up";
		public static var DOWN:String = "down";
		
		private var up:Boolean = false;
		private var right:Boolean = false;
		private var down:Boolean = false;
		private var left:Boolean = false;
		
		private var speed:int = 5;
		private var rotationSpeed:int = 10;
		
		public function Player(map:MainMap, index:int) 
		{
			super();
			this.map = map;
			this.index = index;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		public function setName(name:String):void {
			this.nickname = name;
			showName();
		}
		
		private function showName():void 
		{
			var t:TextField = new TextField();
			t.text = nickname;
			t.autoSize = TextFieldAutoSize.LEFT;
			t.background = true;
			t.backgroundColor = 0xcccccc;
			t.alpha = .8;
			addChild(t);
			t.x = -t.width/2;
			t.y = -tank.height/2 - t.height-5;
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(tank);
			//tank.scaleX = tank.scaleY = (100 * map.scaleX) / tank.width;
			
			//tank.x -= tank.width / 2;
			//tank.y -= tank.height / 2;
		}
		
		public function setSpeed(s:int):void {
			speed = s;
		}
		
		public function addDirection(direction:String):void {
			switch(direction) {
				case UP: {
					up = true;
					break;
				}
				case RIGHT: {
					right = true;
					break;
				}
				case DOWN: {
					down = true;
					break;
				}
				case LEFT: {
					left = true;
					break;
				}
			}
			
			addEventListener(Event.ENTER_FRAME, moveAnim);
		}
		
		public function removeDirection(direction:String):void {
			switch(direction) {
				case UP: {
					up = false;
					break;
				}
				case RIGHT: {
					right = false;
					break;
				}
				case DOWN: {
					down = false;
					break;
				}
				case LEFT: {
					left = false;
					break;
				}
			}
			if (up == false && right == false && down == false && left == false) removeEventListener(Event.ENTER_FRAME, moveAnim);
		}
		
		private function moveAnim(e:Event):void 
		{
			if (up) {
				if (tank.rotation > 90 || ((tank.rotation >= -180||tank.rotation <= 180) && tank.rotation < -90)) {
					tank.rotation += rotationSpeed;
				} else if (tank.rotation <= 90 && tank.rotation > -90) {
					tank.rotation -= rotationSpeed;
				} else {
					y -= speed;
				}
				return;
			}
			if (right) {
				if (tank.rotation > 2) {
					tank.rotation -= rotationSpeed;
				} else if (tank.rotation < 0) {
					tank.rotation += rotationSpeed;
				} else {
					x += speed;
				}
				return;
				
			}
			if (down) {
				if (tank.rotation < 90) {
					tank.rotation += rotationSpeed;
				} else if (tank.rotation > 92) {
					tank.rotation -= rotationSpeed;
				} else {
					y += speed;
				}
				return;
			}
			if (left) {
				if (tank.rotation >= 0 && tank.rotation < 178) {
					tank.rotation += rotationSpeed;
				} else if (tank.rotation <= 0 && tank.rotation > -180) {
					tank.rotation -= rotationSpeed;
				} else {
					x -= speed;
				}
				return;
			}
		}
		
		
		
	}

}
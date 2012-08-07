package game.player {
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import game.player.graphics.Tank;
	import game.world.MainMap;
	import game.WorldManager;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class Player extends Sprite {
		private var tank:Tank = new Tank();
		private var map:MainMap;
		public var index:int = -2;
		private var manager:WorldManager;
		
		private var _health:int = 100;
		private var healthBar:Shape = new Shape();
		
		private var nickname:String;
		
		public static var LEFT:String = "left";
		public static var RIGHT:String = "right";
		public static var UP:String = "up";
		public static var DOWN:String = "down";
		
		private var up:Boolean = false;
		private var right:Boolean = false;
		private var down:Boolean = false;
		private var left:Boolean = false;
		
		private var speed:Number = .1;
		private var movingStart:Number = 0;
		private var _iniX:Number = 0;
		private var _iniY:Number = 0;
		
		public function Player(map:MainMap, index:int, manager:WorldManager) {
			super();
			this.map = map;
			this.index = index;
			this.manager = manager;
			
			scaleX = scaleY = .5;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		
		}
		
		public function setName(name:String):void {
			this.nickname = name;
			showName();
		}
		
		private function showName():void {
			var t:TextField = new TextField();
			t.text = nickname;
			t.autoSize = TextFieldAutoSize.LEFT;
			t.background = true;
			t.backgroundColor = 0xcccccc;
			t.alpha = .8;
			addChild(t);
			t.x = -t.width / 2;
			t.y = -tank.height / 2 - t.height - 5;
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(MouseEvent.MOUSE_OVER, mOverListener);
			addEventListener(MouseEvent.MOUSE_OUT, mOutListener);
			addEventListener(MouseEvent.CLICK, mClickListener);
			addChild(tank);
			iniX = iniY = 50;
		}
		
		private function mClickListener(e:MouseEvent):void {
			manager.target = this;
			showHealth();
		}
		
		public function showHealth():void {
			healthBar.graphics.clear();
			healthBar.graphics.beginFill(0xff0000);
			
			healthBar.graphics.drawRect(0, 0, health, 2);
			healthBar.graphics.beginFill(0x000000);
			healthBar.graphics.drawRect(health, 0, 100 - health, 2);
			addChild(healthBar);
			healthBar.x = - healthBar.width / 2;
			healthBar.y = tank.y + tank.height+2;
		}
		
		public function hideHealth():void {
			if(healthBar.parent!=null) removeChild(healthBar);
		}
		
		private function mOutListener(e:MouseEvent):void {
		
		}
		
		private function mOverListener(e:MouseEvent):void {
		
		}
		
		public function setSpeed(s:Number):void {
			speed = s;
			updateCoords();
			movingStart = new Date().getTime();
		}
		
		public function moveTo(direction:String, start:Number = -1):void {
			stopMoving();
			switch (direction) {
				case UP:  {
					up = true;
					left = right = down = false;
					break;
				}
				case RIGHT:  {
					right = true;
					left = up = down = false;
					break;
				}
				case DOWN:  {
					down = true;
					left = right = up = false;
					break;
				}
				case LEFT:  {
					left = true;
					up = right = down = false;
					break;
				}
			}
			if (start == -1) {
				movingStart = new Date().getTime();
			} else {
				movingStart = start + manager.getTimeDifference();
			}
			addEventListener(Event.ENTER_FRAME, moveAnim);
		}
		
		public function stopMoving():void {			
			up = left = right = down = false;
			iniX = x;
			iniY = y;
			removeEventListener(Event.ENTER_FRAME, moveAnim);		
		}
		
		public function updateCoords():void {
			iniX = x;
			iniY = y;	
		}
		
		public function get iniX():Number {
			return _iniX;
		}
		
		public function set iniX(value:Number):void {
			_iniX = value;
			x = value;
		}
		
		public function get iniY():Number {
			return _iniY;
		}
		
		public function set iniY(value:Number):void {
			_iniY = value;
			y = value;
		}
		
		public function get health():int {
			return _health;
		}
		
		public function set health(value:int):void {
			_health = value;
			
			if (healthBar.parent == null) {
				showHealth();
				removeChild(healthBar);
			} else {
				showHealth();
			}
		}
		
		private function getNearestBlockIndexes():Point {
			var globPoint:Point = localToGlobal(new Point(0, 0));
			var mapPoint:Point = map.globalToLocal(globPoint);
			var blockIndexY:int = Math.floor(mapPoint.y / map.getGridStep());
			var blockIndexX:int = Math.floor(mapPoint.x / map.getGridStep());
			return new Point(blockIndexX, blockIndexY);
		}
		
		private function moveAnim(e:Event):void {
			var indexes:Point = getNearestBlockIndexes();
			var shift:Number = (new Date().getTime() - movingStart) * speed;
			if (up) {
				if (tank.rotation != -90) {
					tank.rotation = -90;
				} else {
					
					if (!map.testHit(tank, indexes.x, indexes.y - 1) && !map.testHit(tank, indexes.x + 1, indexes.y - 1)) {
						y = iniY - shift;
					} else {
						stopMoving();
						manager.stopMovePlayer(x, y, index);
					}
					
				}
				return;
			}
			if (right) {
				if (tank.rotation != 0) {
					tank.rotation = 0;
				} else {
					if (!map.testHit(tank, indexes.x + 1, indexes.y) && !map.testHit(tank, indexes.x + 1, indexes.y + 1)) {
						x = iniX + shift;
					} else {
						stopMoving();
						manager.stopMovePlayer(x, y, index);
					}
				}
				return;
				
			}
			if (down) {
				if (tank.rotation != 90) {
					tank.rotation = 90;
				} else {
					if (!map.testHit(tank, indexes.x, indexes.y + 1) && !map.testHit(tank, indexes.x + 1, indexes.y + 1)) {
						y = iniY + shift;
					} else {
						stopMoving();
						manager.stopMovePlayer(x, y, index);
					}
				}
				return;
			}
			if (left) {
				if (tank.rotation != 180) {
					tank.rotation = 180;
				} else {
					if (!map.testHit(tank, indexes.x - 1, indexes.y) && !map.testHit(tank, indexes.x - 1, indexes.y + 1)) {
						x = iniX - shift;
					} else {
						stopMoving();
						manager.stopMovePlayer(x, y, index);
					}
				}
				return;
			}
		}
	
	}

}
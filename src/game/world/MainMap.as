package game.world {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import game.player.graphics.Tank;
	import game.WorldManager;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class MainMap extends Sprite {
		
		private var tileMatrix:Array = new Array();
		
		[Embed(source="pics/earth.jpg")]
		private var Earth:Class;
		[Embed(source="pics/stone.jpg")]
		private var Stone:Class;
		
		private var manager:WorldManager;
		
		public function MainMap(manager:WorldManager) {
			super();
			this.manager = manager;
			addEventListener(Event.ADDED_TO_STAGE, init);
		
		}
		
		public function getGridStep():int {
			return 16;
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var myTextLoader:URLLoader = new URLLoader();
			myTextLoader.addEventListener(Event.COMPLETE, onLoaded);
			myTextLoader.load(new URLRequest("map.txt"));
		}
		
		public function getTile(_x:int, _y:int):DisplayObject {
			
			return tileMatrix[_y][_x];
		}
		
		public function testHit(tank:Tank, blockIndexX:int, blockIndexY:int):Boolean {
			if (blockIndexX < 0 || blockIndexY < 0)
				return false;
			if (blockIndexX >= tileMatrix.length) return false;
			if (blockIndexY >= tileMatrix[blockIndexX].length) return false;
			
			if (tileMatrix[blockIndexY][blockIndexX] is Earth)
				return false;
			return tank.hitTestObject(tileMatrix[blockIndexY][blockIndexX]);
		
		}
		
		private function onLoaded(e:Event):void {
			var myArrayOfLines:Array = e.target.data.split("\n");
			
			for (var h:int = 0; h < myArrayOfLines.length; h++) {
				var arrayOfObjects:Array = myArrayOfLines[h].split(" ");
				tileMatrix[h] = new Array();
				for (var w:int = 0; w < arrayOfObjects.length; w++) {
					var tile:Bitmap;
					if (arrayOfObjects[w] == "1") {
						tile = new Stone();
						tile.x = w * tile.width;
						tile.y = h * tile.height;
						addChild(tile);
						tileMatrix[h][w] = tile;
					} else if (arrayOfObjects[w] == "0") {
						tile = new Earth();
						tile.x = w * tile.width;
						tile.y = h * tile.height;
						addChild(tile);
						tileMatrix[h][w] = tile;
					}
				}
			}
			manager.requestResize();
		
		}
	
	}

}
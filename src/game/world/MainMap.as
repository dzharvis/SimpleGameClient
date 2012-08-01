package game.world 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import game.player.Tank;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class MainMap extends Sprite 
	{
		
		private var tileMatrix:Array = new Array();
		
		public function MainMap() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var myTextLoader:URLLoader = new URLLoader();			
			myTextLoader.addEventListener(Event.COMPLETE, onLoaded);
			myTextLoader.load(new URLRequest("map.txt"));
		}
		
		private function onLoaded(e:Event):void {
			var myArrayOfLines:Array = e.target.data.split("\n");
			
			for (var h:int = 0; h < myArrayOfLines.length; h++) {
				var arrayOfObjects:Array = myArrayOfLines[h].split(" ");	
				for (var w:int = 0; w < arrayOfObjects.length; w++) {
					tileMatrix[w] = new Array();
					if(arrayOfObjects[w] == "1"){
						var tile:BlackTile = new BlackTile();
						tile.x = w * 100;
						tile.y = h * 100;
						addChild(tile);
						tileMatrix[w][h] = tile;
					}
				}
			}
			if (width / height > stage.stageWidth / stage.stageHeight) {
				scaleX = scaleY = stage.stageWidth/width;
			} else {
				scaleX = scaleY = stage.stageHeight/height;
			}			
			
		}
		
	}

}
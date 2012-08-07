package 
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import game.WorldManager;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class Main extends Sprite 
	{
		private var s:Socket;
		private var nickname:String;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			addChild(new ConnectionUI(this));
			
			
		}
		
		public function connect(text:String):void {
			nickname = text;
			s = new Socket("109.86.9.142", 35707);			
			s.addEventListener(Event.CONNECT, connListener);
		}
		
		private function dataListener(e:ProgressEvent):void 
		{
			
		}
		
		private function connListener(e:Event):void 
		{
			
			while (numChildren > 0) {
				removeChild(getChildAt(0));
			}
			addChild(new WorldManager(s, nickname));
		}
		
	}
	
}
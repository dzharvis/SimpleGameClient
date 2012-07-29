package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var s:Socket = new Socket("109.86.9.142", 35707);
			s.addEventListener(Event.CONNECT, connListener);
			s.addEventListener(ProgressEvent.SOCKET_DATA, dataListener);
		}
		
		private function dataListener(e:ProgressEvent):void 
		{
			
		}
		
		private function connListener(e:Event):void 
		{
			trace("connected");
		}
		
	}
	
}
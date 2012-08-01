package game 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import game.player.Player;
	import game.world.MainMap;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class WorldManager extends Sprite 
	{
		private var map:MainMap = new MainMap();
		private var tanks:Vector.<Player> = new Vector.<Player>();
		private var s:Socket;
		
		public function WorldManager(s:Socket) 
		{
			super();
			this.s = s;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			s.addEventListener(ProgressEvent.SOCKET_DATA, dataListener);
			addChild(map);
		}
		
		private function dataListener(e:ProgressEvent):void 
		{
			
		}
		
	}

}
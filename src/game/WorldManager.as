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
		private var players:Array = new Array(20);
		private var gamer:Player;
		private var s:Socket;
		
		private var keyListener:KeyListener;
		private var socketListener:SocketListener;
		
		public function WorldManager(s:Socket) 
		{
			super();
			this.s = s;		
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			keyListener = new KeyListener(stage, this);
			socketListener = new SocketListener(s, this);
			
			addChild(map);
			
		}
		
		public function handleBundle(bundle:Object):void 
		{
			switch(bundle.header){
			case "info": 
				var i:int = bundle.values[0];
				gamer = new Player(map, "shit");
				pushPlayer(i, gamer);
			}
		}
		
		public function pushPlayer(index:int, pl:Player):void {
			if (players[index] != null) {
				trace ("Error, while pushing a player, appears!");
				return;
			} else {
				players[index] = pl;
				///////
				addChild(pl);
			}
		}
		
		public function deletePlayer(index:int):void {
			if (players[index] != null) {
				removeChild(players[index]);
			} else {
				trace("Error, while deleting a player, appears!");
			}
			players[index] = null;
		}
		
		
		
		
	}

}
package game 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.geom.Point;
	import flash.net.Socket;
	import game.player.Player;
	import game.ui.Chat;
	import game.world.MainMap;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class WorldManager extends Sprite 
	{
		private var map:MainMap;
		private var players:Array = new Array(20);
		private var gamer:Player;
		private var s:Socket;
		
		private var chatWindow:Chat;
		
		private var keyListener:KeyListener;
		private var socketListener:SocketListener;
		private var nickname:String;
		
		public function WorldManager(s:Socket, nickname:String) 
		{
			super();
			this.s = s;
			this.nickname = nickname;
			
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			chatWindow = new Chat(this);
			keyListener = new KeyListener(stage, this);
			socketListener = new SocketListener(s, this);
			map = new MainMap(this);
			addChild(map);
			addChild(chatWindow);
			
		}
		
		public function requestResize():void {
			if (width / height > stage.stageWidth / stage.stageHeight) {
				scaleX = scaleY = stage.stageWidth / width;
			} else {
				scaleX = scaleY = stage.stageHeight/height;
			}
			
			chatWindow.setSize(new Point(width, height));
			chatWindow.y = map.height - chatWindow.height;
		}
		
		public function handleBundle(bundle:Object):void 
		{
			
			switch(bundle.header){
			case "info": {
				var i:int = bundle.values[0];
				gamer = new Player(map, i);
				gamer.setName(nickname);
				pushPlayer(i, gamer);
				
				b = new Bundle("name");
				b.pushValue(nickname);
				socketListener.sendBundle(b);
				
				var b:Bundle = new Bundle("request gamers");
				socketListener.sendBundle(b);
				break;
			}
			case "moving1": {
				var i:int = bundle.values[0];
				var direction:String = bundle.values[1];
				movePlayer(direction, i);
				break;
			}
			case "moving0": {
				var i:int = bundle.values[0];
				var direction:String = bundle.values[1];
				var _x:int = bundle.values[2];
				var _y:int = bundle.values[3];
				stopMovePlayer(direction, i, _x, _y);
				break;
			}
			case "connected": {
				var i:int = bundle.values[0];
				var p:Player = new Player(map, i);
				p.setName(bundle.values[1]);
				pushPlayer(i, p);
				break;
			}
			case "message": {
				chatWindow.putMessage(bundle.values[0]);
				break;
			}
			}
		}
		
		public function sendBundle(b:Bundle):void {
			socketListener.sendBundle(b);
		}
		
		public function pushPlayer(index:int, pl:Player):void {
			if (players[index] != null) {
				trace ("Error, while pushing a player, appears!");
				return;
			} else {
				players[index] = pl;
				///////
				addChildAt(pl, 1);
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
		
		public function movePlayer(direction:String, playerId:int=-1):void 
		{
			if (playerId == -1) {
				gamer.addDirection(direction);
				var b:Bundle = new Bundle("moving1");
				b.pushValue(gamer.index);
				b.pushValue(direction);
				socketListener.sendBundle(b);
			} else {
				if(players[playerId]!=null) players[playerId].addDirection(direction);
			}
		}
		
		public function stopMovePlayer(direction:String, playerId:int=-1, _x:int=0, _y:int=0):void 
		{
			if (playerId == -1) {
				gamer.removeDirection(direction);
				var b:Bundle = new Bundle("moving0");
				b.pushValue(gamer.index);
				b.pushValue(direction);
				b.pushValue(gamer.x);
				b.pushValue(gamer.y);
				socketListener.sendBundle(b);
			} else {
				if (players[playerId] != null) {
					players[playerId].removeDirection(direction);
					players[playerId].x = _x;
					players[playerId].y = _y;
					
				}
			}
		}
		
		
		
		
	}

}
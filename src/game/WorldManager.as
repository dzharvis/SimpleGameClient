package game {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.Socket;
	import game.player.Player;
	import game.player.skills.SkillBar;
	import game.ui.Chat;
	import game.world.MainMap;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class WorldManager extends Sprite {
		private var map:MainMap;
		private var players:Array = new Array(20);
		private var gamer:Player;
		private var s:Socket;
		
		private var chatWindow:Chat;
		
		private var _target:Player;
		
		private var keyListener:KeyListener;
		private var socketListener:SocketListener;
		private var nickname:String;
		private var sb:SkillBar;
		
		public function WorldManager(s:Socket, nickname:String) {
			super();
			this.s = s;
			this.nickname = nickname;			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			chatWindow = new Chat(this);
			keyListener = new KeyListener(stage, this);
			socketListener = new SocketListener(s, this);
			map = new MainMap(this);
			sb = new SkillBar(this);
			stage.addChild(sb);			
			stage.addChild(chatWindow);
			chatWindow.setSize(new Point(stage.stageWidth, stage.stageHeight));
			addChild(map);
		}
		
		public function requestResize():void {
			
			if (width / height > stage.stageWidth / (stage.stageHeight-chatWindow.height-10)) {
				scaleX = scaleY = stage.stageWidth / width;
			} else {
				scaleX = scaleY = (stage.stageHeight-chatWindow.height-10) / height;
			}			
			
			chatWindow.y = sb.y = height+5;
			sb.x = chatWindow.x + chatWindow.width+5;
		}
		
		public function handleBundle(bundle:Object):void {
			var i:int;
			var direction:String;
			switch (bundle.header) {
				case "info":  {
					i = bundle.values[0];
					gamer = new Player(map, i, this);
					gamer.setName(nickname);
					pushPlayer(i, gamer);					
					b = new Bundle("name");
					b.pushValue(nickname);
					socketListener.sendBundle(b);					
					var b:Bundle = new Bundle("request gamers");
					socketListener.sendBundle(b);
					break;
				}
				case "moving1":  {
					i = bundle.values[0];
					direction = bundle.values[1];
					var start:Number = bundle.values[2];
					movePlayer(start, direction, i);
					break;
				}
				case "moving0":  {
					i = bundle.values[0];
					var _x:int = bundle.values[1];
					var _y:int = bundle.values[2];
					stopMovePlayer(_x, _y, i);
					break;
				}
				case "connected":  {
					i = bundle.values[0];
					var p:Player = new Player(map, i, this);
					p.setName(bundle.values[1]);
					pushPlayer(i, p);
					break;
				}
				case "deleted":  {
					deletePlayer(bundle.values[0]);
					break;
				}
				case "message":  {
					chatWindow.putMessage(bundle.values[0]);
					break;
				}
				case "latency":  {
					socketListener.computeTimeDiff(bundle.values[0]);
					break;
				}
				case "slow time": {
					for (i = 0; i < bundle.values.length; i++ ) {
						if(players[bundle.values[i]]!=null) players[bundle.values[i]].setSpeed(.01);
					}					
					break;
				}
				case "return time": {
					for (i = 0; i < bundle.values.length; i++ ) {
						if(players[bundle.values[i]]!=null) players[bundle.values[i]].setSpeed(.1);
					}					
					break;
				}
			}
		}
		
		public function sendBundle(b:Bundle):void {
			socketListener.sendBundle(b);
		}
		
		public function pushPlayer(index:int, pl:Player):void {
			if (players[index] != null) {
				trace("Error, while pushing a player, appears!");
				return;
			} else {
				players[index] = pl;
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
		
		public function movePlayer(start:Number, direction:String, playerId:int = -1):void {
			if (playerId == -1) {
				gamer.moveTo(direction);
				var b:Bundle = new Bundle("moving1");
				b.pushValue(gamer.index);
				b.pushValue(direction);
				socketListener.sendBundle(b);
			} else {
				if (players[playerId] != null)
					players[playerId].moveTo(direction, start);
			}
		}
		
		public function getTimeDifference():int {
			return socketListener.getTimeDifference();
		}
		
		public function getPlayer(ind:int=-1):Player {
			if (ind == -1) {
				return gamer;
			} else {
				return players[ind];
			}
		}
		
		public function stopMovePlayer(_x:int = -1, _y:int = -1, playerId:int = -1):void {
			if (playerId == -1) {
				gamer.stopMoving();
				var b:Bundle = new Bundle("moving0");
				b.pushValue(gamer.index);
				b.pushValue(gamer.x);
				b.pushValue(gamer.y);
				socketListener.sendBundle(b);
			} else {
				if (players[playerId] != null) {
					players[playerId].stopMoving();
					if (_x != -1 && _y != -1) {
						players[playerId].iniX = _x;
						players[playerId].iniY = _y;
					}
					
				}
			}
			trace(playerId);
		}
		
		public function get target():Player {
			return _target;
		}
		
		public function set target(value:Player):void {
			if (_target != null) {
				_target.hideHealth();
			}
			_target = value;
			var b:Bundle = new Bundle("target");
			b.pushValue(value.index);
			_target.showHealth();
			sendBundle(b);
		}
	
	}

}
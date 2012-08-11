package game {
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import game.player.Player;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class KeyListener {
		private var manager:WorldManager;
		
		private var up:Boolean = false;
		private var left:Boolean = false;
		private var right:Boolean = false;
		private var down:Boolean = false;
		
		public function KeyListener(stage:Stage, manager:WorldManager) {
			this.manager = manager;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, downEvent);
			stage.addEventListener(KeyboardEvent.KEY_UP, upEvent);
		
		}
		
		private function movePlayer(s:Number, direction:String):void {
			var gamer:Player = manager.getPlayer();
			var b:Bundle = new Bundle("moving1", "player");
			b.pushValue(gamer.index);
			b.pushValue(direction);
			manager.sendBundle(b);
			gamer.moveTo(direction, -1);
		}
		
		private function stopPlayer():void {
			var gamer:Player = manager.getPlayer();
			var b:Bundle = new Bundle("moving0", "player");
			gamer.stopMoving();
			b.pushValue(gamer.index);
			b.pushValue(gamer.x);
			b.pushValue(gamer.y);
			manager.sendBundle(b);
		}
		
		private function upEvent(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case 87:  {
					if (up) {
						stopPlayer();
						up = false;
					}
					break;
				}
				case 83:  {
					if (down) {
						stopPlayer();
						down = false;
					}
					break;
				}
				case 65:  {
					if (left) {
						stopPlayer();
						left = false;
					}
					break;
				}
				case 68:  {
					if (right) {
						stopPlayer();
						right = false;
					}
					break;
				}
			}
		}
		
		private function downEvent(e:KeyboardEvent):void {
			var s:Number = new Date().getTime();
			switch (e.keyCode) {
				case 87:  {
					if (!up) {
						movePlayer(s, Player.UP);
						up = true;
					}
					break;
				}
				case 83:  {
					if (!down) {
						movePlayer(s, Player.DOWN);
						down = true;
					}
					break;
				}
				case 65:  {
					if (!left) {
						movePlayer(s, Player.LEFT);
						left = true;
					}
					break;
				}
				case 68:  {
					if (!right) {
						movePlayer(s, Player.RIGHT);
						right = true;
					}
					break;
				}
			}
		}
	
	}

}
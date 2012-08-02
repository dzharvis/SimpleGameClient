package game 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import game.player.Player;
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class KeyListener 
	{
		private var manager:WorldManager;
		
		private var up:Boolean = false;
		private var left:Boolean = false;
		private var right:Boolean = false;
		private var down:Boolean = false;
		
		public function KeyListener(stage:Stage, manager:WorldManager) 
		{
			this.manager = manager;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, downEvent);
			stage.addEventListener(KeyboardEvent.KEY_UP, upEvent);
			
		}
		
		private function upEvent(e:KeyboardEvent):void 
		{			
			switch(e.keyCode) {
				case 87: {					
					if (up) {
						manager.stopMovePlayer(Player.UP);
						up = false;
					}
					break;
				}
				case 83: {
					if (down) {
						manager.stopMovePlayer(Player.DOWN);
						down = false;
					}
					break;
				}
				case 65: {
					if (left) {
						manager.stopMovePlayer(Player.LEFT);
						left = false;
					}
					break;
				}
				case 68: {
					if (right) {
						manager.stopMovePlayer(Player.RIGHT);
						right = false;
					}
					break;
				}
			}
		}
		
		private function downEvent(e:KeyboardEvent):void 
		{
			switch(e.keyCode) {
				case 87: {					
					if (!up) {
						manager.movePlayer(Player.UP);
						up = true;
					}
					break;
				}
				case 83: {
					if (!down) {
						manager.movePlayer(Player.DOWN);
						down = true;
					}
					break;
				}
				case 65: {
					if (!left) {
						manager.movePlayer(Player.LEFT);
						left = true;
					}
					break;
				}
				case 68: {
					if (!right) {
						manager.movePlayer(Player.RIGHT);
						right = true;
					}
					break;
				}
			}
		}
		
	}

}
package game 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class KeyListener 
	{
		private var manager:WorldManager;
		
		public function KeyListener(stage:Stage, manager:WorldManager) 
		{
			this.manager = manager;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, downEvent);
			stage.addEventListener(KeyboardEvent.KEY_UP, upEvent);
			
		}
		
		private function upEvent(e:KeyboardEvent):void 
		{
			trace(e.keyCode);
		}
		
		private function downEvent(e:KeyboardEvent):void 
		{
			trace(e.keyCode);
		}
		
	}

}
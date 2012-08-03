package game.ui 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import game.Bundle;
	import game.WorldManager;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class Chat extends Sprite 
	{
		private var messagesOutput:TextField = new TextField();
		private var messageInput:TextField = new TextField();
		private var manager:WorldManager;
		
		public function Chat(manager:WorldManager) 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
			this.manager = manager;
			
			
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			messagesOutput.alpha = messageInput.alpha = .9;
			messagesOutput.background = messageInput.background = true;
			messagesOutput.backgroundColor = 0xdddddd;
			messagesOutput.wordWrap = true;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, sendMessage);
			
			messageInput.backgroundColor = 0x666666;
			
			messagesOutput.border = messageInput.border = true;
			
			messageInput.type = "input";
			messageInput.y = messagesOutput.height;
			
			addChild(messageInput);
			addChild(messagesOutput);
		}
		
		public function putMessage(message:String):void {
			messagesOutput.text += message + "\n";
			messagesOutput.scrollV++;
		}
		
		public function setSize(size:Point):void {
			
			messagesOutput.width = messageInput.width = size.x*.2;
			
			messagesOutput.height = size.y * .1 * .8;
			messageInput.height =  size.y*.1*.2;
		}
		
		private function sendMessage(e:KeyboardEvent):void {
			if (e.keyCode == 13 && messageInput.text.length > 0) {
				var b:Bundle = new Bundle("message");
				b.pushValue(messageInput.getRawText());
				
				messageInput.text = "";
				manager.sendBundle(b);
			}			
		}
		
	}

}
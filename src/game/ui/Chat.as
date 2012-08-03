package game.ui 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
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
			messagesOutput.width = messageInput.width = stage.stageWidth*.3;
			messagesOutput.border = messageInput.border = true;
			messagesOutput.height = stage.stageHeight * .2 * .8;
			messageInput.height =  stage.stageHeight*.2*.2;
			messageInput.type = "input";
			messageInput.y = messagesOutput.height;
			
			addChild(messageInput);
			addChild(messagesOutput);
		}
		
		public function putMessage(message:String):void {
			messagesOutput.text += message + "\n";
			messagesOutput.scrollV++;
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
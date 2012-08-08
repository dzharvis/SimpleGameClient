package game.ui {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import game.Bundle;
	import game.WorldManager;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class Chat extends Sprite {
		private var messagesOutput:TextField = new TextField();
		private var messageInput:TextField = new TextField();
		private var manager:WorldManager;
		
		public function Chat(manager:WorldManager) {
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
			this.manager = manager;
		
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			messagesOutput.alpha = messageInput.alpha = .9;
			messagesOutput.background = messageInput.background = true;
			messagesOutput.backgroundColor = 0x333333;
			messagesOutput.textColor = 0x0099cc;
			messagesOutput.wordWrap = true;
			messagesOutput.border = messageInput.border = true;
			
			messageInput.backgroundColor = 0x505050;
			messageInput.textColor = 0xffffff;
			messageInput.type = "input";
			
			addChild(messageInput);
			addChild(messagesOutput);
			
			
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, sendMessage, false, 20);
		}
		
		public function putMessage(message:String):void {
			messagesOutput.appendText(message + "\n");
			messagesOutput.scrollV = messagesOutput.maxScrollV;
		}
		
		public function setSize(size:Point):void {			
			messagesOutput.width = messageInput.width = size.x * .3;			
			messagesOutput.height = size.y * .2 * .8;
			messageInput.height = size.y * .2 * .2;
			messageInput.y = messagesOutput.height+5;
		}
		
		private function sendMessage(e:KeyboardEvent):void {
			if (e.keyCode == 13) {
				if (stage.focus == messageInput) {
					stage.focus = stage;
				} else {
					stage.focus = messageInput;
				}
			}
			if (e.keyCode == 13 && messageInput.text.length > 0) {
				var b:Bundle = new Bundle("message");
				b.pushValue(messageInput.getRawText());
				
				messageInput.text = "";
				manager.sendBundle(b);
			}
			if (stage.focus == messageInput) {
				e.stopImmediatePropagation();
			}
		}
	
	}

}
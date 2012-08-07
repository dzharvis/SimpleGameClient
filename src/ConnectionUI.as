package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class ConnectionUI extends Sprite {
		private var main:Main;
		private var nickNameTextField:TextField;
		
		public function ConnectionUI(main:Main) {
			super();
			this.main = main;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			graphics.beginFill(0x333333);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			var text:TextField = new TextField();
			text.text = "Select your nickname and press connect in order to connect (isn't it obvious?)";
			text.textColor = 0x0099cc;
			text.autoSize = TextFieldAutoSize.CENTER;
			text.scaleX = text.scaleY = 1.5;
			addChild(text);
			text.x = stage.stageWidth / 2 - text.width / 2;
			text.y = stage.stageHeight / 3 - text.height / 2;
			
			var connectButton:Sprite = new Sprite();
			addChild(connectButton);
			connectButton.graphics.beginFill(0x999999, .9);
			connectButton.graphics.drawRect(0, 0, 100, 20);
			connectButton.addEventListener(MouseEvent.CLICK, connectListener);
			var connectText:TextField = new TextField();
			connectText.text = "Connect!";
			connectText.selectable = false;
			connectButton.addChild(connectText);
			connectButton.x = stage.stageWidth / 2 - connectButton.width / 2;
			connectButton.y = stage.stageHeight / 2 - connectButton.height / 2;
			
			nickNameTextField = new TextField();
			addChild(nickNameTextField);
			//nickNameTextField.autoSize = TextFieldAutoSize.LEFT;
			nickNameTextField.text = "Nickname here";
			nickNameTextField.type = "input";
			nickNameTextField.background = true;
			nickNameTextField.x = connectButton.x;
			nickNameTextField.y = connectButton.y + nickNameTextField.height + 10;
			nickNameTextField.width = 170;
			nickNameTextField.height = 25;
		
		}
		
		private function connectListener(e:MouseEvent):void {
			if (nickNameTextField.text == "Nickname here" || nickNameTextField.text == "" || nickNameTextField.text == "Please select nickname") {
				nickNameTextField.text = "Please select nickname";
				return;
			}
			main.connect(nickNameTextField.text);
		}
	
	}

}
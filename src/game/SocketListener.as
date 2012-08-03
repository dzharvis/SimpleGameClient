package game 
{
	import com.adobe.serialization.json.JSON;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class SocketListener 
	{
		private var s:Socket;
		private var manager:WorldManager;
		public function SocketListener(s:Socket, manager:WorldManager) 
		{
			this.s = s;
			this.manager = manager;
			
			s.addEventListener(ProgressEvent.SOCKET_DATA, dataListener);
		}
		
		private function dataListener(e:ProgressEvent):void 
		{
			while (s.bytesAvailable > 0) {
				var bundle:Object = JSON.decode(s.readUTF());
				manager.handleBundle(bundle);
			}
			
		}
		
		public function sendBundle(b:Bundle):void {
			var str:String = JSON.encode(b);
			s.writeUTF(str);
			s.flush();
		}
		
		
		
	}

}
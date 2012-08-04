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
		private var latency:Number = 0;
		private var timeDifference:uint = 0;
		
		
		public function SocketListener(s:Socket, manager:WorldManager) 
		{
			this.s = s;
			this.manager = manager;			
			s.addEventListener(ProgressEvent.SOCKET_DATA, dataListener);
			
			var b:Bundle = new Bundle("latency");
			latency = new Date().getTime();
			sendBundle(b);
			
			
		}
		
		public function computeTimeDiff(servTime:Number):void {
			latency = new Date().getTime() - latency;
			latency = latency >> 1;
			timeDifference = new Date().getTime() - servTime + latency;
			
			var b:Bundle = new Bundle("timDiff");
			b.pushValue(timeDifference);
			sendBundle(b);
		}
		
		public function getTimeDifference():uint {
			return timeDifference;
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
package game {
	import com.adobe.serialization.json.JSON;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.utils.setInterval;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class SocketListener {
		private var s:Socket;
		private var manager:WorldManager;
		private var latency:Number = Infinity;
		private var templat:Number = 0;
		private var timeDifference:uint = 0;
		
		private var moveStart:Number = 0;
		
		public function SocketListener(s:Socket, manager:WorldManager) {
			this.s = s;
			this.manager = manager;
			s.addEventListener(ProgressEvent.SOCKET_DATA, dataListener);			
			setInterval(latencyChecker, 5000);		
		}
		
		private function latencyChecker():void {
			var b:Bundle = new Bundle("latency", "basic");
			templat = new Date().getTime();
			sendBundle(b);
		}
		
		public function computeTimeDiff(servTime:Number):void {
			var _latency:Number = new Date().getTime() - templat;
			_latency = _latency >> 1;
			if (_latency < latency) {
				latency = _latency;
				timeDifference = new Date().getTime() - servTime - latency;			
				var b:Bundle = new Bundle("timDiff", "basic");
				b.pushValue(timeDifference);
				sendBundle(b);
				trace("Latency: " + latency + "  diff: " + timeDifference);
			}
		}
		
		public function getTimeDifference():uint {
			return timeDifference;
		}
		
		private function dataListener(e:ProgressEvent):void {
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
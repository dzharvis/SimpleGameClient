package game 
{
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
			
		}
		
	}

}
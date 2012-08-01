package game 
{
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class Bundle 
	{
		public var header:String;
		public var values:Array = new Array();
		
		public function Bundle(header:String) 
		{
			this.header = header;
		}
		
		public function pushValue(v:Object):void {
			values.push(v);
		}
		
	}

}
package game 
{
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class Bundle 
	{
		public var header:String;
		public var type:String;
		public var values:Array = new Array();
		
		public function Bundle(header:String, type:String) 
		{
			this.type = type;
			this.header = header;
		}
		
		public function pushValue(v:Object):void {
			values.push(v);
		}
		
	}

}
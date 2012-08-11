package  {
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class MyVector {
		private var _x:Number;
		private var _y:Number;
		private var _length:Number;
		
		public function MyVector(x:Number, y:Number) {
			this.y = y;
			this.x = x;	
			_length = Math.sqrt(x * x + y * y);
		}
		
		public function get x():Number {
			return _x;
		}
		
		public function set x(value:Number):void {
			_x = value;
			_length = Math.sqrt(x * x + y * y);
		}
		
		public function get y():Number {
			return _y;
		}
		
		public function set y(value:Number):void {
			_y = value;
			_length = Math.sqrt(x * x + y * y);
		}
		
		public function get unitVector():MyVector {			
			return new MyVector(x / length, y / length);
		}
		
		public function get length():Number {
			return _length;
		}
		
		public function addVector(vec:MyVector):MyVector {
			return new MyVector(x + vec.x, y + vec.y);
		}	
		
		public function getVecFromAngle(phi:Number):MyVector {
			var _x:Number = Math.cos(phi * Math.PI / 180);
			var _y:Number = Math.sin(phi * Math.PI / 180);
			return new MyVector(_x, _y).unitVector;
		}
		
		public function getRotation(raw:Boolean = false):int {
			var sin:Number = Math.asin(y) * 180 / Math.PI;
			if(!raw){				
				if (x > 0) {
					return sin+90;
				} else {
					return -sin-90;
				}
			} else {
				if (x >= 0) {
					return sin;
				} else {
					return 180-sin;
				}
			}
		}
		
	}

}
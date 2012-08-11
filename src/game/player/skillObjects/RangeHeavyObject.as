package game.player.skillObjects {
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class RangeHeavyObject extends RangeObject {
		private var vector:MyVector;
		public function RangeHeavyObject(bundle:RangeObjectBundle) {
			super(bundle);
			var x:Number = Math.random() * 100;
			var y:Number = Math.random() * 100;
			if (Math.random() >= 0.5) x = -x;
			if (Math.random() >= 0.5) y = -y;
			vector = new MyVector(x, y);
			vector = vector.unitVector;
			
		}
		override protected function getUnitVector():MyVector {
			var vec:MyVector = new MyVector(bundle.target.x - x, bundle.target.y - y);
			vec = vec.unitVector;
			
			var dX:Number = vec.x - vector.x;
			var dY:Number = vec.y - vector.y;
			
			if (dX > 0 || dX < 0) {
				vector.x = vector.x + dX / 10;
			}
			if (dY > 0 || dY < 0) {
				vector.y = vector.y + dY / 10;
			}
			vector = vector.unitVector
			return vector;
		}
		
	}

}
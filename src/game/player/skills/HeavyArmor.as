package game.player.skills {
	import flash.display.Bitmap;
	import game.player.skills.basic.Skill;
	import game.WorldManager;
	
	/**
	 * ...
	 * @author Dzharvis
	 */
	public class HeavyArmor extends Skill {
		
		[Embed(source = "pics/HeavyArmor.png")]
		private var HeavyArmorC:Class;
		private var heavyIcon:Bitmap = new HeavyArmorC();
		
		public function HeavyArmor(manager:WorldManager) {
			super(manager, 10, 8000, 0, "heavy armor", heavyIcon);			
		}
		
		override public function deploy(b:Object):void {
			if (manager.getPlayer(b.values[0]) == manager.getPlayer()) {
				beginCooldown();
			}
		}
		
	}

}
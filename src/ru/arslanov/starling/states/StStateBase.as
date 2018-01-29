package ru.arslanov.starling.states {
	import ru.arslanov.starling.display.ASprite;
	import ru.arslanov.starling.interfaces.IStState;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class StStateBase extends ASprite implements IStState {
		
		private var _nameScene:String = "";
		
		public function StStateBase( name:String ) {
			_nameScene = name;
			
			super();
		}
		
		public function get nameScene():String {
			return _nameScene;
		}
	}

}
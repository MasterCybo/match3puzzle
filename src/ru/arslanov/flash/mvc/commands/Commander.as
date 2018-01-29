package ru.arslanov.flash.mvc.commands
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import ru.arslanov.flash.mvc.Observer;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class Commander extends Observer
	{
		static private var _instance:Commander;
		
		static public function get me():Commander
		{
			if (!_instance) _instance = new Commander(new SingletonKey());
			return _instance;
		}
		
		
		private var _mapCommands:Dictionary = new Dictionary();

		public function Commander(key:SingletonKey) { super();	}
		
		public function mapCommand(eventType:String, commandClass:Class):void {
			_mapCommands[eventType] = commandClass;
		}

		public function unmapCommand(eventType:String):void
		{
			if (_mapCommands[eventType] != undefined) {
				delete _mapCommands[eventType];
			}
		}

		override public function dispatchEvent(event:Event):Boolean
		{
			if (_mapCommands[event.type]) {
				var CommandClass:Class = _mapCommands[event.type];
				var command:ICommand = new CommandClass(event);
				command.execute();
				command.destruct();
				return true;
			} else {
				return super.dispatchEvent(event);
			}
		}
	}
}

internal class SingletonKey {}
package ru.arslanov.flash.mvc.commands
{
	import flash.events.Event;
	
	import ru.arslanov.flash.mvc.Repository;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class Command implements ICommand
	{
		public var verbose:Boolean = false; // Выводить запуск команды в trace
		
		private var _repository:Repository = Repository.me;
		private var _commander:Commander = Commander.me;
		
		protected var _event:Event;
		
		public function Command(event:Event)
		{
			_event = event;
		}

		public function execute():void
		{
			if (!verbose) trace("[Command " + this + "] execute");
		}
		
		public function destruct():void
		{
			_event = null;
			_repository = null;
			_commander = null;
		}
		
		public function getEvent():* { return _event }
		
		public function getInstance(type:Class):* { return _repository.getInstance(type); }
		public function hasInstance(type:Class):Boolean { return _repository.hasInstance(type); }

		public function dispatchEvent(event:Event):Boolean { return _commander.dispatchEvent(event); }
	}

}
package ru.arslanov.flash.mvc
{
	import ru.arslanov.flash.mvc.context.IContextModule;


	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class Config
	{
		private var _context:IContextModule;
		
		public function Config(context:IContextModule)
		{
			_context = context;
		}

		public function initialize():void
		{
			trace("*execute* " + this + ".initialize");
			// override me
		}

		protected function get context():IContextModule { return _context }

		protected function addSingleton(type:Class, instance:Object):void
		{
			trace("[Config] : Singleton " + instance + " as " + type);
			_context.addSingleton(type, instance);
		}

		protected function addMediator(mediator:Class, displayObjectClass:Class):void
		{
			trace("[Config] : Mediate " + mediator + " for " + displayObjectClass);
			_context.addMediator(mediator, displayObjectClass);
		}

		protected function mapCommand(eventType:String, commandClass:Class):void
		{
			trace("[Config] : Command " + eventType + " for " + commandClass);
			_context.mapCommand(eventType, commandClass);
		}
	}

}
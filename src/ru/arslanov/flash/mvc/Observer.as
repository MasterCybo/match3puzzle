package ru.arslanov.flash.mvc
{
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class Observer extends EventDispatcher
	{
		public var tracer:Function = trace;
		
		public function Observer()
		{
			super();
		}
		
		public function traceMessage(message:String):void
		{
			if (tracer) tracer(message);
		}
		
	}
	
}
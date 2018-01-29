/**
 * Copyright (c) 2015 Artem Arslanov. All rights reserved.
 */
package ru.arslanov.flash.mvc.context
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class ContextObject implements IContextObject
	{
		public var verbose:Boolean = true; // Выводить события медиатора в trace
		
		private var _context:IContextModule;

		public function ContextObject(contextModule:IContextModule)
		{
			_context = contextModule;
		}

		public function destroy():void
		{
			_context = null;
		}

		public function get context():IContextModule { return _context; }

		public function dispatchEvent(event:Event, verbose:Boolean = false):Boolean
		{
			if (!verbose) trace(this + " dispatch " + event);
			return _context.dispatchEvent(event);
		}

		public function addEventListener(eventType:String, listener:Function):void
		{
			_context.addEventListener(eventType, listener);
		}

		public function removeEventListener(eventType:String, listener:Function = null):void
		{
			_context.removeEventListener(eventType, listener);
		}

		public function getInstance(type:Class):*
		{
			if (!hasInstance(type)) throw new ArgumentError("Not found instance of " + type);
			return _context.getInstance(type);
		}

		public function hasInstance(type:Class):Boolean
		{
			return _context.hasInstance(type);
		}
	}
}

package ru.arslanov.flash.mvc.context
{
	import flash.events.Event;


	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public interface IContextEventDispatcher
	{
		function dispatchEvent(event:Event, verbose:Boolean = false):Boolean;
		function addEventListener(eventType:String, listener:Function):void;
		function removeEventListener(eventType:String, listener:Function = null):void;
	}
}

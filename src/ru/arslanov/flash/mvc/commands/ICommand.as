package ru.arslanov.flash.mvc.commands
{
	import flash.events.Event;
	
	import ru.arslanov.flash.mvc.context.IInstanceAccessor;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public interface ICommand extends IInstanceAccessor
	{
		function execute():void;
		function destruct():void;
		function getEvent():*;
		function dispatchEvent(event:Event):Boolean
	}
	
}
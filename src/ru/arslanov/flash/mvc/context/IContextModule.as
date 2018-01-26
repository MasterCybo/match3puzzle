package ru.arslanov.flash.mvc.context
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public interface IContextModule extends IContextEventDispatcher, IInstanceAccessor
	{
		function get stage():Stage;
		function get contextView():DisplayObjectContainer;

		function addConfig(configClass:Class):IContextModule;

		function addSingleton(type:Class, instance:Object):void;
		function removeSingleton(type:Class, objectDestructor:String = null):void;
		
		function addMediator(mediator:Class, displayObjectClass:Class):void;
		function removeMediator(mediator:Class):void;
		
		function mapCommand(eventType:String, commandClass:Class):void;
		function unmapCommand(eventType:String):void;
	}
}

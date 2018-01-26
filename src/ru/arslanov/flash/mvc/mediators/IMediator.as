package ru.arslanov.flash.mvc.mediators
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public interface IMediator
	{
		function initialize(displayObject:DisplayObject):void;
		function destroy():void;
		
		function getView():DisplayObject;
	}
	
}
package ru.arslanov.flash.mvc.context
{
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public interface IContextObject extends IContextEventDispatcher, IInstanceAccessor
	{
		function get context():IContextModule;

		function destroy():void;
	}
}

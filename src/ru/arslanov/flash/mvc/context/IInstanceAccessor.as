package ru.arslanov.flash.mvc.context
{
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public interface IInstanceAccessor
	{
		function getInstance(type:Class):*;
		function hasInstance(type:Class):Boolean;
	}
}

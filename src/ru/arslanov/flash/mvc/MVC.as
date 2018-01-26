package ru.arslanov.flash.mvc
{
	import flash.display.DisplayObjectContainer;
	
	import ru.arslanov.flash.mvc.context.ContextModule;
	
	import ru.arslanov.flash.mvc.context.IContextModule;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class MVC
	{
		static public function createModuleContext(moduleViewContext:DisplayObjectContainer):IContextModule
		{
			return new ContextModule(moduleViewContext);
		}
	}
}

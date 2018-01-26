package ru.arslanov.flash.mvc.mediators
{
	import flash.display.DisplayObject;
	
	import ru.arslanov.flash.mvc.context.ContextObject;
	import ru.arslanov.flash.mvc.context.IContextModule;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class Mediator extends ContextObject implements IMediator
	{
		private var _displayObject:DisplayObject;

		public function Mediator(context:IContextModule)
		{
			super(context);
		}
		
		public function initialize(displayObject:DisplayObject):void
		{
			_displayObject = displayObject;
			if (verbose) trace("[Mediator " + this + "] initialize");
			// override me
		}
		
		override public function destroy():void
		{
			if (verbose) trace("[Mediator " + this + "] destroy");
			_displayObject = null;
			super.destroy();
			// override me
		}

		public function getView():DisplayObject  { return _displayObject; }

		public function addViewListener(eventType:String, listener:Function):void
		{
			getView().addEventListener(eventType, listener);
		}

		public function removeViewListener(eventType:String, listener:Function = null):void
		{
			getView().removeEventListener(eventType, listener);
		}
	}

}
package ru.arslanov.starling.mvc.extensions
{
	import ru.arslanov.starling.mvc.context.IContext;
	import ru.arslanov.starling.mvc.events.ContextEvent;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	
	public class StarlingBundle extends Extension
	{
		private var _contextView:DisplayObject;
		
		public function StarlingBundle(context:IContext)
		{
			super(context);
		}
		
		override public function initialize():void
		{
			context.addEventListener(ContextEvent.CONTEXT_VIEW_ADDED, viewAddedHandler);
		}
		
		private function viewAddedHandler(event:ContextEvent):void
		{
			context.removeEventListener(ContextEvent.CONTEXT_VIEW_ADDED, viewAddedHandler);
			
			_contextView = context.contextView as DisplayObject;
			
			if (!_contextView) {
				throw new Error("Context view is not starling.display.DisplayObject!");
			}
			
			if (_contextView.stage) {
				addedToStageHandler();
			} else {
				_contextView.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			}
		}
		
		private function addedToStageHandler(event:Event = null):void
		{
			_contextView.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			_contextView.stage.addEventListener(Event.ADDED, contextStageHandler);
			_contextView.stage.addEventListener(Event.REMOVED, contextStageHandler);
			mediateView(_contextView);
		}
		
		protected function contextStageHandler(event:Event):void
		{
			switch (event.type){
				case Event.ADDED:
					event.target.addEventListener(Event.ADDED_TO_STAGE, viewStageHandler);
					break;
				case Event.REMOVED:
					event.target.addEventListener(Event.REMOVED_FROM_STAGE, viewStageHandler);
					break;
			}
		}
		
		protected function viewStageHandler(event:Event):void
		{
			switch (event.type){
				case Event.ADDED_TO_STAGE:
					event.target.removeEventListener(Event.ADDED_TO_STAGE, viewStageHandler);
					mediateView(event.target as DisplayObject);
					break;
				case Event.REMOVED_FROM_STAGE:
					event.target.removeEventListener(Event.REMOVED_FROM_STAGE, viewStageHandler);
					unmediateView(event.target as DisplayObject);
					break;
			}
		}
		/*
		protected function onAdded(event:Event):void
		{
			event.target.addEventListener(Event.ADDED_TO_STAGE, addedViewToStageHandler);
		}
		
		private function addedViewToStageHandler(event:Event):void
		{
			event.target.removeEventListener(Event.ADDED_TO_STAGE, addedViewToStageHandler);
			mediateView(event.target as DisplayObject);
		}
		
		protected function onRemoved(event:Event):void
		{
			event.target.addEventListener(Event.REMOVED_FROM_STAGE, removedViewFromStageHandler);
		}
		
		private function removedViewFromStageHandler(event:Event):void
		{
			event.target.removeEventListener(Event.REMOVED_FROM_STAGE, removedViewFromStageHandler);
			unmediateView(event.target as DisplayObject);
		}
		*/
		private function mediateView(view:DisplayObject):void
		{
			if (!context.mediatorMap.isMediated(view)) context.mediatorMap.mediate(view);
			mediateChildren(view as DisplayObjectContainer);
		}
		
		private function mediateChildren(container:DisplayObjectContainer):void
		{
			if (!container) return;
			
			var child:DisplayObject;
			for (var i:int = 0; i < container.numChildren; i++) {
				child = container.getChildAt(i);
				mediateView(child);
			}
		}
		
		private function unmediateView(view:DisplayObject):void
		{
			if (context.mediatorMap.isMediated(view)) context.mediatorMap.unmediate(view);
			unmediateChildren(view as DisplayObjectContainer);
		}
		
		private function unmediateChildren(container:DisplayObjectContainer):void
		{
			if (!container) return;
			
			var child:DisplayObject;
			for (var i:int = 0; i < container.numChildren; i++) {
				child = container.getChildAt(i);
				unmediateView(child);
			}
		}
	}
}

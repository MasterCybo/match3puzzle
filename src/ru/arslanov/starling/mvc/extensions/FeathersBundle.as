package ru.arslanov.starling.mvc.extensions
{
	import feathers.FEATHERS_VERSION;
	import feathers.core.FeathersControl;
	import feathers.events.FeathersEventType;
	
	import ru.arslanov.starling.mvc.context.IContext;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class FeathersBundle extends StarlingBundle
	{
		public function FeathersBundle(context:IContext)
		{
			super(context);
			trace("Feathers VERSION : " + FEATHERS_VERSION);
		}
		
		override protected function viewStageHandler(event:Event):void
		{
			switch (event.type) {
				case Event.ADDED_TO_STAGE:
					var displayObject:DisplayObject = event.target as DisplayObject;
					var feathersControl:FeathersControl = displayObject as FeathersControl;
					if (!feathersControl) {
						super.viewStageHandler(event);
					} else {
						if (feathersControl.isInitialized) {
							super.viewStageHandler(event);
						} else {
							feathersControl.addEventListener(FeathersEventType.INITIALIZE, onFeathersControlInitialized);
						}
					}
					break;
			}
			
		}
		
		private function onFeathersControlInitialized(event:Event):void
		{
			var feathersControl:FeathersControl = event.target as FeathersControl;
			feathersControl.removeEventListener(FeathersEventType.INITIALIZE, onFeathersControlInitialized);
			super.viewStageHandler(event);
		}
	}
}

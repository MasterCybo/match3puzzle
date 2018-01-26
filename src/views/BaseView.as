/**
 * Created by Artem-Home on 06.09.2016.
 */
package views
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class BaseView extends Sprite
	{
		public function BaseView()
		{
			super();
			mouseEnabled = false;
			stage ? initialize() : addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			initialize();
		}
		
		private function onRemoveFromStage(event:Event):void
		{
			dispose();
		}
		
		protected function initialize():void
		{
			// override me
		}
		
		public function dispose():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			// override me
		}
	}
}

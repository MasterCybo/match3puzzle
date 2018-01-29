/**
 * Created by Artem-Home on 06.09.2016.
 */
package views
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class BaseView extends Sprite
	{
		public function BaseView()
		{
			super();
			touchable = false;
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
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			dispose();
		}
		
		protected function initialize():void
		{
			// override me
		}
		
		override public function dispose():void
		{
			// override me
		}
	}
}

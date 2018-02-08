package views
{
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class BaseImage extends Image
	{
		public function BaseImage(texture:Texture)
		{
			super(texture);
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

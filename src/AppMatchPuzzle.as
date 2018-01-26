/**
 * Created by Artem-Home on 05.09.2016.
 */
package
{
	import animations.AnimationFactory;
	
	import data.Grid;
	
	import events.GameFieldEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import ru.arslanov.flash.mvc.MVC;
	import ru.arslanov.flash.mvc.context.IContextModule;
	
	import services.file.events.FileServiceEvent;
	
	import views.Background;
	import views.GridView;
	
	public class AppMatchPuzzle extends Sprite
	{
		public function AppMatchPuzzle()
		{
			super();
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event = null):void
		{
			var context:IContextModule = MVC.createModuleContext(this).addConfig(GameConfig);
			
			var background:Background = new Background();
			var gridView:GridView = new GridView();
			
			addChild(background);
			addChild(gridView);
			
//			context.dispatchEvent(new FileServiceEvent(FileServiceEvent.START_LOADING));
			context.dispatchEvent(new GameFieldEvent(GameFieldEvent.GENERATE));
		}
	}
}

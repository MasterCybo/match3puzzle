package
{
	import utils.Assets;
	
	import views.BaseView;
	import views.BoardView;
	
	public class GameScreen extends BaseView
	{
		public function GameScreen()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			Assets.me.enqueue("images/sprites.png");
			Assets.me.enqueue("images/sprites.xml");
			Assets.me.loadQueue(progressLoading);
		}
		
		private function progressLoading(progress:Number):void
		{
			if (progress == 1) displayGrid();
		}
		
		private function displayGrid():void
		{
			var gameFieldView:BoardView = new BoardView();
			addChild(gameFieldView);
		}
	}
}

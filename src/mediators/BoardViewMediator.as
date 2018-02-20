/**
 * Created by Artem-Home on 06.09.2016.
 */
package mediators
{
	import data.Chip;
	import data.GameData;
	import data.Grid;
	
	import events.ChipEvent;
	import events.LevelEvent;
	
	import ru.arslanov.starling.mvc.context.IContext;
	import ru.arslanov.starling.mvc.mediators.Mediator;
	
	import starling.events.Event;
	
	import utils.MatchAwardCalculator;
	import utils.MoveChipCondition;
	
	import views.ChipView;
	import views.BoardView;
	
	public class BoardViewMediator extends Mediator
	{
		private var _grid:Grid;
		
		public function BoardViewMediator(context:IContext)
		{
			super(context);
		}
		
		override public function initialize(displayObject:Object):void
		{
			super.initialize(displayObject);
			
			_grid = injector.getOf(Grid);
			
			addContextListener(LevelEvent.LEVEL_CREATED, onLevelCreated);
			addViewListener(ChipEvent.CHIP_DROPPED, onChipDropped);
			addViewListener(ChipEvent.CHIP_MOVED, onChipMoved);
			
			onLevelCreated();
		}
		
		override public function destroy():void
		{
			view.removeEventListener(BoardView.FINISH_ANIMATION, onFinishAnimation);
			removeContextListener(LevelEvent.LEVEL_CREATED, onLevelCreated);
			removeViewListener(ChipEvent.CHIP_DROPPED, onChipDropped);
			removeViewListener(ChipEvent.CHIP_MOVED, onChipMoved);
			super.destroy();
		}
		
		private function get view():BoardView { return getView() as BoardView; }
		
		private function onLevelCreated(event:LevelEvent = null):void
		{
			view.removeAll();
			view.addEventListener(BoardView.FINISH_ANIMATION, onFinishAnimation);
			view.draw(_grid);
			view.x = int((view.stage.width - view.width) / 2);
			view.y = int((view.stage.height - view.height) / 2);
		}
		
		private function onChipDropped(event:ChipEvent):void
		{
			var dragChipView:ChipView = event.target as ChipView;
			var dragChip:Chip = dragChipView.model;
			
			if (MoveChipCondition.checkMove(dragChip, dragChip.col, dragChip.row)) {
				view.addEventListener(BoardView.FINISH_ANIMATION, onFinishAnimation);
				view.updatePositionChips(Vector.<Chip>([dragChipView.model]));
			} else {
				view.cancelMove(dragChip);
//				view.updatePositionChips(Vector.<Chip>([dragChip]));
			}
		}
		
		private function onChipMoved(event:ChipEvent):void
		{
			var dragChipView:ChipView = event.target as ChipView;
			var dragChip:Chip = dragChipView.model;
			
			var newCol:int = view.getColumn(dragChipView.x);
			var newRow:int = view.getRow(dragChipView.y);
			
			var pushedChip:Chip = _grid.getChip(newCol, newRow);
			var chips:Vector.<Chip>;
			
			if (MoveChipCondition.checkMove(dragChip, newCol, newRow)) {
				_grid.makeSwap(dragChip.col, dragChip.row, newCol, newRow);
				view.addEventListener(BoardView.FINISH_ANIMATION, onFinishAnimation);
				view.updatePositionChips(Vector.<Chip>([pushedChip]));
//				chips = Vector.<Chip>([pushedChip]);
			} else {
//				if (pushedChip && pushedChip != dragChip) view.cancelMove(pushedChip);
//				chips = Vector.<Chip>([dragChip]);
			}
//			view.updatePositionChips(chips);
		}
		
		private function onFinishAnimation(event:Event):void
		{
			trace("*execute* BoardViewMediator::onFinishAnimation()");
			view.stage.removeEventListener(BoardView.FINISH_ANIMATION, onFinishAnimation);
//			findAndRemoveMatches();
		}
		
		private function findAndRemoveMatches():void
		{
			trace("*execute* BoardViewMediator::findAndRemoveMatches()");
			var matches:Vector.<Vector.<Chip>> = _grid.findAndRemoveMatches();
			if (matches.length == 0) return;
			view.collapseChips(matches);
			calculateAwards(matches);
		}
		
		private function calculateAwards(matchesList:Vector.<Vector.<Chip>>):void
		{
			var award:Number = 0;
			var chips:Vector.<Chip>;
			for (var i:int = 0; i < matchesList.length; i++) {
				chips = matchesList[i];
				award += MatchAwardCalculator.calculateAward(chips);
			}
			
			var gameData:GameData = injector.getOf(GameData);
			gameData.score += award;
			trace("Score : " + gameData.score);
		}
	}
}

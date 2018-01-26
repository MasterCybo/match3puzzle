/**
 * Created by Artem-Home on 06.09.2016.
 */
package mediators
{
	import animations.events.AnimationEvent;
	
	import data.Chip;
	import data.GameData;
	import data.Grid;
	
	import events.ChipEvent;
	import events.LevelEvent;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import ru.arslanov.flash.mvc.context.IContextModule;
	import ru.arslanov.flash.mvc.mediators.Mediator;
	
	import utils.MatchAwardCalculator;
	import utils.MoveChipCondition;
	
	import views.ChipView;
	import views.GridView;
	
	public class GridViewMediator extends Mediator
	{
		private var _grid:Grid;
		
		public function GridViewMediator(context:IContextModule)
		{
			super(context);
		}
		
		override public function initialize(displayObject:DisplayObject):void
		{
			super.initialize(displayObject);
			
			_grid = getInstance(Grid);
			
			addEventListener(LevelEvent.LEVEL_CREATED, onLevelCreated);
			addViewListener(ChipEvent.CHIP_MOVED, onChipMoved);
		}
		
		override public function destroy():void
		{
			view.removeEventListener(GridView.FINISH_ANIMATION, onFinishAnimation);
			removeEventListener(LevelEvent.LEVEL_CREATED, onLevelCreated);
			removeViewListener(ChipEvent.CHIP_MOVED, onChipMoved);
			super.destroy();
		}
		
		private function get view():GridView { return getView() as GridView; }
		
		private function onLevelCreated(event:LevelEvent):void
		{
			view.removeAll();
			view.addEventListener(GridView.FINISH_ANIMATION, onFinishAnimation);
			view.update(_grid);
			view.x = int((view.stage.width - view.width) / 2);
			view.y = int((view.stage.height - view.height) / 2);
		}
		
		private function onChipMoved(event:ChipEvent):void
		{
			var dragChipView:ChipView = event.target as ChipView;
			var dragChip:Chip = dragChipView.model;
			
			var newCol:int = view.getColumn(dragChipView.x);
			var newRow:int = view.getRow(dragChipView.y);
			
			var dropChip:Chip = _grid.getChip(newCol, newRow);
			
			if (MoveChipCondition.checkMove(dragChip, newCol, newRow)) {
				_grid.makeSwap(dragChip.col, dragChip.row, newCol, newRow);
				view.addEventListener(GridView.FINISH_ANIMATION, onFinishAnimation);
				view.updatePositionChips(Vector.<Chip>([dragChip, dropChip]));
			} else {
				if (dropChip && dropChip != dragChip) view.cancelMove(dropChip);
			}
//			view.updatePositionChips(Vector.<Chip>([dragChip]));
		}
		
		private function onFinishAnimation(event:Event):void
		{
			trace("*execute* GridViewMediator::onFinishAnimation()");
//			view.stage.removeEventListener(GridView.FINISH_ANIMATION, onFinishAnimation);
			findAndRemoveMatches();
		}
		
		private function findAndRemoveMatches():void
		{
			trace("*execute* GridViewMediator::findAndRemoveMatches()");
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
			
			var gameData:GameData = getInstance(GameData);
			gameData.score += award;
			trace("Score : " + gameData.score);
		}
	}
}

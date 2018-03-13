/**
 * Created by Artem-Home on 06.09.2016.
 */
package views
{
	import animations.AnimationProperty;
	import animations.FAnimate;
	import animations.IAnimationGroup;
	import animations.events.AnimationEvent;
	
	import collections.Dimension;
	
	import data.Cell;
	import data.Chip;
	import data.Grid;
	
	import starling.events.Event;
	import starling.textures.Texture;
	
	import utils.Assets;
	
	import views.layers.CellsLayer;
	import views.layers.ChipsLayer;
	
	public class BoardView extends BaseView
	{
		public static const FINISH_ANIMATION:String = "finishAnimation";
		public static const FINISH_COLLAPSE:String = "finishCollapse";
		
		private var _cellsLayer:CellsLayer;
		private var _chipsLayer:ChipsLayer;
		private var _emittersLayer:BaseView;
		
		private var _grid:Grid;
		
		public function BoardView()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			var cellTexture:Texture = Assets.me.getTexture("cell_bg");
			
			_cellsLayer = new CellsLayer();
			_chipsLayer = new ChipsLayer(cellTexture.width, cellTexture.height);
			_emittersLayer = new BaseView();
			
			addChild(_cellsLayer);
			addChild(_chipsLayer);
			addChild(_emittersLayer);
		}
		
		override public function dispose():void
		{
			stage.removeEventListener(FINISH_COLLAPSE, onFinishCollapse);
			super.dispose();
			
			_grid = null;
		}
		
		public function removeAll():void
		{
			if (_cellsLayer) _cellsLayer.removeChildren();
			if (_chipsLayer) _chipsLayer.removeChildren();
			if (_emittersLayer) _emittersLayer.removeChildren();
		}
		
		public function getColumn(localX:Number):int { return localX / Dimension.CELL_WIDTH; }
		public function getRow(localY:Number):int { return localY / Dimension.CELL_HEIGHT; }
		public function getCell(cell:Cell):CellView { return _cellsLayer.getCellView(cell); }
		public function getChip(chip:Chip):ChipView { return _chipsLayer.getChipView(chip); }
		
		public function draw(grid:Grid):void
		{
			_grid = grid;
			
			_cellsLayer.draw(_grid);
			_chipsLayer.draw(_grid);
			
//			update(grid);
		}
		
		public function update(grid:Grid):void
		{
			var animation:IAnimationGroup = FAnimate.me.spawn();
			animation.addEventListener(FINISH_ANIMATION, onFinishAnimation);
			
			
			animation.start(null, null, FINISH_ANIMATION);
		}
		
		private function onFinishAnimation(event:AnimationEvent):void
		{
			event.target.removeEventListener(FINISH_ANIMATION, onFinishAnimation);
			dispatchEvent(new Event(FINISH_ANIMATION, true));
		}
		
//		public function removeChip(chip:Chip):void
//		{
//			var chipView:ChipView = _chips[chip];
//			delete _chips[chip];
//			if (!chipView) return;
//			_chipsLayer.removeChild(chipView);
//			chipView.dispose();
//		}
		
		public function updatePositionChips(chips:Vector.<Chip> = null):void
		{
			trace("*execute* GridView::updatePositionChips()");
			var chipView:ChipView;
			var cellView:CellView;
			var cell:Cell;
			var animation:IAnimationGroup = FAnimate.me.move();
			var animProps:AnimationProperty = animation.getProperty();
			if (!chips) {
//				for each (chipView in _chips) {
//					chipView.debugUpdate();
//					cell = chipView.model.grid.getCell(chipView.model.col, chipView.model.row);
//					cellView = getCell(cell);
////					animProps.setPosition(cellView.centerX, cellView.centerY);
////					animation.addTarget(chipView, animProps);
//				}
			} else {
				var chip:Chip;
				for (var i:int = 0; i < chips.length; i++) {
					chip = chips[i];
					chipView = getChip(chip);
					chipView.debugUpdate();
					cell = chipView.model.grid.getCell(chipView.model.col, chipView.model.row);
					cellView = getCell(cell);
					if (chipView.x != cellView.centerX || chipView.y != cellView.centerY) {
						chipView.x = cellView.centerX;
						chipView.y = cellView.centerY;
//						animProps.setPosition(cellView.centerX, cellView.centerY);
//						animation.addTarget(chipView, animProps);
					}
				}
			}
//			animation.start(null, null, FINISH_ANIMATION);
		}
		
		public function cancelMove(chip:Chip):void
		{
			FAnimate.me.lock().to(getChip(chip)).start();
		}
		
		public function collapseChips(matchesList:Vector.<Vector.<Chip>>):void
		{
			if (matchesList.length == 0) return;
			
			trace("*execute* GridView::collapseChips()");
			
			var chip:Chip;
			var chipView:ChipView;
			var matches:Vector.<Chip>;
			var animation:IAnimationGroup = FAnimate.me.collapse();
			animation.addEventListener(FINISH_COLLAPSE, onFinishCollapse);
			for (var i:int = 0; i < matchesList.length; i++) {
				matches = matchesList[i];
				for (var j:int = 0; j < matches.length; j++) {
					chip = matches[j];
					chipView = getChip(chip);
					if (chipView) { // Фишка могла быть уже удалена, например, на перекрёстке
						chipView.debugCollapse();
						animation.to(chipView);
//						delete _chips[chip];
					}
				}
			}
			animation.start(null, null, FINISH_COLLAPSE);
		}
		
		private function onFinishCollapse(event:AnimationEvent):void
		{
			trace("*execute* GridView::onFinishCollapse()");
			event.target.removeEventListener(FINISH_COLLAPSE, onFinishCollapse);
//			updatePositionChips();
		}
	}
}

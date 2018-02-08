/**
 * Created by Artem-Home on 06.09.2016.
 */
package views
{
	import animations.AnimationFactory;
	import animations.AnimationProperty;
	import animations.IAnimationGroup;
	import animations.events.AnimationEvent;
	
	import collections.Dimension;
	import collections.EnumCellType;
	
	import data.Cell;
	import data.Chip;
	import data.Grid;
	
	import flash.utils.Dictionary;
	
	import starling.events.Event;
	import starling.textures.Texture;
	
	import utils.Assets;
	
	import views.layers.ChipsLayer;
	
	public class GridView extends BaseView
	{
		public static const FINISH_ANIMATION:String = "finishAnimation";
		public static const FINISH_COLLAPSE:String = "finishCollapse";
		
		private var _cells:Dictionary = new Dictionary();
		private var _chips:Dictionary = new Dictionary();
		
		private var _cellsLayer:BaseView;
		private var _chipsLayer:BaseView;
		private var _emittersLayer:BaseView;
		
		public function GridView()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			_cellsLayer = new BaseView();
			_chipsLayer = new ChipsLayer();
			_emittersLayer = new BaseView();

			addChild(_cellsLayer);
			addChild(_chipsLayer);
			addChild(_emittersLayer);
		}
		
		override public function dispose():void
		{
			stage.removeEventListener(FINISH_COLLAPSE, onFinishCollapse);
			super.dispose();
			_cells = null;
			_chips = null;
		}
		
		public function removeAll():void
		{
			if (_cellsLayer) _cellsLayer.removeChildren();
			if (_chipsLayer) _chipsLayer.removeChildren();
			if (_emittersLayer) _emittersLayer.removeChildren();
		}
		
		public function getColumn(localX:Number):int { return localX / Dimension.CELL_WIDTH; }
		public function getRow(localY:Number):int { return localY / Dimension.CELL_HEIGHT; }
		public function getCell(cell:Cell):CellView { return _cells[cell]; }
		public function getChip(chip:Chip):ChipView { return _chips[chip]; }
		
		public function update(grid:Grid):void
		{
			var animation:IAnimationGroup = AnimationFactory.me.makeSpawn();
			animation.addEventListener(FINISH_ANIMATION, onFinishAnimation);
			
			var cell:Cell;
			var chip:Chip;
			var cellView:CellView;
			var chipView:ChipView;
			
			for (var col:int = 0; col < grid.numCols; col++) {
				for (var row:int = 0; row < grid.numRows; row++) {
					cell = grid.getCell(col, row);
					if (cell.type != EnumCellType.CELL_INVISIBLE) {
						cellView = getCell(cell);
						if (!cellView) {
							var texture:Texture = Assets.me.getTexture("cell_bg");
							cellView = new CellView(cell, texture, null);
							cellView.x = col * Dimension.CELL_WIDTH;
							cellView.y = row * Dimension.CELL_HEIGHT;
							cellView.updateDebug(col, row);
							_cellsLayer.addChild(cellView);
							_cells[cell] = cellView;
							
							if (cell.type == EnumCellType.CELL_EMITTER) {
//								var emitterView:EmitterView = new EmitterView();
//								emitterView.x = cellView.centerX;
//								emitterView.y = cellView.y;
//								_emittersLayer.addChild(emitterView);
							}
						}
						
						chip = grid.getChip(col, row);
						if (chip) {
							chipView = getChip(chip);
							if (!chipView) {
								chipView = new ChipView(chip, Assets.me.getTexture(chip.type.value));
								chipView.x = cellView.centerX;
								chipView.y = cellView.centerY;
								_chipsLayer.addChild(chipView);
								_chips[chip] = chipView;
								animation.addTarget(chipView);
							}
						}
					}
				}
			}
			animation.start(null, null, FINISH_ANIMATION);
		}
		
		private function onFinishAnimation(event:AnimationEvent):void
		{
			event.target.removeEventListener(FINISH_ANIMATION, onFinishAnimation);
			dispatchEvent(new Event(FINISH_ANIMATION, true));
		}
		
		public function removeChip(chip:Chip):void
		{
			var chipView:ChipView = _chips[chip];
			delete _chips[chip];
			if (!chipView) return;
			_chipsLayer.removeChild(chipView);
			chipView.dispose();
		}
		
		public function updatePositionChips(chips:Vector.<Chip> = null):void
		{
			trace("*execute* GridView::updatePositionChips()");
			var chipView:ChipView;
			var cellView:CellView;
			var cell:Cell;
			var animation:IAnimationGroup = AnimationFactory.me.makeMoveTo();
			var animProps:AnimationProperty = animation.getProperty();
			if (!chips) {
				for each (chipView in _chips) {
//					chipView.debugUpdate();
					cell = chipView.model.grid.getCell(chipView.model.col, chipView.model.row);
					cellView = getCell(cell);
					animProps.setPosition(cellView.centerX, cellView.centerY);
					animation.addTarget(chipView, animProps);
				}
			} else {
				var chip:Chip;
				for (var i:int = 0; i < chips.length; i++) {
					chip = chips[i];
					chipView = getChip(chip);
//					chipView.debugUpdate();
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
			AnimationFactory.me.makeLocked().addTarget(getChip(chip)).start();
		}
		
		public function collapseChips(matchesList:Vector.<Vector.<Chip>>):void
		{
			if (matchesList.length == 0) return;
			
			trace("*execute* GridView::collapseChips()");
			
			var chip:Chip;
			var chipView:ChipView;
			var matches:Vector.<Chip>;
			var animation:IAnimationGroup = AnimationFactory.me.makeCollapse();
			animation.addEventListener(FINISH_COLLAPSE, onFinishCollapse);
			for (var i:int = 0; i < matchesList.length; i++) {
				matches = matchesList[i];
				for (var j:int = 0; j < matches.length; j++) {
					chip = matches[j];
					chipView = getChip(chip);
					if (chipView) { // Фишка могла быть уже удалена, например, на перекрёстке
						chipView.debugCollapse();
						animation.addTarget(chipView);
						delete _chips[chip];
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

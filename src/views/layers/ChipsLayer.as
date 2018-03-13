/**
 * Created by Artem-Home on 07.09.2016.
 */
package views.layers
{
	import animations.FAnimate;
	
	import data.Chip;
	import data.Grid;
	
	import events.ChipEvent;
	
	import flash.utils.Dictionary;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import utils.Assets;
	
	import views.BaseView;
	import views.ChipView;
	
	public class ChipsLayer extends BaseView
	{
		private var _isLocked:Boolean;
		private var _offsetX:int;
		private var _offsetY:int;
		private var _beganX:int;
		private var _beganY:int;
		private var _deltaMove:int;
		private var _isHorizontal:Boolean;
		private var _isDropped:Boolean;
		private var _grid:Grid;
		private var _chips:Dictionary = new Dictionary();
		private var _cellWidth:int;
		private var _cellHeight:int;
		private var _selectedChip:ChipView;
		
		public function ChipsLayer(cellWidth:int, cellHeight:int)
		{
			super();
			
			_cellWidth = cellWidth;
			_cellHeight = cellHeight;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			addEventListener(TouchEvent.TOUCH, touchHandler);
		}
		
		override public function dispose():void
		{
			removeEventListener(TouchEvent.TOUCH, touchHandler);
			super.dispose();
			
			_grid = null;
		}
		
		public function get cellWidth():int {return _cellWidth;}
		public function get cellHeight():int {return _cellHeight;}
		
		public function getChipView(chip:Chip):ChipView { return _chips[chip]; }
		
		public function draw(grid:Grid):void
		{
			_grid = grid;
			
			var chip:Chip;
			var chipView:ChipView;
			
			for (var col:int = 0; col < _grid.numCols; col++) {
				for (var row:int = 0; row < _grid.numRows; row++) {
					chip = _grid.getChip(col, row);
					if (chip) {
						chipView = getChipView(chip);
						if (!chipView) {
							chipView = new ChipView(chip, Assets.me.getTexture(chip.type.value));
							chipView.x = col * _cellWidth + int(_cellWidth / 2);
							chipView.y = row * _cellHeight + int(_cellHeight / 2);
							addChild(chipView);
							_chips[chip] = chipView;
						}
					}
				}
			}
		}
		
		private function touchHandler(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this);
			if (!touch) return;
			
			var chipView:ChipView = this.hitTest(touch.getLocation(this)) as ChipView;
			
			if (!chipView) return;
			
			switch (touch.phase) {
				case TouchPhase.BEGAN:
					_isDropped = false;
					if(chipView.model.movable) {
						FAnimate.me.selection().to(chipView).start();
						addChild(chipView);
						_offsetX = touch.globalX - chipView.x;
						_offsetY = touch.globalY - chipView.y;
						_beganX = chipView.x;
						_beganY = chipView.y;
					} else {
						_isLocked = true;
						FAnimate.me.lock().to(chipView).start();
					}
					
					if (_selectedChip && _selectedChip != chipView) _selectedChip.selected = false;
					_selectedChip = chipView;
					break;
				case TouchPhase.MOVED:
					if (!_isDropped) {
						var deltaX:int = Math.abs(touch.globalX - _beganX);
						var deltaY:int = Math.abs(touch.globalY - _beganY);
						var deltaMove:int;
						
						if (deltaX > 0) {
							if (deltaX > deltaY) {
								_isHorizontal = true;
								deltaMove = _cellWidth;
							}
						}
						if (deltaY > 0) {
							if (deltaX <= deltaY) {
								_isHorizontal = false;
								deltaMove = _cellHeight;
							}
						}
						
						_deltaMove = Math.max(deltaX, deltaY);
						
						chipView.x = int(!_isHorizontal) * _beganX + int(_isHorizontal) * (touch.globalX - _offsetX);
						chipView.y = int(_isHorizontal) * _beganY + int(!_isHorizontal) * (touch.globalY - _offsetY);
						chipView.dispatchEvent(new ChipEvent(ChipEvent.CHIP_MOVED));
						
						if (_deltaMove > deltaMove / 2) {
							dropChip(chipView);
						}
					}
					break;
				case TouchPhase.ENDED:
//					if (!_isDropped) chipView.dispatchEvent(new ChipEvent(ChipEvent.CHIP_DROPPED));
					break;
			}
		}
		
		private function dropChip(chipView:ChipView):void
		{
			_isDropped = true;
			
			FAnimate.me.deselection().to(chipView).start();
			if (!_isLocked) {
				chipView.dispatchEvent(new ChipEvent(ChipEvent.CHIP_DROPPED));
			}
			_isLocked = false;
		}
	}
}

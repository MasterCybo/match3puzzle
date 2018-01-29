package ru.arslanov.starling.gui.controls
{
	import ru.arslanov.starling.display.ASprite;
	
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class StButtonToggleBase extends ASprite
	{
		
		public var onPress:Function;
		public var onRelease:Function;
		
		private var _touchPhase:String = null;
		private var _isPressed:Boolean = false;
		private var _body:ASprite;
		private var _skin:StButtonSkinBase;
		private var _curSkin:DisplayObject;
		private var _enabled:Boolean;
		private var _touch:Touch;
		
		public function StButtonToggleBase(skin:StButtonSkinBase)
		{
			_skin = skin;
			
			super();
			
			_body = new ASprite();
			addChild(_body);
			
			enabled = true;
			
			setState(TouchPhase.ENDED);
		}
		
		protected function handlerTouch(ev:TouchEvent):void
		{
			_touch = ev.touches[0];
			
			setState(_touch.phase);
			callHandlers(_touch.phase);
		}
		
		public function setState(touchPhase:String, forced:Boolean = false):void
		{
			if ((touchPhase == TouchPhase.HOVER) || (touchPhase == TouchPhase.MOVED)) return;
			
			if ((touchPhase == _touchPhase) && !forced) return;
			
			if (_curSkin) _body.removeChild(_curSkin);
			
			switch (touchPhase) {
				case TouchPhase.BEGAN:
					_isPressed = true;
					if (skin.downSkin) _curSkin = skin.downSkin;
					break;
				default:
					_isPressed = false;
					_curSkin = skin.upSkin;
			}
			
			_body.addChild(_curSkin);
			
			if (skin.label && !contains(skin.label)) {
				skin.label.touchable = false;
				addChild(skin.label as DisplayObject);
			}
			
			skin.updateLabelPosition();
			//skin.updateHitAreaPosition();
			
			_touchPhase = touchPhase;
		}
		
		private function callHandlers(touchPhase:String):void
		{
			switch (touchPhase) {
				case TouchPhase.BEGAN:
					if (onPress != null) {
						if (onPress.length == 1) {
							onPress(this);
						} else {
							onPress();
						}
					}
					break;
				case TouchPhase.ENDED:
					if (onRelease != null) {
						if (onRelease.length == 1) {
							onRelease(this);
						} else {
							onRelease();
						}
					}
					break;
				default:
			}
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void
		{
			if (value == _enabled) return;
			
			_enabled = value;
			
			useHandCursor = _enabled;
			touchable = _enabled;
			
			if (_enabled) {
				addEventListener(TouchEvent.TOUCH, handlerTouch);
			} else {
				removeEventListener(TouchEvent.TOUCH, handlerTouch);
			}
		}
		
		public function get skin():StButtonSkinBase
		{
			return _skin;
		}
		
		override public function set width(value:Number):void
		{
			skin.setSize(value, height);
		}
		
		override public function set height(value:Number):void
		{
			skin.setSize(width, value);
		}

		override public function kill():void
		{
			enabled = false;
			
			onRelease = null;
			onPress = null;
			
			super.kill();
			
			_body = null;
			_skin = null;
			_curSkin = null;
			_touch = null;
		}
		
	}

}
/**
 * Created by Artem-Home on 19.09.2016.
 */
package animations
{
	public class AnimationProperty
	{
		public var duration:Number = 1;
		
		public var x:Number;
		public var y:Number;
		
		public var scaleX:Number;
		public var scaleY:Number;
		
		public var alpha:Number;
		
		private var _params:Object;
		
		public function AnimationProperty()
		{
		}
		
		public function toObject():Object
		{
			if (!_params) _params = {};
			
			switch (true) {
				case !isNaN(x): _params.x = x;
				case !isNaN(y): _params.y = y;
				case !isNaN(scaleX): _params.scaleX = scaleX;
				case !isNaN(scaleY): _params.scaleY = scaleY;
				case !isNaN(alpha): _params.alpha = alpha;
			}
			
			return _params;
		}
		
		public function position(x:Number, y:Number):AnimationProperty
		{
			this.x = x;
			this.y = y;
			return this;
		}
		
		public function scale(scale:Number):AnimationProperty
		{
			this.scaleX = scale;
			this.scaleY = scale;
			return this;
		}
	}
}

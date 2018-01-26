/**
 * Created by Artem-Home on 19.09.2016.
 */
package animations
{
	public class AnimationProperty
	{
		public var x:Number;
		public var y:Number;
		
		public var scaleX:Number;
		public var scaleY:Number;
		
		public var alpha:Number;
		
		public function AnimationProperty()
		{
		}
		
		public function toObject():Object
		{
			var obj:Object = {};
			
			switch (true) {
				case !isNaN(x):obj.x = x;
				case !isNaN(y):obj.y = y;
				case !isNaN(scaleX):obj.scaleX = scaleX;
				case !isNaN(scaleY):obj.scaleY = scaleY;
				case !isNaN(alpha):obj.alpha = alpha;
			}
			
			return obj;
		}
		
		public function setPosition(x:Number, y:Number):AnimationProperty
		{
			this.x = x;
			this.y = y;
			return this;
		}
		
		public function toScale(x:Number, y:Number):AnimationProperty
		{
			this.scaleX = x;
			this.scaleY = y;
			return this;
		}
	}
}

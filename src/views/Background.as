/**
 * Created by Artem-Home on 05.09.2016.
 */
package views
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import mach3.BackgroundImage;
	
	public class Background extends Bitmap
	{
		public function Background()
		{
			super(new BackgroundImage(), "auto", true);
		}
	}
}

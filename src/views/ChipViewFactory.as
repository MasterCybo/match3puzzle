/**
 * Created by Artem-Home on 06.09.2016.
 */
package views
{
	import collections.EnumChipType;
	
	import data.Chip;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import mach3.BoxImage;
	import mach3.ChipImage1;
	import mach3.ChipImage2;
	import mach3.ChipImage3;
	import mach3.ChipImage4;
	import mach3.ChipImage5;
	
	public class ChipViewFactory
	{
		public function ChipViewFactory()
		{
		}
		
		public static function createChipView(chip:Chip):ChipView
		{
			var view:ChipView = new ChipView(chip, getChipImage(chip.type));
			return view;
		}
		
		public static function getChipImage(type:EnumChipType):Bitmap
		{
			var bd:BitmapData;
			switch (type) {
				case EnumChipType.CHIP_TYPE_1: bd = new ChipImage1(); break;
				case EnumChipType.CHIP_TYPE_2: bd = new ChipImage2(); break;
				case EnumChipType.CHIP_TYPE_3: bd = new ChipImage3(); break;
				case EnumChipType.CHIP_TYPE_4: bd = new ChipImage4(); break;
				case EnumChipType.CHIP_TYPE_5: bd = new ChipImage5(); break;
				case EnumChipType.CHIP_TYPE_6: bd = new BoxImage(); break;
				default: bd = new BitmapData(10, 10, true, 0x80FF0000);
			}
			var bitmap:Bitmap = new Bitmap(bd, "auto", true);
			return bitmap;
		}
	}
}

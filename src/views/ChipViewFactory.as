/**
 * Created by Artem-Home on 06.09.2016.
 */
package views
{
	import data.Chip;
	
	import utils.Assets;
	
	public class ChipViewFactory
	{
		public function ChipViewFactory()
		{
		}
		
		public static function createChipView(chip:Chip):ChipView
		{
			var view:ChipView = new ChipView(chip, Assets.me.getTexture(chip.type.value));
			return view;
		}
	}
}

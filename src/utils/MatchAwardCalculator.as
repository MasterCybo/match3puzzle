/**
 * Created by Artem-Home on 08.09.2016.
 */
package utils
{
	import collections.EnumChipType;
	
	import data.Chip;
	
	public class MatchAwardCalculator
	{
		public static const AWARD_TYPE_1:Number = 1;
		public static const AWARD_TYPE_2:Number = 5;
		public static const AWARD_TYPE_3:Number = 10;
		public static const AWARD_TYPE_4:Number = 20;
		public static const AWARD_TYPE_5:Number = 40;
		
		public function MatchAwardCalculator()
		{
		}
		
		public static function calculateAward(chips:Vector.<Chip>):Number
		{
			var award:Number = 0;
			if (chips.length > 0) {
				var type:EnumChipType = chips[0].type;
				switch (type) {
					case EnumChipType.CHIP_TYPE_1:
						award = AWARD_TYPE_1;
						break;
					case EnumChipType.CHIP_TYPE_2:
						award = AWARD_TYPE_2;
						break;
					case EnumChipType.CHIP_TYPE_3:
						award = AWARD_TYPE_3;
						break;
					case EnumChipType.CHIP_TYPE_4:
						award = AWARD_TYPE_4;
						break;
					case EnumChipType.CHIP_TYPE_5:
						award = AWARD_TYPE_5;
						break;
				}
			}
			award *= chips.length;
			return award;
		}
	}
}

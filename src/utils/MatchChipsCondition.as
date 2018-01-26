/**
 * Created by Artem-Home on 08.09.2016.
 */
package utils
{
	import data.Chip;
	
	public class MatchChipsCondition
	{
		public function MatchChipsCondition()
		{
		}
		
		public static function checkMatch(chip1:Chip, chip2:Chip):Boolean
		{
			return chip1 && chip2 && chip1.movable && chip2.movable && chip1.type == chip2.type;
		}
	}
}

/**
 * Created by Artem-Home on 05.09.2016.
 */
package collections
{
	import ru.arslanov.core.enum.EnumString;
	
	public class EnumChipType extends EnumString
	{
		public static const CHIP_TYPE_1:EnumChipType = new EnumChipType("chip_01");
		public static const CHIP_TYPE_2:EnumChipType = new EnumChipType("chip_02");
		public static const CHIP_TYPE_3:EnumChipType = new EnumChipType("chip_03");
		public static const CHIP_TYPE_4:EnumChipType = new EnumChipType("chip_04");
		public static const CHIP_TYPE_5:EnumChipType = new EnumChipType("chip_05");
		public static const CHIP_TYPE_6:EnumChipType = new EnumChipType("chip_06");
		
		public function EnumChipType(type:String)
		{
			super(type);
		}
	}
}

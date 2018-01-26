/**
 * Created by Artem-Home on 05.09.2016.
 */
package collections
{
	import ru.arslanov.core.enum.EnumString;
	
	public class EnumChipType extends EnumString
	{
		public static const CHIP_TYPE_1:EnumChipType = new EnumChipType("blob");
		public static const CHIP_TYPE_2:EnumChipType = new EnumChipType("tomato");
		public static const CHIP_TYPE_3:EnumChipType = new EnumChipType("radish");
		public static const CHIP_TYPE_4:EnumChipType = new EnumChipType("corn");
		public static const CHIP_TYPE_5:EnumChipType = new EnumChipType("broccoli");
		public static const CHIP_TYPE_6:EnumChipType = new EnumChipType("box");
		
		public function EnumChipType(type:String)
		{
			super(type);
		}
	}
}

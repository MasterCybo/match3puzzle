/**
 * Created by Artem-Home on 05.09.2016.
 */
package collections
{
	import ru.arslanov.core.enum.EnumString;
	
	public class EnumCellType extends EnumString
	{
		public static const CELL_INVISIBLE:EnumCellType = new EnumCellType("0");
		public static const CELL_NORMAL:EnumCellType = new EnumCellType("1");
		public static const CELL_EMITTER:EnumCellType = new EnumCellType("2");
		public static const CELL_DIRTY:EnumCellType = new EnumCellType("3");
		
		public function EnumCellType(type:String):void
		{
			super(type);
		}
	}
}

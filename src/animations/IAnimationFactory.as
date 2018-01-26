/**
 * Created by Artem-Home on 08.09.2016.
 */
package animations
{
	public interface IAnimationFactory
	{
		function makeLocked():IAnimationGroup;
		function makeMoveTo():IAnimationGroup;
		function makeSelection():IAnimationGroup;
		function makeDeselection():IAnimationGroup;
		function makeCollapse():IAnimationGroup;
		function makeSpawn():IAnimationGroup;
	}
}

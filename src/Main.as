package
{
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import ru.arslanov.starling.StarlingManager;
	
	[SWF(backgroundColor="#FFFFFF", frameRate="60", width="640", height="1136")]
	public class Main extends Sprite
	{
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			StarlingManager.create(StarlingRoot, stage);
			
//			var matchGame:AppMatchPuzzle = new AppMatchPuzzle();
//			addChild(matchGame);
		}
	}
}

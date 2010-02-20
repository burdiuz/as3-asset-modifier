package modifiers{
	import aw.projects.assetmodifier.modifiers.IAssetModifier;
	
	import flash.display.MovieClip;
	import flash.utils.getQualifiedClassName;

	public class ExampleInstanceModifier extends Object implements IAssetModifier{
		static public const LABEL:String = 'exampleInstance';
		public function ExampleInstanceModifier():void{
			super();
			trace('Modifier added to manager as instance, created');
		}
		
		public function get label():String{
			return LABEL;
		}
		
		public function getHandler(clip:MovieClip, rawParametersString:String=''):Function{
			return this.handler;
		}
		protected function handler():void{
			trace(getQualifiedClassName(this), 'handler called');
		}
	}
}
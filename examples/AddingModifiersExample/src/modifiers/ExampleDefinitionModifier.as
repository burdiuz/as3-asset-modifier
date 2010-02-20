package modifiers{
	import aw.projects.assetmodifier.modifiers.IAssetModifier;
	import aw.utils.EvalUtils;
	
	import flash.display.MovieClip;
	import flash.utils.getQualifiedClassName;

	public class ExampleDefinitionModifier extends Object implements IAssetModifier{
		static public const LABEL:String = 'exampleDefinition';
		protected var _clip:MovieClip;
		protected var _parameters:String;
		public function ExampleDefinitionModifier():void{
			super();
			trace('Modifier added to manager as definition, created');
		}
		
		public function get label():String{
			return LABEL;
		}
		
		public function getHandler(clip:MovieClip, rawParametersString:String=''):Function{
			this._clip = clip;
			this._parameters = rawParametersString;
			return this.handler;
		}
		protected function handler():void{
			trace(getQualifiedClassName(this), 'handler called');
			trace(EvalUtils.evaluate(this._parameters, this._clip));
		}
	}
}
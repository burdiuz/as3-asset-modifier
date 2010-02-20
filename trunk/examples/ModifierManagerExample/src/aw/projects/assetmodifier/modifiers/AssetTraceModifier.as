package aw.projects.assetmodifier.modifiers{
	import aw.projects.assetmodifier.utils.ModifierParserUtils;
	
	import flash.display.MovieClip;
	/**
		Syntax:
			.trace("some value")
			.trace(true, 123, "some value")
			.trace(this.currentFrame, 123, "some value")
			.trace(this.getChildAt(0).name, this.numChildren)
			.trace(this.numChildren ? this.getChildAt(0).name : 'no children')
	 * 
	 * @author Galaburda a_[w] Oleg    http://www.actualwave.com
	 * 
	 */
	public class AssetTraceModifier extends Object implements IAssetModifier{

		/** 
		* 
		* @public (constant) 
		*/
		static public const LABEL:String = 'trace';

		/** 
		* 
		* @public 
		* @return void 
		*/
		public function AssetTraceModifier():void{
			super();
		}
		

		/** 
		* 
		* @public (getter) 
		* @return String 
		*/
		public function get label():String{
			return LABEL;
		}
		

		/** 
		* 
		* @public 
		* @param clip 
		* @param rawParametersString 
		* @return Function 
		*/
		public function getHandler(clip:MovieClip, rawParametersString:String=''):Function{
			var handler:Function = function():void{
				var e:Object = arguments.callee;
				trace.apply(null, ModifierParserUtils.getArgumentsList(e.args, e.target));
			};
			(handler as Object).target = clip;
			(handler as Object).args = rawParametersString;
			return handler;
		}
	}
}
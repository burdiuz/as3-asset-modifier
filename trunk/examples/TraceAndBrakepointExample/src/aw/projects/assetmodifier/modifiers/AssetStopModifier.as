package aw.projects.assetmodifier.modifiers{
	import flash.display.MovieClip;

	/**
	 * 
	 * Syntax:
		.stop
		.stop(ANYTHING)
	 * 
	 * @author Galaburda a_[w] Oleg    http://www.actualwave.com
	 */
	public class AssetStopModifier extends Object implements IAssetModifier{

		/** 
		* 
		* @public (constant) 
		*/
		static public const LABEL:String = 'stop';

		/** 
		* 
		* @public 
		* @return void 
		*/
		public function AssetStopModifier():void{
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
				arguments.callee.target.stop();
			};
			(handler as Object).target = clip;
			return handler;
		}
		
	}
}
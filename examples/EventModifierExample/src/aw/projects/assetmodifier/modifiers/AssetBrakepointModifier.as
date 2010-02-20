package aw.projects.assetmodifier.modifiers{
	import flash.debugger.enterDebugger;
	import flash.display.MovieClip;
	/**
		Syntax:
			.breakpoint
	 * 
	 * @author Galaburda a_[w] Oleg    http://www.actualwave.com
	 * 
	 */
	public class AssetBrakepointModifier extends Object implements IAssetModifier{

		/** 
		* 
		* @public (constant) 
		*/
		static public const LABEL:String = 'breakpoint';

		/** 
		* 
		* @public 
		* @return void 
		*/
		public function AssetBrakepointModifier():void{
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
			return this.handler;
		}

		/** 
		* 
		* @private (protected) 
		* @return void 
		*/
		protected function handler():void{
			enterDebugger();
		}
	}
}
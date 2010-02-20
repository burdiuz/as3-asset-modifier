package aw.projects.assetmodifier.modifiers{
	import aw.projects.assetmodifier.utils.ModifierParserUtils;
	
	import flash.display.MovieClip;

	/**
		Syntax:
			.goto(1)
			.goto("label")
			.goto(12, "scene")
			.goto(13, "scene", "play")
			.goto("label", "scene", "stop")
			.goto("label", null, "stop")
	 * 
	 * @author Galaburda a_[w] Oleg    http://www.actualwave.com
	 * 
	 */
	public class AssetGotoModifier extends Object implements IAssetModifier{

		/** 
		* 
		* @public (constant) 
		*/
		static public const LABEL:String = 'goto';

		/** 
		* 
		* @public 
		* @return void 
		*/
		public function AssetGotoModifier():void{
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
			var arguments:Array = ModifierParserUtils.getArgumentsList(rawParametersString, clip);
			var method:Function = clip.gotoAndPlay;
			var frame:Object = arguments[0];
			var scene:Object = arguments[1];
			var type:* = arguments[2];
			if(type && ((type is String && type.toLowerCase()=='stop') || (type is Function && type==clip.stop))){
				method = clip.gotoAndStop;
			}
			var handler:Function = function():void{
				var e:Object = arguments.callee;
				e.method.apply(e.target, [e.frame, e.scene]);
			};
			(handler as Object).target = clip;
			(handler as Object).method = method;
			(handler as Object).frame = frame;
			(handler as Object).scene = scene ? scene : null;
			return handler;
		}
	}
}
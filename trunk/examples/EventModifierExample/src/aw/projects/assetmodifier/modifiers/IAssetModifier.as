package aw.projects.assetmodifier.modifiers{
	import flash.display.MovieClip;
	
	/**
	 * 
	 * @author Galaburda a_[w] Oleg    http://www.actualwave.com
	 * 
	 */
	public interface IAssetModifier{

		/** 
		* 
		* @public (getter) 
		*/
		function get label():String;
		function getHandler(clip:MovieClip, rawParametersString:String=''):Function;
	}
}
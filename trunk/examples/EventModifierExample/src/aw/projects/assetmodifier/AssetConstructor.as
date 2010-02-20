package aw.projects.assetmodifier{
	import flash.display.MovieClip;
	
	/**
	 * 
	 * @author Galaburda a_[w] Oleg    http://www.actualwave.com
	 * 
	 */
	public class AssetConstructor extends Object{

		/** 
		* 
		* @private (protected) 
		*/
		protected var _definition:Class;

		/** 
		* 
		* @private (protected) 
		* @see aw.projects.assetmodifier.ModifierManager 
		*/
		protected var _manager:ModifierManager;

		/** 
		* 
		* @public 
		* @param definition 
		* @param manager 
		* @return void 
		* @see aw.projects.assetmodifier.ModifierManager 
		*/
		public function AssetConstructor(definition:Class, manager:ModifierManager=null):void{
			super();
			_definition = definition;
			_manager = manager ? manager : ModifierManager.instance;
		}

		/** 
		* 
		* @public 
		* @return MovieClip 
		*/
		public function getAsset():MovieClip{
			return this._manager.apply(new this._definition());
		}
	}
}
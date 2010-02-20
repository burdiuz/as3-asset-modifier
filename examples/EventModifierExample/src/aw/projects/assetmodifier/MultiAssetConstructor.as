package aw.projects.assetmodifier{
	import flash.display.MovieClip;
	
	/**
	 * 
	 * @author Galaburda a_[w] Oleg    http://www.actualwave.com
	 * 
	 */
	public /* abstract */ class MultiAssetConstructor extends Object{

		/** 
		* 
		* @private (protected) 
		* @see aw.projects.assetmodifier.ModifierManager 
		*/
		protected var _manager:ModifierManager;

		/** 
		* 
		* @public 
		* @param manager 
		* @return void 
		* @see aw.projects.assetmodifier.ModifierManager 
		*/
		public function MultiAssetConstructor(manager:ModifierManager=null):void{
			super();
			_manager = manager ? manager : ModifierManager.instance;
		}

		/** 
		* 
		* @private (protected) 
		* @param definition 
		* @return MovieClip 
		*/
		protected function getAsset(definition:Class):MovieClip{
			return this._manager.apply(new definition());
		}
	}
}
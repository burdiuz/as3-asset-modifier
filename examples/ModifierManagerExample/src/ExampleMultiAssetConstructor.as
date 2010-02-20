package{
	import aw.projects.assetmanager.ModificatorManager;
	import aw.projects.assetmanager.MultiAssetConstructor;
	
	import flash.display.MovieClip;

	/**
	 * 
	 * @author Galaburda a_[w] Oleg    mailto:burdiuz@gmail.com
	 * 
	 */
	public class ExampleMultiAssetConstructor extends MultiAssetConstructor{
		[Embed(source='../asset.swf', symbol='Asset')]
		static public const ASET_DEFINITION:Class;
		public function ExampleMultiAssetConstructor(manager:ModificatorManager=null):void{
			super(manager);
		}
		public function getExampleAsset():MovieClip{
			return this.getAsset(ASET_DEFINITION);
		}
	}
}
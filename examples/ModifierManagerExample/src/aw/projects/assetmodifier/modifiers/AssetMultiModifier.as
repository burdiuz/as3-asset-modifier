package aw.projects.assetmodifier.modifiers{
	import __AS3__.vec.Vector;
	
	import flash.display.MovieClip;
	/**
		Syntax:
			.anyLabel
	 * 
	 * @author Galaburda a_[w] Oleg    http://www.actualwave.com
	 * 
	 */
	public class AssetMultiModifier extends Object implements IAssetModifier{

		/** 
		* 
		* @private (protected) 
		*/
		protected var _label:String;

		/** 
		* 
		* @private (protected) 
		* @see Vector. 
		*/
		protected var _modifiers:Vector.<IAssetModifier> = new Vector.<IAssetModifier>();

		/** 
		* 
		* @public 
		* @param label 
		* @param modifiers 
		* @return void 
		*/
		public function AssetMultiModifier(label:String, ...modifiers:Array):void{
			super();
			_label = label;
			for each(var item:IAssetModifier in modifiers){
				addModifier(item);
			}
		}
		

		/** 
		* 
		* @public 
		* @param item 
		* @return void 
		* @see aw.projects.assetmodifier.modifiers.IAssetModifier 
		*/
		public function addModifier(item:IAssetModifier):void{
			if(item){
				this._modifiers.push(item);
			}else{
				throw new Error('IAssetModifier instance is NULL.');
			}
		}

		/** 
		* 
		* @public (getter) 
		* @return String 
		*/
		public function get label():String{
			return this._label;
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
				var list:Vector.<Function> = arguments.callee.list;
				for each(var handler:Function in list){
					handler();
				}
			};
			var list:Vector.<Function> = new Vector.<Function>();
			for each(var item:IAssetModifier in this._modifiers){
				var itemsHandler:Function = item.getHandler(clip, rawParametersString);
				if(itemsHandler==null) throw new Error('Nested IAssetModifier instance returned NULL handler.');
				list.push(itemsHandler);
			}
			(handler as Object).list = list;
			return handler;
		}
		
	}
}
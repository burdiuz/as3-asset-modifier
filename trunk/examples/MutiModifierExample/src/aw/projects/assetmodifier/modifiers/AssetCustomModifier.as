package aw.projects.assetmodifier.modifiers{
	import flash.display.MovieClip;
	
	
	/**
	 * 
	 * @author Galaburda a_[w] Oleg    http://www.actualwave.com
	 * 
	public class AssetCustomModifier extends Object implements IAssetModifier{
		
		/** 
		* 
		* @private (protected) 
		*/
		protected var _label:String;
		
		/** 
		* 
		* @private (protected) 
		*/
		protected var _handler:Function;

		/** 
		* 
		* 
		* 
		* @public 
		* @param label 
		* @param handler Handler passet into constructor must accept one argument - MovieClip instance that will call it when frame code executes
		* @return void 
		*/
		public function AssetCustomModifier(label:String, handler:Function):void{
			super();
			_label = label;
			_handler = handler;
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
		* @public (getter) 
		* @return Function 
		*/
		public function get handler():Function{
			return this._handler;
		}
		/** 
		* Assign new handler to all modified frames
		* @public (setter)
		*/
		public function set handler(value:Function):void{
			this._handler = value;
		}
		

		/** 
		* 
		* @public 
		* @param clip 
		* @param rawProperties 
		* @return Function 
		*/
		public function getHandler(clip:MovieClip, rawProperties:String=''):Function{
			var handler:Function = function():void{
				var e:Object = arguments.callee;
				e.modifier.handler(e.target);
			};
			(handler as Object).target = clip;
			(handler as Object).modifier = this;
			return handler;
		}
	}
}
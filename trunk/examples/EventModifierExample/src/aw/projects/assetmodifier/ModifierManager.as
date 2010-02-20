package aw.projects.assetmodifier{
	import aw.projects.assetmodifier.modifiers.AssetBrakepointModifier;
	import aw.projects.assetmodifier.modifiers.AssetEventModifier;
	import aw.projects.assetmodifier.modifiers.AssetGotoModifier;
	import aw.projects.assetmodifier.modifiers.AssetStopModifier;
	import aw.projects.assetmodifier.modifiers.AssetTraceModifier;
	import aw.projects.assetmodifier.modifiers.IAssetModifier;
	
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	
	/**
	 * 
	 * @author Galaburda a_[w] Oleg    http://www.actualwave.com
	 * 
	 */
	public class ModifierManager extends Object{

		/** 
		* 
		* @private (constant) 
		*/
		static private const DEFAULT_MODIFIER_SIGN:String = '.';

		/** 
		* 
		* @private (constant) 
		* @see aw.projects.assetmodifier.ModifierManager 
		*/
		static private const _instance:ModifierManager = new ModifierManager();
		{
			_instance.registerModifier(new AssetStopModifier());
			_instance.registerModifier(new AssetEventModifier());
			_instance.registerModifier(new AssetBrakepointModifier());
			_instance.registerModifier(new AssetGotoModifier());
			_instance.registerModifier(new AssetTraceModifier());
		}

		/** 
		* 
		* @private (protected,constant) 
		*/
		protected const _modifiers:Object = {};

		/** 
		* 
		* @private (protected) 
		*/
		protected var _modifierSign:String;

		/** 
		* 
		* @private (protected) 
		*/
		protected var _labelRegExp:RegExp;

		/** 
		* 
		* @public 
		* @param sign 
		* @return void 
		*/
		public function ModifierManager(sign:String=DEFAULT_MODIFIER_SIGN):void{
			super();
			if(sign){
				_modifierSign = sign.charAt(0);
			}else{
				throw new Error('Modifiers MUST use sign to detect modifier labels.');
			}
			_labelRegExp = new RegExp('^\\'+_modifierSign+'([\\w]+)(\\((.*)\\))?$', 'i');
		}

		/** 
		* 
		* @public 
		* @param modifier 
		* @return void 
		* @see aw.projects.assetmodifier.modifiers.IAssetModifier 
		*/
		public function registerModifier(modifier:IAssetModifier):void{
			if(!modifier) throw new Error('IAssetModifier instance is NULL.');
			if(modifier.label in this._modifiers){
				throw new Error('Modifier for label "'+modifier.label+'" already registered.');
			}else{
				this._modifiers[modifier.label] = modifier;
			}
		}

		/** 
		* 
		* @public 
		* @param label 
		* @param definition 
		* @return void 
		*/
		public function registerModifierByDefinition(label:String, definition:Class):void{
			if(!definition) throw new Error('Definition is NULL.');
			if(label in this._modifiers){
				throw new Error('Modifier for label "'+label+'" already registered.');
			}else{
				this._modifiers[label] = definition;
			}
		}

		/** 
		* 
		* @public 
		* @param clip 
		* @return MovieClip 
		*/
		public function apply(clip:MovieClip):MovieClip{
			if(!clip) throw new Error('MovieClip instance is NULL.');
			for each(var label:FrameLabel in clip.currentLabels){
				var name:String = label.name;
				if(name.charAt(0)==this._modifierSign){
					var list:Array = name.match(this._labelRegExp);
					if(list && list.length){
						name = list[1];
						if(name in this._modifiers){
							var parameters:String = list[3];
							if(!parameters) parameters = '';
							var modifier:IAssetModifier = this.getModifier(name);
							clip.addFrameScript(label.frame-1, modifier.getHandler(clip, parameters));
						}
					}
				}
			}
			return clip;
		}

		/** 
		* 
		* @public 
		* @param label 
		* @return Boolean 
		*/
		public function hasModifier(label:String):Boolean{
			return label in this._modifiers;
		}

		/** 
		* 
		* @public 
		* @param name 
		* @return IAssetModifier 
		* @see aw.projects.assetmodifier.modifiers.IAssetModifier 
		*/
		public function getModifier(name:String):IAssetModifier{
			var value:* = this._modifiers[name];
			var modifier:IAssetModifier;
			if(value is Class){
				modifier = new value();
			}else modifier = value;
			return modifier;
		}

		/** 
		* 
		* @public 
		* @param label 
		* @return void 
		*/
		public function removeModifier(label:String):void{
			delete this._modifiers[label];
		}

		/** 
		* 
		* @public (getter) 
		* @return ModifierManager 
		* @see aw.projects.assetmodifier.ModifierManager 
		*/
		static public function get instance():ModifierManager{
			return _instance;
		}

		/** 
		* 
		* @public 
		* @param modifier 
		* @return void 
		* @see aw.projects.assetmodifier.modifiers.IAssetModifier 
		*/
		static public function registerModifier(modifier:IAssetModifier):void{
			_instance.registerModifier(modifier);
		}

		/** 
		* 
		* @public 
		* @param label 
		* @param definition 
		* @return void 
		*/
		static public function registerModifierByDefinition(label:String, definition:Class):void{
			_instance.registerModifierByDefinition(label, definition);
		}

		/** 
		* 
		* @public 
		* @param clip 
		* @return MovieClip 
		*/
		static public function apply(clip:MovieClip):MovieClip{
			return _instance.apply(clip);
		}

		/** 
		* 
		* @public 
		* @param label 
		* @return void 
		*/
		static public function removeModifier(label:String):void{
			_instance.removeModifier(label);
		}
	}
}
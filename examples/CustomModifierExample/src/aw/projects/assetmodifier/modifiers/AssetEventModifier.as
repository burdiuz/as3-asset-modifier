package aw.projects.assetmodifier.modifiers{
	import aw.projects.assetmodifier.utils.ModifierParserUtils;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;

	/**
	 * 
	 * Syntax:
		.event(eventType)
		.event(type="change", event="flash.events.Event")
		.event(type="custom", event=flash.events.Event, anyParam="any value")
		.event(type="someEvent", event=flash.events.Event, bubbles=false, cancelable=false, additionalParam="some value")
	 * 
	 * @author Galaburda a_[w] Oleg    http://www.actualwave.com
	 */
	public class AssetEventModifier extends Object implements IAssetModifier{

		/** 
		* 
		* @public (constant) 
		*/
		static public const LABEL:String = 'event';

		/** 
		* 
		* @public 
		* @return void 
		*/
		public function AssetEventModifier():void{
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
		* @param rawProperties 
		* @return Function 
		*/
		public function getHandler(clip:MovieClip, rawProperties:String=''):Function{
			var handler:Function;
			if(rawProperties.indexOf('=')>0){
				handler = getExtendedHandler(clip, rawProperties);
			}else{
				handler = getSimpleHandler(clip, rawProperties);
			}
			return handler;
		}

		/** 
		* 
		* @public 
		* @param clip 
		* @param eventType 
		* @return Function 
		*/
		public function getSimpleHandler(clip:MovieClip, eventType:String):Function{
			var handler:Function = function():void{
				arguments.callee.target.dispatchEvent(new Event(arguments.callee.eventType));
			};
			(handler as Object).target = clip;
			(handler as Object).eventType = eventType;
			return handler;
		}

		/** 
		* 
		* @public 
		* @param clip 
		* @param rawProperties 
		* @return Function 
		*/
		public function getExtendedHandler(clip:MovieClip, rawProperties:String):Function{
			var properties:Object = ModifierParserUtils.getParametersList(rawProperties, clip);
			var definition:*;
			if(properties.event){
				if(properties.event is Class){
					definition = properties.event;
				}else{
					definition = getDefinitionByName(String(properties.event));
				}
				delete properties.event;
			}else definition = Event;
			var event:Object;
			if("cancelable" in properties){
				event = new definition(properties.type, Boolean(properties.bubbles), Boolean(properties.cancelable));
			}else if("bubbles" in properties){
				event = new definition(properties.type, Boolean(properties.bubbles));
			}else{
				event = new definition(properties.type);
			}
			delete properties.type;
			delete properties.bubbles;
			delete properties.cancelable;
			for(var property:String in properties){
				event[property] = properties[property];
			}
			var handler:Function = function():void{
				arguments.callee.target.dispatchEvent(arguments.callee.event.clone());
			};
			(handler as Object).target = clip;
			(handler as Object).event = event;
			return handler;
		}
	}
}
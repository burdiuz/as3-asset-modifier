package aw.projects.assetmodifier.utils{
	import aw.utils.EvalUtils;
	import aw.utils.eval.ArrayEval;
	import aw.utils.iteration.LengthIterationIndex;

	/**
	 * 
	 * @author Galaburda a_[w] Oleg    http://www.actualwave.com
	 * 
	 */
	public class ModifierParserUtils extends Object{
		/**
			Syntax:
				.label(argument1, argument2, argument3)
			Example:
				.label(1243, 45645, 23.4535, 0x00ff00, "string value", true, false)
		*/
		static public function getArgumentsList(rawParameters:String, scope:Object=null):Array{
			return EvalUtils.evaluate(ArrayEval.ARRAY_OPEN+rawParameters+ArrayEval.ARRAY_CLOSE, scope);
		}
		/**
			Syntax:
				.label(parameter1=value, parameter2=value, parameter3=value)
			Example:
				.label(parameter1=2343, parameter2="string value", parameter3=true)
		*/
		static public function getParametersList(rawParameters:String, scope:Object=null):Object{
			var object:Object = {};
			var rgx:RegExp = /[,\s]+/g;
			var index:LengthIterationIndex = new LengthIterationIndex(rawParameters.length);
			while(!index.isLastItem()){
				var signIndex:int = rawParameters.indexOf('=', index.index);
				if(signIndex<0) break;
				var name:String = rawParameters.substring(index.index, signIndex);
				index.index = signIndex+1;
				var value:* = EvalUtils.parseValue(rawParameters, index, scope);
				object[name] = value;
				rgx.lastIndex = index.index-1;
				var spacer:String = rawParameters.match(rgx)[0];
				index.index += spacer.length;
			}
			return object;
		}
	}
}
Main thing of this project is a frame labels -- special labels can be executed as commands.
<img src='http://as3-asset-modifier.googlecode.com/svn/trunk/Original%20files/flash_label1.png'>

These labels are attached to the animation and exported with the rest of the content in SWF/SWC file. When a programmer creates a copy of the animation, he must pass it in a method ModifierManager.apply(). ModifierManager searching in frames and if it finds the necessary labels(which contains command), it replaces the frame with the code, prepared in modifier. Code will be injected by the method MovieClip.addFrameScript () in frame with a label that points to the modifier. You should note that the code injected in the animation calls only code from modifiers handler, no additional code will be executed, so the animation should play the same way as if animator pasted the code directly into the frame in the Flash IDE.<br>
<br>
Modifier, a class that implements an interface IAssetModifier, must return an instance of Function - this function will perform the role of code in the frame.<br>
<pre><code>package aw.projects.assetmodifier.modifiers{<br>
	import flash.display.MovieClip;<br>
 <br>
	/**<br>
	 * @author Galaburda a_[w] Oleg<br>
	 */<br>
	public class AssetStopModifier extends Object implements IAssetModifier{<br>
		static public const LABEL:String = 'stop';<br>
		public function AssetStopModifier():void{<br>
			super();<br>
		}<br>
		public function get label():String{<br>
			return LABEL;<br>
		}<br>
		public function getHandler(clip:MovieClip, rawParametersString:String=''):Function{<br>
			var handler:Function = function():void{<br>
				arguments.callee.target.stop();<br>
			};<br>
			(handler as Object).target = clip;<br>
			return handler;<br>
		}<br>
	}<br>
}<br>
</code></pre>

Each modifier contains label to which it is attached. To use modifiers, they must be registered with the manager of modifiers. To register, you can use one of two methods of manager:<br>
<ul><li>registerModifier(modifier:IAssetModifier):void - registers an instance if modifier that can be reusable<br>
</li><li>registerModifierByDefinition(label:String, definition:Class):void - registers the class of modifiers, in this case, for each frame will be created own copy of the modifier<br>
<pre><code>var manager:ModifierManager = new ModifierManager();<br>
manager.registerModifier(new AssetStopModifier());<br>
manager.registerModifier(new ExampleInstanceModifier());<br>
manager.registerModifierByDefinition(ExampleDefinitionModifier.LABEL, ExampleDefinitionModifier);<br>
</code></pre></li></ul>

You can create instances of manager or use the same static methods, as a variant of the global manager. Each manager contains a command identifier, which separates any labels and asset modifier commands – this is a symbol that precedes each command label. Global manager, or any other by default use the dot character as an identifier. This means that if the modifier is registered with the label "label", then, with the identifier by default, it should be used as ".label".<br>
<br>
Each label can contain some of the data enclosed in parentheses -.label(raw parameters). Such data are not processed and passed to the modifier "as is". But project includes a class ModifierParserUtils, which is able to process<br>
<ul><li>list of arguments as a list of values .label("value1", "value2", "value3", true, 123) In such a case will return an array<br>
</li><li>list of parameters as a list of named values .label(parameter1="value1", parameter2="value2", parameter3="value3", parameterBool=true, parameterInt=123) In such a case will be returned an instance of Object with the values in corresponding parameters of the object</li></ul>

Currently project contains such modifiers:<br>
<ul><li>AssetBrakepointModifier - sets brakepoint to frame<br>
</li><li>AssetCustomModifier - calls handler passed into modifiers constructor (AssetCustomModifier.handler), have no default label<br>
</li><li>AssetEventModifier – dispatches event described in command<br>
</li><li>AssetGotoModifier - makes the transition to specified frame, analog MovieClip.gotoAndPlay()/MovieClip.gotoAndStop()<br>
</li><li>AssetMultiModifier - container for multiple modifiers, the modifiers can be grouped to call them in one frame, have no default label<br>
</li><li>AssetStopModifier – MovieClip.stop()<br>
</li><li>AssetTraceModifier - displays a message in the console, trace<br>
<img src='http://as3-asset-modifier.googlecode.com/svn/trunk/Original%20files/flash_label2.png'></li></ul>

Implementing modifiers interface allows you to create absolutely any modifiers. And using different identifiers, you can separate custom modifiers to groups<br>
<br>
Also, project contains special classes named constructors:<br>
<ul><li>AssetConstructor - serves a copy of the template animation<br>
</li><li>MultiAssetConstructor - abstract class for the service group of animation templates</li></ul>

Such constructors created to help programmer create assets which already patched with already injected code. It contains a reference to animation template class, and a reference to the ModifierManager instance, and each time, when an instance of the animation creates it applying this animation to ModifierManager. If you does not pass specific ModifierManager instance, it will use global manager.<br>
<pre><code>var constructor:AssetConstructor = new AssetConstructor(ASSET_DEFINITION);<br>
asset = constructor.getAsset();<br>
this.addChild(asset);<br>
</code></pre>
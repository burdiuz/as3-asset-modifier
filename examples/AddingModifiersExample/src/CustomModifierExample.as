package {
	import aw.projects.assetmodifier.AssetConstructor;
	import aw.projects.assetmodifier.ModifierManager;
	import aw.projects.assetmodifier.modifiers.AssetStopModifier;
	
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import modifiers.ExampleDefinitionModifier;
	import modifiers.ExampleInstanceModifier;

	public class CustomModifierExample extends Sprite{
		static private const MODIFIER_SIGN:String = '+';
		[Embed(source='../asset.swf', symbol='Asset')]
		static public const ASET_DEFINITION:Class;
		protected var _constructor:AssetConstructor;
		public function CustomModifierExample():void{
			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		protected function addedToStageHandler(event:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.initialize();
		}
		protected function initialize():void{
			var manager:ModifierManager = new ModifierManager(MODIFIER_SIGN);
			manager.registerModifier(new AssetStopModifier());
			manager.registerModifier(new ExampleInstanceModifier());
			manager.registerModifierByDefinition(ExampleDefinitionModifier.LABEL, ExampleDefinitionModifier);
			this._constructor = new AssetConstructor(ASET_DEFINITION, manager);
			trace(' -- asset handlers will be applied now');
			var asset:MovieClip = this._constructor.getAsset();
			trace(' -- asset handlers already applied');
			asset.x = 100;
			asset.y = 100;
			this.addChild(asset);
			this.addButton();
		}
		protected function addButton():void{
			var button:Sprite = new Sprite();
			button.buttonMode = true;
			button.mouseChildren = false;
			var g:Graphics = button.graphics;
			g.beginFill(0xeeeeee, 1);
			g.lineStyle(1, 0xffffff, 1);
			g.drawRoundRect(0, 0, 100, 30, 5, 5);
			g.endFill();
			button.x = 100;
			button.y = 10;
			var tf:TextField = new TextField();
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.selectable = false;
			tf.text = "Continue";
			tf.x = int((100-tf.width)/2);
			tf.y = int((30-tf.height)/2);
			button.addChild(tf);
			button.addEventListener(MouseEvent.CLICK, this.buttonClickHandler);
			this.addChild(button);
		}
		protected function buttonClickHandler(event:MouseEvent):void{
			trace(' -- continue');
			(this.getChildAt(0) as MovieClip).play();
		}
	}
}

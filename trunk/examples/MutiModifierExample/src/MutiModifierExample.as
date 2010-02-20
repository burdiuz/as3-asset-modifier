package {
	import aw.projects.assetmodifier.AssetConstructor;
	import aw.projects.assetmodifier.ModifierManager;
	import aw.projects.assetmodifier.modifiers.AssetCustomModifier;
	import aw.projects.assetmodifier.modifiers.AssetMultiModifier;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class MutiModifierExample extends Sprite{
		[Embed(source='../asset.swf', symbol='Asset')]
		static public const ASET_DEFINITION:Class;
		protected var _assetConstructor:AssetConstructor;
		public function MutiModifierExample():void{
			super();
			_assetConstructor = new AssetConstructor(ASET_DEFINITION);
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addMutiModifier();
		}
		protected function addMutiModifier():void{
			var modifier:AssetMultiModifier = new AssetMultiModifier('myLabel');
			ModifierManager.registerModifier(modifier);
			modifier.addModifier(new AssetCustomModifier('', this.firstFrameHandler));
			modifier.addModifier(new AssetCustomModifier('', this.secondFrameHandler));
			modifier.addModifier(new AssetCustomModifier('', this.thirdFrameHandler));
		}
		protected function addedToStageHandler(event:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.initialize();
		}
		protected function initialize():void{
			var asset:MovieClip = this._assetConstructor.getAsset();
			asset.x = 100;
			asset.y = 100;
			this.addChild(asset);
			this.addButton();
		}
		protected function firstFrameHandler(clip:MovieClip):void{
			clip.x += 10;
			if(clip.x==500){
				clip.x = 100;
			}
		}
		protected function secondFrameHandler(clip:MovieClip):void{
			clip.y += 10;
			if(clip.y==200){
				clip.y = 100;
			}
		}
		protected function thirdFrameHandler(clip:MovieClip):void{
			trace(clip, clip.x, clip.y);
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
			(event.target as DisplayObject).visible = false;
			(this.getChildAt(0) as MovieClip).play();
		}
	}
}

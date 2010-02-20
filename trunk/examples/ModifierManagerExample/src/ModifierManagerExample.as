package {
	import aw.projects.assetmodifier.ModifierManager;
	
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/**
	 * 
	 * @author Galaburda a_[w] Oleg    mailto:burdiuz@gmail.com
	 * 
	 */
	public class ModifierManagerExample extends Sprite{
		[Embed(source='../asset.swf', symbol='Asset')]
		static public const ASSET_DEFINITION:Class;
		public function ModifierManagerExample():void{
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
			var asset:MovieClip;
			//* Example 1
				asset = new ASSET_DEFINITION();
				ModifierManager.apply(asset);
			//*/
			/* Example 2
				var constructor:AssetConstructor = new AssetConstructor(ASSET_DEFINITION);
				asset = constructor.getAsset();
			//*/
			/* Example 3
				var constructor:ExampleMultiAssetConstructor = new ExampleMultiAssetConstructor();
				asset = constructor.getExampleAsset();
			//*/
			asset.x = 100;
			asset.y = 100;
			asset.addEventListener(Event.CHANGE, this.assetChangeHandler);
			this.addChild(asset);
			this.addButton();
		}
		protected function assetChangeHandler(event:Event):void{
			trace('asset CHANGE event fired');
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
			(this.getChildAt(0) as MovieClip).play();
		}
	}
}

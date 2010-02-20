package events{
	import flash.events.Event;

	public class CustomEvent extends Event{
		static public const MY_EVENT:String = "myEvent";
		protected var _value:String;
		public function CustomEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, value:String=""):void{
			super(type, bubbles, cancelable);
			_value = value;
		}
		override public function toString():String{
			return this.formatToString("CustomEvent", "type", "bubbles", "cancelable", "value");
		}
		public function get value():String{
			return this._value;
		}
		public function set value(value:String):void{
			this._value = value;
		}
		override public function clone():Event{
			return new CustomEvent(this.type, this.bubbles, this.cancelable, this._value);
		}
	}
}
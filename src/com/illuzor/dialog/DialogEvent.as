package com.illuzor.dialog {
	
	import flash.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	internal class DialogEvent extends Event {
		
		public static const BUTTON_PRESSED:String = "askButtonPressed";
		
		public function DialogEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event { 
			return new DialogEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("DialogEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}
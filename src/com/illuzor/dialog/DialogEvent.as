package com.illuzor.dialog {
	
	import flash.events.Event;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	internal class DialogEvent extends Event {
		
		/** Dialog window button press */
		public static const BUTTON_PRESSED:String = "dialogButtonPressed";
		
		public function DialogEvent(type:String) { 
			super(type, false, false);
		} 
		
		public override function toString():String { 
			return formatToString("DialogEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
}
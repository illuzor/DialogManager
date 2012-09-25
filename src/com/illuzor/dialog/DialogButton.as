package com.illuzor.dialog {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * Button class for dialog window
	 * 
	 * @author illuzor  //  illuzor.com
	 */
	
	internal class DialogButton extends Sprite {
		/** @private filled rectangle */
		private var buttonBody:Sprite;
		/** @private text field for button title */
		private var buttonTextField:TextField;
		/** @private width of button */
		private var buttonWidth:uint;
		
		/**
		 * Constructor creates button rectangle and button text field
		 * 
		 * @param	textFormat
		 * @param	title
		 */
		public function DialogButton(textFormat:TextFormat, title:String) {
			
			buttonBody = new Sprite();
			buttonBody.buttonMode = true;
			addChild(buttonBody);
			
			buttonTextField = new TextField();
			buttonTextField.mouseEnabled = false;
			buttonTextField.embedFonts = true;
			buttonTextField.selectable = false;
			buttonTextField.text = title;
			buttonTextField.autoSize = TextFieldAutoSize.LEFT;
			buttonTextField.antiAliasType = AntiAliasType.ADVANCED;
			buttonTextField.y = 3;
			buttonTextField.setTextFormat(textFormat);
			addChild(buttonTextField);
		}
		/** Width of button */
		public function set size(value:uint):void {
			if (value < 70) value = 70;
			buttonWidth = value;
			
			draw(0xE6E6E6);
			
			buttonTextField.x = (buttonBody.width - buttonTextField.width) / 2;
			buttonBody.addEventListener(MouseEvent.MOUSE_OVER, onMouseEvent);
			buttonBody.addEventListener(MouseEvent.MOUSE_OUT, onMouseEvent);
			buttonBody.addEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent);
			buttonBody.addEventListener(MouseEvent.MOUSE_UP, onMouseEvent);
			
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		/**
		 * @private button mouse event handler (over, out, down, up)
		 * Drawing button body color according to event type
		 * 
		 * @param	e MouseEvent
		 */
		private function onMouseEvent(e:MouseEvent):void {
			switch (e.type) {
				case MouseEvent.MOUSE_OVER:
				case MouseEvent.MOUSE_UP:
					draw(0xC9C9C9);
				break;
				case MouseEvent.MOUSE_OUT:
					draw(0xE6E6E6);
				break;
				case MouseEvent.MOUSE_DOWN:
					draw(0xF8F8F8);
				break;
			}
		}
		/**
		 * @private drawing button body
		 * 
		 * @param	color color of button body
		 */
		private function draw(color:uint):void {
			buttonBody.graphics.clear();
			buttonBody.graphics.beginFill(color);
			buttonBody.graphics.drawRect(0, 0, buttonWidth, 24);
			buttonBody.graphics.endFill();
			buttonBody.graphics.lineStyle(1,0xCECECE);
			buttonBody.graphics.lineTo(buttonWidth, 0);
			buttonBody.graphics.lineTo(buttonWidth, 24);
			buttonBody.graphics.lineTo(0, 24);
			buttonBody.graphics.lineTo(0, 0);
		}
		/**
		 * @private removed from stage handler. Clear all listeners
		 * 
		 * @param	e removed from stage event
		 */
		private function onRemoved(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			buttonBody.removeEventListener(MouseEvent.MOUSE_OVER, onMouseEvent);
			buttonBody.removeEventListener(MouseEvent.MOUSE_OUT, onMouseEvent);
			buttonBody.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent);
			buttonBody.removeEventListener(MouseEvent.MOUSE_UP, onMouseEvent);
		}
		
	}
}
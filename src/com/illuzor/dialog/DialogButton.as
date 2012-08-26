package com.illuzor.dialog {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author illuzor  //  illuzor.com
	 */
	
	internal class DialogButton extends Sprite {
		
		private var button:Sprite;
		private var buttonTextField:TextField;
		private var buttonWidth:uint;
		
		public function DialogButton(textFormat:TextFormat, title:String) {
			
			button = new Sprite();
			button.buttonMode = true;
			addChild(button);
			
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
		
		public function set size(value:uint):void {
			if (value < 70) value = 70;
			buttonWidth = value;
			
			draw(0xE6E6E6);
			
			buttonTextField.x = (button.width - buttonTextField.width) / 2;
			button.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			button.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			button.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			button.addEventListener(MouseEvent.MOUSE_UP, onOver);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		private function onDown(e:MouseEvent):void {
			draw(0xF8F8F8);
		}
		
		private function onOver(e:MouseEvent):void {
			draw(0xC9C9C9);
		}
		
		private function onOut(e:MouseEvent):void {
			draw(0xE6E6E6);
		}
		
		private function draw(color:uint):void {
			button.graphics.clear();
			button.graphics.beginFill(color);
			button.graphics.drawRect(0, 0, buttonWidth, 24);
			button.graphics.endFill();
			button.graphics.lineStyle(1,0xCECECE);
			button.graphics.lineTo(buttonWidth, 0);
			button.graphics.lineTo(buttonWidth, 24);
			button.graphics.lineTo(0, 24);
			button.graphics.lineTo(0, 0);
		}
		
		private function onRemoved(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			button.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			button.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			button.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			button.removeEventListener(MouseEvent.MOUSE_UP, onOver);
		}
		
	}
}
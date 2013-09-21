package com.illuzor.dialog {
	
	import com.illuzor.dialog.DialogEvent;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * Dialog window
	 * 
	 * @author illuzor  //  illuzor.com
	 */
	
	[Event(name = "dialogButtonPressed", type = "com.illuzor.dialog.DialogEvent")]
	
	internal class Dialog extends Sprite {
		/** @private list of added buttons */
		private var buttonsList:Array;
		/** @private background rectangle of dialog */
		private var background:Shape;
		/** @private sprite for buttons adding */
		private var buttonsContainer:Sprite;
		/** @private text of dialog */
		private var titleText:String;
		/** @private text field for titleText */
		private var headerTextField:TextField;
		/** @private text format for headerTextField */
		private var textFormat:TextFormat = new TextFormat("Roboto Regular", 13, 0x1A1A1A);
		
		/**
		 * Dialog constructor. Init adding to stage and get parameters
		 * 
		 * @param	title text to be showed on dialog
		 * @param	buttons array with buttons config
		 */
		public function Dialog(title:String, buttons:Array) {
			this.titleText = title;
			this.buttonsList = buttons;

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		/**
		 * @private text field for titleText creating, adding dialog background shape
		 * 
		 * @param	e added to stage event
		 */
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			background = new Shape();
			addChild(background);
			
			headerTextField = new TextField();
			headerTextField.embedFonts = true;
			headerTextField.selectable = false;
			headerTextField.text = titleText;
			headerTextField.autoSize = TextFieldAutoSize.LEFT;
			headerTextField.antiAliasType = AntiAliasType.ADVANCED;
			headerTextField.y = 5;
			headerTextField.setTextFormat(textFormat);
			addChild(headerTextField);
			
			if (buttonsList) createButtons();
			calculateSizes();
		}
		
		/** @private creating buttons from list and adding to dialog */
		private function createButtons():void {
			buttonsContainer = new Sprite();
			
			var maxButtonWidth:uint = 70;
			for (var i:int = 0; i < buttonsList.length; i++) {
				var button:DialogButton = new DialogButton(textFormat, buttonsList[i].label);
				if (maxButtonWidth < button.width) maxButtonWidth = button.width;
				buttonsContainer.addChild(button);
				button.addEventListener(MouseEvent.CLICK, onButtonClick);
			}
			
			var maxXCount:uint = Math.floor(stage.stageWidth / 3 /(maxButtonWidth+14));
			var xCount:uint;
			var yCount:uint;

			for (var j:int = 0; j < buttonsContainer.numChildren; j++) {
				var tempButton:DialogButton = buttonsContainer.getChildAt(j) as DialogButton;
				tempButton.size = maxButtonWidth + 10;
				tempButton.x = (tempButton.width + 14) * xCount;
				tempButton.y = (tempButton.height + 14) * yCount;
				xCount++;
				if (xCount >= maxXCount) {
					xCount = 0;
					yCount++;
				}
			}
			addChild(buttonsContainer);
		}
		
		/** @private calculate sizes of background and buttons, sizes correction */
		private function calculateSizes():void {
			var windowWidth:uint;
			var windowExtraHeight:uint = 12;
			
			if (headerTextField.width > stage.stageWidth / 3) {
				headerTextField.wordWrap = true;
				headerTextField.autoSize = TextFieldAutoSize.NONE;
				headerTextField.width = stage.stageWidth / 3 - 10;
				headerTextField.height = headerTextField.textHeight + 4;
				windowWidth = stage.stageWidth / 3;
			} else {
				if (buttonsList && buttonsContainer.width > headerTextField.width) {
					windowWidth = buttonsContainer.width + 30;
				} else {
					windowWidth = headerTextField.width + 30;
				}
			}
			
			headerTextField.x = (windowWidth - headerTextField.width) / 2;
			
			if (buttonsList) {
				buttonsContainer.x = (windowWidth - buttonsContainer.width) / 2;
				buttonsContainer.y = headerTextField.y + headerTextField.height + 15;
				windowExtraHeight = 20;
			} 
			
			background.graphics.beginFill(0xFFFFFF);
			background.graphics.drawRect(0, 0, windowWidth, this.height + windowExtraHeight);
			background.graphics.endFill();
		}
		
		/** @private one of buttons click. Call suitable function if it exists. Dispatch end event */
		private function onButtonClick(e:MouseEvent):void {
			e.currentTarget.removeEventListener(MouseEvent.CLICK, onButtonClick);
			var index:uint = buttonsContainer.getChildIndex(e.currentTarget as DialogButton);
			if (buttonsList[index].func) buttonsList[index].func();
			dispatchEvent(new DialogEvent(DialogEvent.BUTTON_PRESSED));
		}
		
		/** clear */
		public function dispose():void {
			if(buttonsContainer){
				for (var i:int = 0; i < buttonsContainer.numChildren; i++) {
					var button:DialogButton = buttonsContainer.getChildAt(i) as DialogButton;
					button.removeEventListener(MouseEvent.CLICK, onButtonClick);
					button.dispose();
				}
			}
		}
		
	}
}
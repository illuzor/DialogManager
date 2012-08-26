package com.illuzor.dialog {
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	/**
	 * @author illuzor  //  illuzor.com
	 * 
	 * Simple lib to work with dialog windows
	 */
	
	public class DialogManager {
		
		[Embed(source = "../../../../assets/Roboto-Regular.ttf", fontName = "Roboto Regular", fontWeight = "regular", embedAsCFF = "false", unicodeRange = "U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E,U+02C6,U+02DC,U+2013-U+2014,U+2018-U+201A,U+201C-U+201E,U+2020-U+2022,U+2026,U+2030,U+2039-U+203A,U+20AC,U+2122,U+0401,U+0410-U+044F", mimeType = "application/x-font")]
		private static var RobotoFontClass:Class;
		
		private static var dialogsList:Vector.<Dialog> = new Vector.<Dialog>();
		private static var stage:Stage;
		private static var windowShowed:Boolean;
		private static var currentDialog:Dialog;
		private static var background:Sprite;
		private static var _backgroundColor:uint = 0x0;
		private static var _backgroundAlpha:Number = .3;
		private static var inited:Boolean;

		/**
		 * Init dialog manager. Necessary to init one time
		 * 
		 * @param	stage the stage
		 */
		public static function init(stage:Stage):void {
			if (!inited) {
				DialogManager.stage = stage;
				inited = true;
			}
		}
		/**
		 * Add dialog to queue. If no dialog on stage, current dialog adding to display list
		 * 
		 * @param	title text of dialog
		 * @param	buttonsList array with Object - {title:String, func:Function}
		 * fitle is button label.
		 * func in function called on button press.
		 * if func not defined, dialog will just close.
		 */
		public static function addDialog(title:String, buttonsList:Array = null):void {
			if (inited) {
				var dialog:Dialog = new Dialog(title, buttonsList);
				dialogsList.push(dialog);
				showDialog();
			} else {
				throw new Error("DialogManager necessary to be inited before add dialogs");
			}
		}
		/**
		 * Removing all dialogs queue and removeing current dialog from display list
		 */
		public static function removeDialog():void {
			if (windowShowed) {
				stage.removeChild(background);
				background = null;
				stage.removeChild(currentDialog);
				currentDialog = null;
				windowShowed = false;
				stage.removeEventListener(Event.RESIZE, onStageResize);
			}
			showDialog();
		}
		
		public static function removeAllDialogs():void {
			dialogsList = new Vector.<Dialog>();
			removeDialog();
		}
		
		private static function onButtonPressed(e:DialogEvent):void {
			e.target.removeEventListener(DialogEvent.BUTTON_PRESSED, onButtonPressed);
			removeDialog();
			showDialog();
		}
		
		private static function showDialog():void {
			if (!windowShowed && dialogsList.length > 0) {
				
				background = new Sprite();
				stage.addChild(background);
				
				currentDialog = dialogsList[0];
				dialogsList.splice(0, 1);
				stage.addChild(currentDialog);
				
				windowShowed = true;
				currentDialog.addEventListener(DialogEvent.BUTTON_PRESSED, onButtonPressed);
				stage.addEventListener(Event.RESIZE, onStageResize);
				onStageResize();
			}
		}
		
		public static function get backgroundColor():uint {
			return _backgroundColor;
		}
		
		public static function set backgroundColor(value:uint):void {
			_backgroundColor = value;
			if (windowShowed) drawBackground();
		}
		
		public static function get backgroundAlpha():Number {
			return _backgroundAlpha;
		}
		
		public static function set backgroundAlpha(value:Number):void {
			_backgroundAlpha = value;
			if (windowShowed) drawBackground();
		}
		
		private static function drawBackground():void {
			background.graphics.clear();
			background.graphics.beginFill(_backgroundColor, _backgroundAlpha);
			background.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			background.graphics.endFill();
		}
		
		private static function onStageResize(e:Event = null):void {
			drawBackground();
			currentDialog.x = uint((stage.stageWidth - currentDialog.width) / 2);
			currentDialog.y = uint((stage.stageHeight - currentDialog.height) / 2);
		}

	}
}
package com.illuzor.dialog {
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	/**
	 * @author illuzor  //  illuzor.com
	 * 
	 * Simple library to work with dialog windows.
	 * Created with FlashDevelop 4.3.3(http://flashdevelop.org/) and Apache Flex SDK 4.10.0(http://flex.apache.org/)
	 * 
	 * Roboto font developed by Google Inc. licensed under the Apache license http://www.apache.org/licenses/LICENSE-2.0
	 */
	
	public class DialogManager {
		
		[Embed(source = "../../../../assets/Roboto-Regular.ttf", fontName="Roboto Regular", fontWeight="regular", embedAsCFF="false", unicodeRange="U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E,U+02C6,U+02DC,U+2013-U+2014,U+2018-U+201A,U+201C-U+201E,U+2020-U+2022,U+2026,U+2030,U+2039-U+203A,U+20AC,U+2122,U+0401,U+0410-U+044F", mimeType="application/x-font")]
		private static var RobotoFontClass:Class;
		/** @private application stage */
		private static var stage:Stage;
		/** @private is dialog showed at current moment */
		private static var dialogShowed:Boolean;
		/** @private current dialog to show */
		private static var currentDialog:Dialog;
		/** @private sprite with color for locking background elements and blackout */
		private static var background:Sprite;
		/** @private list of added dialogs */
		private static var dialogsList:Vector.<Dialog> = new Vector.<Dialog>();
		/** @private color of background sprite */
		private static var _backgroundColor:uint = 0x0;
		/** @private alpha of background sprite */
		private static var _backgroundAlpha:Number = .3;

		/**
		 * Init dialog manager. Necessary to init one time
		 * 
		 * @param	stage the stage of application
		 */
		public static function init(stage:Stage):void {
			DialogManager.stage = stage;
		}
		/**
		 * Add dialog to queue. If no dialog on stage, current dialog will be added to display list.
		 * 
		 * @param	title text of dialog
		 * @param	buttonsList array with Object - {title:String, func:Function}
		 * title is button label.
		 * func is function called on button press. Optional parameter.
		 * If func not defined, dialog will just close after button click
		 */
		public static function addDialog(title:String, buttonsList:Array = null):void {
			if (stage) {
				var dialog:Dialog = new Dialog(title, buttonsList);
				dialogsList.push(dialog);
				if (!dialogShowed) showDialog();
			} else {
				throw new Error("DialogManager necessary to be inited before add dialogs");
			}
		}
		
		/** Remove current dialog from display list */
		public static function removeDialog():void {
			if (dialogShowed) {
				stage.removeChild(background);
				background = null;
				stage.removeChild(currentDialog);
				currentDialog.dispose();
				currentDialog = null;
				dialogShowed = false;
				stage.removeEventListener(Event.RESIZE, onStageResize);
				if (dialogsList.length) showDialog();
			}
		}
		
		/** Remove all dialogs queue and remove current dialog from display list */
		public static function removeAllDialogs():void {
			for (var i:int = 0; i < dialogsList.length; i++) {
				trace("remove", i, dialogsList.length)
				dialogsList[i].dispose();
			}
			dialogsList = new Vector.<Dialog>();
			removeDialog();
		}
		
		/** @private Adding current dialog to display list */
		private static function showDialog():void {
			background = new Sprite();
			stage.addChild(background);
			
			currentDialog = dialogsList[0];
			dialogsList.splice(0, 1);
			stage.addChild(currentDialog);
			
			dialogShowed = true;
			currentDialog.addEventListener(DialogEvent.BUTTON_PRESSED, onButtonPressed);
			stage.addEventListener(Event.RESIZE, onStageResize);
			onStageResize();
		}
		
		/**
		 * @private after button press remove dialog
		 * 
		 * @param	e button press event
		 */
		private static function onButtonPressed(e:DialogEvent):void {
			e.target.removeEventListener(DialogEvent.BUTTON_PRESSED, onButtonPressed);
			removeDialog();
		}
		
		/** @private drawing color on background sprite */
		private static function drawBackground():void {
			background.graphics.clear();
			background.graphics.beginFill(_backgroundColor, _backgroundAlpha);
			background.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			background.graphics.endFill();
		}
		
		/**
		 * @private stage resize handler for dialog position and background size correction
		 * 
		 * @param	e stage resize event
		 */
		private static function onStageResize(e:Event = null):void {
			drawBackground();
			currentDialog.x = uint((stage.stageWidth - currentDialog.width) / 2);
			currentDialog.y = uint((stage.stageHeight - currentDialog.height) / 2);
		}
		
		public static function get backgroundColor():uint {
			return _backgroundColor;
		}
		
		public static function set backgroundColor(value:uint):void {
			_backgroundColor = value;
			if (dialogShowed) drawBackground();
		}
		
		public static function get backgroundAlpha():Number {
			return _backgroundAlpha;
		}
		
		public static function set backgroundAlpha(value:Number):void {
			_backgroundAlpha = value;
			if (dialogShowed) drawBackground();
		}

	}
}
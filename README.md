DialogManager
=============

Simple dialog window manager. Version 0.1

Features:
	- very simple to use;
	- autosize regardless text lenght and buttons number;
	- detecting stage resize and correcting background and dialog coordinates;
	- posible to show text only or text with buttons;
	- dialog queue;
	
How to use:
	
1) Simple text:
	
import com.illuzor.dialog.DialogManager;

DialogManager.init(stage); // init must called one time
DialogManager.addDialog("Just simple text...");

![dm_simple_text.png](http://download.illuzor.com/images/github/DialogManager/dm_simple_text.png)

2) Text with any buttons number:

import com.illuzor.dialog.DialogManager;

DialogManager.init(stage);
DialogManager.addDialog("You see this message", [ {label:"OK"} ] );
// first patameter is dialog text.
// second parameter is buttons array with Objects - {label:String, func:Function};
// func will called with conforming button press.
// if func undefined button click just close dialog.

![dm_one_button.png](http://download.illuzor.com/images/github/DialogManager/dm_one_button.png)

import com.illuzor.dialog.DialogManager;

//...
DialogManager.init(stage);
DialogManager.addDialog("Do you want to do it?", [ {label:"YES", func:yesFunction}, {label:"NO", func:noFunction} ] );

//...

private function yesFunction():void{
	trace("YES pressed");
}

private function noFunction():void{
	trace("NO pressed");
}

![dm_two_buttons.png](http://download.illuzor.com/images/github/DialogManager/dm_two_buttons.png)
	
![dm_five_buttons.png](http://download.illuzor.com/images/github/DialogManager/dm_five_buttons.png)
	
3) Queue:

You can add several dialogs at the same time. Next dialog will shows only after current dialog deleting.
	
4) Remove current dialog manually

DialogManager.removeDialog();

5) Remove all dialogs:

DialogManager.removeAllDialogs();

6) Background parameters:

You can define background colo and background alpha:

DialogManager.backgroundColor = 0xFF00FF; // color uint
DialogManager.backgroundAlpha = 0.5 // Number 0-1


Roboto font developed by Google Inc. licensed under the Apache license http://www.apache.org/licenses/LICENSE-2.0

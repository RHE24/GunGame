#define true 1 
#define false 0 
#define FontM "EtelkaNarrowMediumPro"

class StaticHeader
{
	type = 0;
	colorBackground[] = {0.40234375, 0.54296875, 0.60546875, 1}; 
	colorText[] = { 1, 1, 1, 1 };
	colorFrame[] = {1,1,1,1}; 
	style = 0x00;
	font = FontM;
};

class ListBox
{
	type = 5; 
	style = 0; 
	font = FontM; 
	colorDisabled[] = {0.3, 0.3, 0.3, 1};
	colorText[] = {1,1,1,1}; 
	colorScrollbar[] = {1,1,1,1}; 
	colorSelect[] = {1,1,1,1}; 
	colorSelect2[] = {1,1,1,1}; 
	colorSelectBackground[] = {0,0,1,0.5}; 
	colorSelectBackground2[] = {0,0,1,1}; 
	colorBackground[] = {0,0,0,1}; 
	maxHistoryDelay = 1.0; 
	soundSelect[] = {"",0.1,1}; 
	period = 1; 
	autoScrollSpeed = -1; 
	autoScrollDelay = 5; 
	autoScrollRewind = 0; 
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)"; 
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)"; 
	shadow = 0; 
	class ScrollBar 
	{ 
		color[] = {1,1,1,0.6}; 
		colorActive[] = {1,1,1,1}; 
		colorDisabled[] = {1,1,1,0.3}; 
		thumb = "#(argb,8,8,3)color(1,1,1,1)"; 
		arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)"; 
		arrowFull = "#(argb,8,8,3)color(1,1,1,1)"; 
		border = "#(argb,8,8,3)color(1,1,1,1)"; 
		shadow = 0; 
	}; 
};

class ComboBox 
{ 
	type = 4; 
	style = 0; 
	font = FontM; 
	sizeEx = 0.03; 
	rowHeight = 0.05; 
	wholeHeight = 0.3;
	rows=1;
	colorDisabled[] = {0.3, 0.3, 0.3, 1};
	colorText[] = {1,1,1,1}; 
	colorScrollbar[] = {1,1,1,1}; 
	colorSelect[] = {1,1,1,1}; 
	colorSelect2[] = {1,1,1,1}; 
	colorSelectBackground[] = {0,0,0,1}; 
	colorSelectBackground2[] = {0,0,0,1}; 
	colorBackground[] = {0,0,0,1}; 
	maxHistoryDelay = 1.0; 
	soundSelect[] = {"",0.1,1}; 
	period = 1; 
	autoScrollSpeed = -1; 
	autoScrollDelay = 5; 
	autoScrollRewind = 0; 
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)"; 
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)"; 
	shadow = 0; 
	soundExpand[] = {"",0.1,1};
	soundCollapse[] = {"",0.1,1};
	class ScrollBar 
	{ 
		color[] = {1,1,1,0.6}; 
		colorActive[] = {1,1,1,1}; 
		colorDisabled[] = {1,1,1,0.3}; 
		thumb = "#(argb,8,8,3)color(1,1,1,1)"; 
		arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)"; 
		arrowFull = "#(argb,8,8,3)color(1,1,1,1)"; 
		border = "#(argb,8,8,3)color(1,1,1,1)"; 
		shadow = 0; 
	}; 
};

class Button 
{ 
	type = 1; 
	style = 0x00; 
	font = FontM; 
	sizeEx = 0.04; 
	colorText[] = {0,0,0,1}; 
	colorDisabled[] = {0.3,0.3,0.3,1}; 
	colorBackground[] = {0.8,0.8,0.8,1}; 
	colorBackgroundDisabled[] = {0.6,0.6,0.6,1}; 
	colorBackgroundActive[] = {0.8,0.8,1,1}; 
	offsetX = 0.004; 
	offsetY = 0.004; 
	offsetPressedX = 0.002; 
	offsetPressedY = 0.002; 
	colorFocused[] = {0,0,0,1}; 
	colorShadow[] = {1,1,1,0}; 
	shadow = 0; 
	colorBorder[] = {0,0,0,1}; 
	borderSize = 0; 
	soundEnter[] = {"",0.1,1}; 
	soundPush[] = {"",0.1,1}; 
	soundClick[] = {"",0.1,1}; 
	soundEscape[] = {"",0.1,1}; 
};



class Map
{
	type = 100;
	style = 0;
	font = FontM;
	sizeEx = 0.04;
};




class voteNumRounds 
{ 
	idd = 481;
	movingEnable = false;
	enableSimulation = true;
	controlsBackground[] = { container };
	objects[] = { };
	controls[] = { header , ListLabel , votesListBox , voteButton};
	
	
	
	class container
	{
		idc = -1;
		type = 0;
		colorBackground[] = { 0, 0, 0, 0.7 }; 
		colorText[] = { 1, 1, 1, 1 };
		colorFrame[] = {1,1,1,1}; 
		text = "";
		style = 0x02;
		font = FontM;
		sizeEx = 0.1;
		x = 0.1;
		y = 0.1;
		w = 0.8;
		h = 0.8;
	};
	class header : StaticHeader
	{
		idc = -1;
		text = "Voting";
		sizeEx = 0.05;
		x = 0.1;
		y = 0.1;
		w = 0.8;
		h = 0.05;
	};
	
	class ListLabel : StaticHeader
	{
		access = 0;
		idc = -1;
		text = "Rounds";
		sizeEx = 0.03;
		x = 0.1;
		y = 0.15;
		w = 0.4;
		h = 0.05;
	};
	
	class votesListBox : ListBox
	{
		access = 1;
		idc = 3; 
		x = 0.1;
		y = 0.2;
		w = 0.4;
		h = 0.35;		
		sizeEx = 0.03; 
		rowHeight = 0.05; 
		rows=5;	
		colorScrollbar[] = {1,1,1,1}; 
		colorSelect[] = {1,1,1,1}; 
		colorSelect2[] = {1,1,1,1}; 
		colorSelectBackground[] = {0,0,1,0.5}; 
		colorSelectBackground2[] = {0,0,1,1}; 
		colorBackground[] = {0,0,0,1}; 
		maxHistoryDelay = 1.0; 
		soundSelect[] = {"",0.1,1}; 
		period = 1; 
		autoScrollSpeed = -1; 
		autoScrollDelay = 5; 
		autoScrollRewind = 0; 
		arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)"; 
		arrowFull = "#(argb,8,8,3)color(1,1,1,1)"; 
		shadow = 0; 
		class ListScrollBar 
		{ 
			color[] = {1,1,1,0.6}; 
			colorActive[] = {1,1,1,1}; 
			colorDisabled[] = {1,1,1,0.3}; 
			thumb = "#(argb,8,8,3)color(1,1,1,1)"; 
			arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)"; 
			arrowFull = "#(argb,8,8,3)color(1,1,1,1)"; 
			border = "#(argb,8,8,3)color(1,1,1,1)"; 
			shadow = 0; 
		}; 
	};
	
	
	class voteButton : Button
	{ 
		idc = -1;
		access = 0;
		action = "execVM 'voting\votenumroundscast.sqf'";
		x = 0.1; 
		y = 0.75; 
		w = 0.3; 
		h = 0.05; 
		text = "Vote"; 
	};
};




class voteGunProgress
{ 
	idd = 482;
	movingEnable = false;
	enableSimulation = true;
	controlsBackground[] = { container };
	objects[] = { };
	controls[] = { header , ListLabel , weaponTypeListBox , weaponListBox , addButton , weaponPicture , addedListBox};
	
	
	
	class container
	{
		idc = -1;
		type = 0;
		colorBackground[] = { 0, 0, 0, 0.7 }; 
		colorText[] = { 1, 1, 1, 1 };
		colorFrame[] = {1,1,1,1}; 
		text = "";
		style = 0x02;
		font = FontM;
		sizeEx = 0.1;
		x = 0.1;
		y = 0.1;
		w = 0.8;
		h = 0.8;
	};
	class header : StaticHeader
	{
		idc = -1;
		text = "Voting";
		sizeEx = 0.05;
		x = 0.1;
		y = 0.1;
		w = 0.8;
		h = 0.05;
	};
	
	class ListLabel : StaticHeader
	{
		access = 0;
		idc = -1;
		text = "Gun Progression";
		sizeEx = 0.03;
		x = 0.1;
		y = 0.15;
		w = 0.3;
		h = 0.05;
	};
	
	class weaponTypeListBox : ListBox
	{
		access = 1;
		idc = 3; 
		x = 0.1;
		y = 0.2;
		w = 0.25;
		h = 0.35;		
		sizeEx = 0.03; 
		rowHeight = 0.05; 
		rows=5;	
		colorScrollbar[] = {1,1,1,1}; 
		colorSelect[] = {1,1,1,1}; 
		colorSelect2[] = {1,1,1,1}; 
		colorSelectBackground[] = {0,0,1,0.5}; 
		colorSelectBackground2[] = {0,0,1,1}; 
		colorBackground[] = {0,0,0,1}; 
		maxHistoryDelay = 1.0; 
		soundSelect[] = {"",0.1,1}; 
		period = 1; 
		autoScrollSpeed = -1; 
		autoScrollDelay = 5; 
		autoScrollRewind = 0; 
		arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)"; 
		arrowFull = "#(argb,8,8,3)color(1,1,1,1)"; 
		shadow = 0; 
		class ListScrollBar 
		{ 
			color[] = {1,1,1,0.6}; 
			colorActive[] = {1,1,1,1}; 
			colorDisabled[] = {1,1,1,0.3}; 
			thumb = "#(argb,8,8,3)color(1,1,1,1)"; 
			arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)"; 
			arrowFull = "#(argb,8,8,3)color(1,1,1,1)"; 
			border = "#(argb,8,8,3)color(1,1,1,1)"; 
			shadow = 0; 
		}; 
	};
	
	
	class weaponListBox : ListBox
	{
		access = 1;
		idc = 4; 
		x = 0.35;
		y = 0.2;
		w = 0.25;
		h = 0.35;		
		sizeEx = 0.03; 
		rowHeight = 0.05; 
		rows=5;	
		colorScrollbar[] = {1,1,1,1}; 
		colorSelect[] = {1,1,1,1}; 
		colorSelect2[] = {1,1,1,1}; 
		colorSelectBackground[] = {0,0,1,0.5}; 
		colorSelectBackground2[] = {0,0,1,1}; 
		colorBackground[] = {0,0,0,1}; 
		maxHistoryDelay = 1.0; 
		soundSelect[] = {"",0.1,1}; 
		period = 1; 
		autoScrollSpeed = -1; 
		autoScrollDelay = 5; 
		autoScrollRewind = 0; 
		arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)"; 
		arrowFull = "#(argb,8,8,3)color(1,1,1,1)"; 
		shadow = 0; 
		class ListScrollBar 
		{ 
			color[] = {1,1,1,0.6}; 
			colorActive[] = {1,1,1,1}; 
			colorDisabled[] = {1,1,1,0.3}; 
			thumb = "#(argb,8,8,3)color(1,1,1,1)"; 
			arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)"; 
			arrowFull = "#(argb,8,8,3)color(1,1,1,1)"; 
			border = "#(argb,8,8,3)color(1,1,1,1)"; 
			shadow = 0; 
		}; 
	};
	
	class weaponPicture
	{
		access = 1;
		idc = 5;
		type = 0;
		colorBackground[] = { 0, 0, 0, 1}; 
		colorText[] = { 1, 1, 1, 1 };
		colorFrame[] = {1,1,1,1}; 
		text = "#(argb,8,8,3)color(0,0,0,1)";
		style = 48;
		font = FontM;
		sizeEx = 0.02;
		x = 0.6;
		y = 0.2;
		w = 0.2;
		h = 0.2;
	};	
	
	
	
	class addedListBox : ListBox
	{
		access = 1;
		idc = 6; 
		x = 0.35;
		y = 0.55;
		w = 0.25;
		h = 0.25;		
		sizeEx = 0.03; 
		rowHeight = 0.05; 
		rows=5;	
		colorScrollbar[] = {1,1,1,1}; 
		colorSelect[] = {1,1,1,1}; 
		colorSelect2[] = {1,1,1,1}; 
		colorSelectBackground[] = {0,0,1,0.5}; 
		colorSelectBackground2[] = {0,0,1,1}; 
		colorBackground[] = {0,0,0,1}; 
		maxHistoryDelay = 1.0; 
		soundSelect[] = {"",0.1,1}; 
		period = 1; 
		autoScrollSpeed = -1; 
		autoScrollDelay = 5; 
		autoScrollRewind = 0; 
		arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)"; 
		arrowFull = "#(argb,8,8,3)color(1,1,1,1)"; 
		shadow = 0; 
		class ListScrollBar 
		{ 
			color[] = {1,1,1,0.6}; 
			colorActive[] = {1,1,1,1}; 
			colorDisabled[] = {1,1,1,0.3}; 
			thumb = "#(argb,8,8,3)color(1,1,1,1)"; 
			arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)"; 
			arrowFull = "#(argb,8,8,3)color(1,1,1,1)"; 
			border = "#(argb,8,8,3)color(1,1,1,1)"; 
			shadow = 0; 
		}; 
	};
	
	
	
	class addButton : Button
	{ 
		idc = -1;
		access = 0;
		action = "execVM 'voting\votegunprogressbut.sqf'";
		x = 0.1; 
		y = 0.75; 
		w = 0.3; 
		h = 0.05; 
		text = "Add Weapon"; 
	};
};



class voteFightZone 
{ 
	idd = 485;
	movingEnable = false;
	enableSimulation = true;
	controlsBackground[] = { container };
	objects[] = { };
	controls[] = { header , ListLabel , votesListBox , voteButton};
	
	
	
	class container
	{
		idc = -1;
		type = 0;
		colorBackground[] = { 0, 0, 0, 0.7 }; 
		colorText[] = { 1, 1, 1, 1 };
		colorFrame[] = {1,1,1,1}; 
		text = "";
		style = 0x02;
		font = FontM;
		sizeEx = 0.1;
		x = 0.1;
		y = 0.1;
		w = 0.8;
		h = 0.8;
	};
	class header : StaticHeader
	{
		idc = -1;
		text = "Voting";
		sizeEx = 0.05;
		x = 0.1;
		y = 0.1;
		w = 0.8;
		h = 0.05;
	};
	
	class ListLabel : StaticHeader
	{
		access = 0;
		idc = -1;
		text = "Location";
		sizeEx = 0.03;
		x = 0.1;
		y = 0.15;
		w = 0.4;
		h = 0.05;
	};
	
	class votesListBox : ListBox
	{
		access = 1;
		idc = 3; 
		x = 0.1;
		y = 0.2;
		w = 0.4;
		h = 0.35;		
		sizeEx = 0.03; 
		rowHeight = 0.05; 
		rows=5;	
		colorScrollbar[] = {1,1,1,1}; 
		colorSelect[] = {1,1,1,1}; 
		colorSelect2[] = {1,1,1,1}; 
		colorSelectBackground[] = {0,0,1,0.5}; 
		colorSelectBackground2[] = {0,0,1,1}; 
		colorBackground[] = {0,0,0,1}; 
		maxHistoryDelay = 1.0; 
		soundSelect[] = {"",0.1,1}; 
		period = 1; 
		autoScrollSpeed = -1; 
		autoScrollDelay = 5; 
		autoScrollRewind = 0; 
		arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)"; 
		arrowFull = "#(argb,8,8,3)color(1,1,1,1)"; 
		shadow = 0; 
		class ListScrollBar 
		{ 
			color[] = {1,1,1,0.6}; 
			colorActive[] = {1,1,1,1}; 
			colorDisabled[] = {1,1,1,0.3}; 
			thumb = "#(argb,8,8,3)color(1,1,1,1)"; 
			arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)"; 
			arrowFull = "#(argb,8,8,3)color(1,1,1,1)"; 
			border = "#(argb,8,8,3)color(1,1,1,1)"; 
			shadow = 0; 
		}; 
	};
	
	
	
	
	class voteButton : Button
	{ 
		idc = -1;
		access = 0;
		action = "execVM 'voting\votefightzonebut.sqf'";
		x = 0.1; 
		y = 0.75; 
		w = 0.3; 
		h = 0.05; 
		text = "Vote"; 
	};
};
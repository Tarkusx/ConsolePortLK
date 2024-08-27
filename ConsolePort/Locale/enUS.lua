local _, db = ...

-- Use English as default locale.

local DEFAULT = {

TUTORIAL = {
	BIND  = {
		HEADER 				= 'Bindings',
		SIDEBAR 			= 'Bindings',
		MENUHEADER 			= 'Controller',
		TOOLTIPHEADER 		= 'Bindings',
		TOOLTIPCLICK 		= '<Click to change>',
		PROFILEPRESET 		= ' Preset',
		DEFAULT 			= 'Click here to change a binding.',
		CATCHER 			= 'Press a button on your controller.',
		COMBO 				= '|T%s:20:20:0:0|tLeft click: change or add binding\n|T%s:20:20:0:0|tRight click: clear binding',
		SWAPPER 			= 'Click on a button combination or binding to start pairing.',
		IMPORT 				= 'Bindings were imported from %s.',
		IMPORTADV 			= 'Import bindings from an external source.',
		IMPORTADVEXT 		= 'New bindings were imported.',
		IMPORTINVALID 		= 'Error: Imported data is not a valid binding set.\nYou can import arbitrary profile data in the advanced tab.',
		EXPORTADV 			= 'Export bindings for %s.',
		EXPORTADVCURRENT 	= 'Export your current bindings.',
		RESET 				= 'Default settings loaded.',
		IMPORTBUTTON 		= 'Import',
		IMPORTEXPORT 		= 'Import / Export',
		REMOVEBUTTON		= 'Remove',
		MAINCATEGORY 		= ' |cFFFF6600Controller|r ',
		NOTASSIGNED 		= '|cFF575757Not assigned|r',
		SPELL 				= 'Spell',
		ITEM 				= 'Item',
		MOUNT 				= 'Mount',
		CRITTER 			= 'Battle Pet',
		MACRO 				= '|cFF575757 (Macro)',
		EQSET 				= '|cFF575757 (Equipment Set)|r',
		BATTLEPET 			= '|cFF575757 (Battle Pet)|r',
		LEFTCLICK 			= '|cFF757575Left Click / Movement|r',
		RIGHTCLICK 			= '|cFF757575Right Click / Mouse|r',
		SHIFT 				= '|cFF757575Modifier 1 / Shift|r',
		CTRL 				= '|cFF757575Modifier 2 / Ctrl|r',
		T1 					= 'Trigger 1',
		T2 					= 'Trigger 2',
		T3 					= 'Trigger 3',
		T4 					= 'Trigger 4',
	},
	MOUSE = {
		STARTED_MOVING 		= 'Starting to move',
		TARGET_CHANGED 		= 'Changing target',
		DIRECT_SPELL_CAST 	= 'Casting a spell',
		NPC_INTERACTION 	= 'Interacting with an NPC',
		QUEST_AUTOCOMPLETE 	= 'Popup quest appears',
		LOOTING 			= 'Looting',
		JUMPING 			= 'Jumping',
		CENTERCURSOR 		= 'Cursor is centered',
	},
	UICTRL = {
		VIRTUALCURSOR 		= 'Interface cursor |cFF757575- assign mouse commands to buttons|r',
		ACTIONBARHEADER		= 'Hotkey style |cFF757575- only for regular action bars|r',
		HEADER 				= 'Interface',
		SIDEBAR 			= 'Interface',
		ADDONLISTHEADER 	= 'AddOns:',
		FRAMELISTHEADER 	= 'Frames:',
		FRAMELISTFORMAT 	= 'Frames in |cffffe00a%s|r:',
		NEWFRAME			= 'Add new frame manually',
		MOUSEOVERVALID		= 'Add |cffffffff%s|r to |cffffaaaa%s|r',
		MOUSEOVERINVALID 	= 'Add frame by mouse over',
		TUTORIALFRAME 		= 'Integrate your custom add-ons and frames here.',
		TUTORIALFRAMEMO 	= 'Hover a frame to register its name.',
		HIDEFRAMELIST 		= 'Return to interface settings',
		ADDADDON 			= 'Enter name of addon or module:',
		ADDFRAME 			= 'Enter name to add frame to addon |cffffe00a%s|r:',
		REMOVEADDON 		= 'Do you want to remove addon |cffffe00a%s|r from the interface cursor?',
		REMOVEFRAME 		= 'Do you want to remove frame |cffffe00a%s|r in addon |cffffe00a%s|r from the interface cursor?',
		ADD 				= 'Add',
		CANCEL 				= 'Cancel',
		REMOVE 				= 'Remove',
		SHOWALLADDONS		= 'Show core add-ons and frames',
		ENABLECURSOR 		= 'Enable interface cursor',
	},
	CONFIG = {
		GENERALHEADER 		= 'General settings',
		CONTROLLERBUTTON 	= 'Controller',
		IBFULLHEADER 		= 'Interact button (full)',
		IBLITEHEADER 		= 'Interact button (lite)',
		TARGETAIHEADER		= 'Smart interaction',
		MOUSEHEADER 		= 'Hide mouse cursor when...',
		TRIGGERHEADER		= 'Trigger settings',
		CAMERAHEADER 		= 'Camera settings',
		TARGETHEADER		= 'Highlight next target',
		-----------------------------------------------------------
		INTERACT_HELPFUL 	= '|cff75ff75allies|r',
		INTERACT_HARMFUL 	= '|cffff7575enemies|r',
		INTERACT_NOTARGET 	= '|cffffffffno target|r',
		INTERACT_TARGET 	= '|cffffffffany target|r',
		INTERACT_ORIGINAL 	= 'Original action: |cffffffff%s|r\n%s',
		INTERACT_CURRENT_A 	= 'Calculated behaviour:\n  Interact with: %s\n  Normal action on: %s',
		INTERACT_CURRENT_B 	= 'Calculated behaviour:\n  Interact with: %s or %s\n  Normal action on: %s',
		-----------------------------------------------------------
		INTERACTCATCHER 	= 'Click here to assign.',
		INTERACTASSIGNED 	= '|T%s:50:50:0:0|t',
		INTERACTASSIGNED_B	= '|T%s:40:40:0:0|t',
		INTERACTCHECK 		= 'Enable',
		IBFULLDESC 			= 'Allows one of your buttons to interact\n with all world objects and creatures,\nwhen the original button action\ndoesn\'t have any effect.\n\nCursor required for world objects.',
		IBLITEDESC			= 'Allows one of your buttons to interact\n with lootable corpses and friendly NPCs\nout of combat.\n\nNo cursor required.',
		MOUSEOVERMODE 		= 'Always interact with mouseover',
		INTERACTNPC 		= 'Interact with targeted NPCs',
		INTERACTCACHE 		= 'Enable smart interaction',
		INTERACTSCRAPE		= 'Enable NPC nameplates',
		INTERACTNAMEONLY	= 'Enable name-only mode',
		-----------------------------------------------------------
		TRIGGERHELP 		= 'These settings will change which graphics are displayed for your triggers and modifiers.\nIf you want to change your modifiers, you will also have to change them in your controller mapper.',
		IBFULLHELP 			= 'Use one of your buttons to interact with objects and creatures.\nIn the case where you lack a target that befits the configured button\'s original action,\nyou will instead be able to interact with the world.\n\nExamples:\nA |cffff7575harmful|r spell will be cast upon a hostile target, but interact in all other cases.\nA |cff75ff75healing|r spell will be cast upon a friendly target, but interact in all other cases.\nA macro or a binding requires a target to be used, but interact in all other cases.',
		IBLITEHELP 			= 'Use one of your buttons to loot your last target when you\'re in range.\nThe button you assign here will only be used for looting when...\n  • you\'re out of combat or already targeting the creature,\n  • the creature was your last target,\n  • the creature has loot for you.\n\nThe full interact button includes this functionality.',
		TARGETAIHELP		= 'Smart interaction only:\nRemembers the NPCs you come in contact with and lets you interact with them.\n\nWith NPC nameplates:\nAllows you to interact with any NPC at all times.\n\nName-only mode:\nHide nameplate healthbars on friendly units, but show on enemies in combat.',
		HIGHLIGHTHELP 		= 'Preview your next target before you switch to it.\nIf you\'re struggling with reliable tab-targeting, set this to |cff75ff75Always on|r.',
		IBFULLREC			= '|TInterface\\Buttons\\AdventureGuideMicrobuttonAlert:32:32:-4:0|t|cFFFFFFFFRecommended setting:|r\n  For best overall behaviour,\n  choose a button on which the\n  underlying action is a damaging spell\n  that requires an enemy target to cast.',
		-----------------------------------------------------------
		MOUSEHANDLE 		= 'Character handling',
		MOUSEDRIFTING 		= 'Cursor is near the edge of the screen',
		TURNMOVE 			= 'Turn instead of strafe when the cursor is visible',
		DOUBLEMODTAP 		= 'Double tap |T%s:32:32:0:0|t or |T%s:32:32:0:0|t to toggle mouse cursor',
		LOOKAROUND 			= 'Hold |T%s:32:32:0:0|t to pan the camera around',
		DISABLEMOUSE 		= 'Disable automatic mouse behaviour',
		INVERTPITCH			= 'Invert camera pitch',
		INVERTYAW			= 'Invert camera yaw',
		TARGETING 			= 'Targeting',
		RAIDCURSORDIRECT 	= 'Target directly with raid cursor',
		TARGETALGORITHM 	= 'Use new tab-targeting algorithm',
		CONVENIENCE 		= 'Convenience features',
		AUTOEXTRA 			= 'Add quest items and extra spells to utility ring',
		AUTOLOOT 			= 'Force auto loot in combat',
		AUTOSELL 			= 'Automatically sell junk',
		DISABLEBINDHELP 	= 'Disable action placement assistance',
		FIXES 				= 'Fixes',
		DISABLEHOLDREPEAT 	= 'One-to-one interface cursor',
		SKIPCALIBRATION		= 'Disable calibration check on login',
		-----------------------------------------------------------
		CONTROLLER 			= 'Change controller',
		BINDRESET 			= 'Calibrate controller',
		FULLRESET 			= 'Reset all settings',
		CONFIRMRESET 		= 'Are you sure?',
		SHOWSLASH 			= 'Slash commands',
		-----------------------------------------------------------
		TARGETSCAN 			= 'When scanning (default)',
		TARGETNONE 			= 'When no target exists',
		TARGETALWAYS 		= 'Always on',
		-----------------------------------------------------------
		SAVE 				= 'Save settings',
		APPLY 				= 'Apply',
		CANCEL 				= 'Cancel',
		DEFAULT 			= 'Default',
		DEFAULTHEADER 		= 'Reset settings',
		DEFAULTTHIS			= 'Reset these settings',
		DEFAULTALL			= 'Reset all settings',
		-----------------------------------------------------------
		FASTCAM 			= 'Fast camera zooming',
		DYNPITCH 			= 'Use dynamic pitch',
		TARGETYAW 			= 'Use dynamic yaw',
		TARGETFOCUS 		= 'Focus camera on enemy target',
		TARGETFOCUSNPC 		= 'Focus camera on interactive target',
		OVERSHOULDER 		= 'Over shoulder mode',
		LEFT 				= 'Left',
		RIGHT 				= 'Right',
		-----------------------------------------------------------
		LINK_WM 			= 'WoWmapper on GitHub',
		LINK_CP 			= 'ConsolePort website',
		LINK_DISCORD 		= 'Discord channel',
		LINK_PATREON		= 'Patreon page',
	},
	HINTS = {
		DISABLE 				= 'Disable on-screen hints',
		UTILITY_RING_BIND 		= 'Hold %s to open utility ring.',
		UTILITY_RING_DOUBLE 	= 'Press %s twice to toggle the utility ring.',
		UTILITY_RING_REMOVE 	= 'Press %s when an item is selected to remove it.',
		UTILITY_RING_NEWBIND	= '%s was bound to your Utility Ring%s',
		HELPER_ACTIONBAR 		= 'Press a button combination on your\ncontroller to place this on your action bar.',
		HELPER_EQUIP_BAG 		= 'Click on a slot below to equip this bag.',
		HELPER_INVALID_OCCUA 	= '%s is occupied by %s.\nYou need to bind this combination to your action bar first.',
		HELPER_INVALID_OCCUB 	= '%s is occupied.\nYou need to bind this combination to your action bar first.',
		HELPER_INVALID_FREE 	= '%s is currently unbound. Suggested free slot: |cFFFF6600%s|r.\nPress the combination again to confirm this binding.',
		HELPER_INVALID_ERROR 	= '%s isn\'t bound to anything.\nYou need to bind this combination to your action bar first.',
	},
	SETUP = {
		LAYOUT  			= 'Setup: Select controller layout',
		HEADER 				= 'Setup: Calibrate controller',
		CONTINUECLICK 		= 'Click here to continue',
		LOADWOWMAPPER 		= 'I\'m using WoWmapper',
		SKIPGUIDE 			= 'Skip this button',
		HEADLINE 			= 'Your controller calibration is incomplete.\nPress the requested button on your controller.\nDo NOT use your keyboard during calibration.',
		OVERRIDE 			= '|cFFFF6600%s|r is bound to |cFFFF6600%s|r on your keyboard.\n|cFF757575This binding will be restored if you disable ConsolePort.|r\nPress |T%s:20:20:0:0|t again to continue anyway.',
		OVERRIDE_C 			= '|cFFFF6600%s|r is already calibrated for |cFFFF6600%s|r\nPress |T%s:20:20:0:0|t again to continue anyway.',
		NOEXISTFIX 			= 'something else',
		NEWMODIFIER 		= 'You have attempted to map a modifier.\nThe interface needs to be reloaded in order to continue.',
		RESERVED 			= 'This binding (%s) is reserved to %s.\nYou don\'t need to calibrate your controller sticks.',
		INVALID 			= 'Invalid binding.\nDid you press the correct button?',
		COMBAT 				= 'You are in combat!',
		EMPTY 				= '<Empty>',
		SUCCESS 			= '|T%s:16:16:0:0|t was successfully bound to %s.',
		CONTINUE 			= 'Press |T%s:20:20:0:0|t again to continue.',
		CONFIRM 			= 'Press |T%s:20:20:0:0|t again to confirm.',
		CONTROLLER 			= 'Select your preferred button layout by clicking a controller.',
		CALIB_SKIP_WARNING	= '|cFFFF1111WARNING:|r If you skip this process, your controller will not function properly.\nYou can open this wizard again by using this command: |cFFFFFFFF/cp recalibrate|r',
		WTFTEXT				= 'What is this?',
		AHATEXT				= '|cFF888888World of Warcraft doesn\'t natively support controllers. \nTo solve this problem, the controller has to emulate mouse and keyboard input.|r\n\n%s',
		DISCLAIMER			= 'Using an input mapper is legal and does not violate the terms of use.',
		NOINSTRUCTIONS 		= 'This controller has no mapping instructions yet.',
	},
	SLASH = {
		ACCEPT 				= 'Yes (recommended)',
		ALLOW 				= 'Always allow',
		CANCEL 				= 'Cancel',
		-----------------------------------------------------------
		COMBAT 				= 'Error! Cannot use command in combat!',
		CVAR_APPLIED		= 'New value applied to: |cffffe00a%s|r > %s\nChanges will take effect after you |cffffe00a/reload|r.',
		CVAR_PRINTOUT		= '|cffffe00a%s|r\n|cffaaaaaaCurrent value:|r |cff69ccf0%s|r\n|cffaaaaaaDescription:|r %s',
		CVAR_MISMATCH		= 'Error! Type mismatch in variable |cffffe00a%s|r.\nType should be: |cffffe00a%s|r',
		CVAR_NOEXISTS 		= 'Error! Variable |cffffe00a%s|r isn\'t registered.\nType |cffffe00a/cp cvar|r for complete list.',
		CVAR_PRINTING 		= 'Printing console variables...',
		CVAR_WARNING 		= '|cFFFF1111WARNING:|r Editing variables may cause errors. Proceed with caution!',
		CVAR_WARNING_NULL 	= '|cFFFF1111WARNING:|r A setting variable has been nullified.\nIf you receive errors, please revert this change and |cffffe00a/reload|r.',
		ACTIONBAR_SHOW 		= 'Modify controller action bar',
		ACTIONBAR_NOEXISTS 	= 'This command requires ConsolePortBar to be enabled.',
		TYPE				= '|cffffe00a(ID)|r Change controller type',
		DEBUG_HEADER		= 'Debug information:',
		DEBUG_OUTPUT 		= 'Debug information | |cffffe00a/cp debug discord|r for |cffffe00a#support|r format',
		CONFIG 				= 'Open the configuration panel',
		RECALIBRATE 		= 'Recalibrate controller',
		CALIBRATE 			= 'Recalibrate',
		RESET 				= 'Full addon reset (irreversible)',
		BINDS 				= 'Open binding menu',
		EDITBINDS 			= 'Edit bindings',
		CVARLIST 			= '(Advanced) List of console variables',
		CONFIG_COMBAT 		= 'Your controller configuration will be shown when you leave combat.',
		-----------------------------------------------------------
		WARNINGBINDINGUI 	= '|cffffe00a[ConsolePort]|r\n|cFFFF1111WARNING:|r You can only customize your keyboard bindings from this panel.\n\nModifying keyboard bindings while using your controller is not recommended.\n\nAny changes you commit here will also save and upload your controller calibration, which may overwrite your keyboard bindings.\n\nWould you like to edit your controller bindings, recalibrate your controller or continue anyway?',
		WARNINGSAVEBINDINGS = '|cffffe00a[ConsolePort]|r\n|cFFFF1111WARNING:|r An attempt was made to save and upload your keyboard bindings. Called from:\n\n%s\nin interface module %s.\n\nYour controller calibration will overwrite any conflicting bindings. These bindings will not be restored when ConsolePort is disabled.',
		WARNINGCOMBATLOGIN 	= '|cffffe00a[ConsolePort]|r\n|cFFFF1111WARNING:|r You reloaded your interface in combat.\nLeave combat to complete initialization.',
		ADVANCED_DATA		= '|cffffe00a[ConsolePort]|r\n|cFFFF1111WARNING:|r You are about to apply changes to the following settings:\n\n%s\nThis will cause your interface to reload. Any changes you made in the other configuration tabs will be discarded.',
		ADVANCED_EXPORT 	= '|cffffe00a[ConsolePort]|r\nThis is your serialized export data:\n\n%s\nCtrl+A to select and Ctrl+C to copy.',
		ADVANCED_IMPORT_A 	= '|cffffe00a[ConsolePort]|r\nPaste your profile data:',
		ADVANCED_IMPORT_B 	= '|cffffe00a[ConsolePort]|r\nYou are about to load settings for:\n\n%s\nYou will be able to browse these settings before applying them.',
		NEWCONTROLLER 		= '|cffffe00a[ConsolePort]|r\nYou have loaded a new controller profile. Would you like to load the default bindings for this controller?',
		NEWCHARACTER 		= '|cffffe00a[ConsolePort]|r\nWould you like to load the default bindings for your controller?',
		NOBINDINGS 			= '|cffffe00a[ConsolePort]|r\nYou don\'t have any bindings configured for this specialization. Would you like to load the default bindings for your controller?',
		CALIBRATIONUPDATE	= '|cffffe00a[ConsolePort]|r\nYour current calibration doesn\'t match your WoWmapper settings. Would you like to update your calibration?',
		WMUPDATE 			= '|cffffe00a[ConsolePort]|r\nYou have recently changed your WoWmapper settings. For these changes to take effect, the interface has to be reloaded.\nReload now?',
		EXTERNALLINK 		= '|cffffe00a[ConsolePort]|r\nLink to %s.\nCtrl+A to select and Ctrl+C to copy.',
	},
	ERRORS = {
		FOCUSUNIT			= '|cFFFF1111NOTE:|r While the interface cursor is enabled, you cannot use |cFFAAAAFF'..SET_FOCUS..'|r from dropdown menus with your regular mouse. Use the interface cursor or a dedicated binding instead.',
		CORRUPTFRAME 		= '|cffffe00a[ConsolePort]|r\n|cFFFF1111WARNING:|r Attempted to add a corrupt frame to interface cursor: %s',
		CORRUPTFRAME_CHILD  = '%s: GetChildren has been replaced by an addon. Unit hotkeys and raid cursor will cause restricted environment lockdown.';
	},
},
TOOLTIP = {
	COMPARE 			=	'Compare',
	QUEST_TRACKER 		=	'Set current quest',
	USE_NOCOMBAT 		=	'Use (out of combat)',
	BUY 				= 	'Buy',
	USE 				= 	'Use',
	EQUIP				= 	'Equip',
	SELL 				= 	'Sell',
	QUEST_DETAILS 		= 	'View quest details',
	PICKUP 				= 	'Pick up',
	PICKUP_ITEM			= 	'Pick up',
	CANCEL 				= 	'Cancel',
	STACK_BUY 			= 	'Buy a different amount',
	STACK_SPLIT 		= 	'Split stack',
	ITEM_MENU			=	'OPTIONS',
	ADD_TO_EXTRA		= 	'Add to utility ring',
	FLYOUT 				= 	'%s Cast spell %s Cancel',
	MAP_CANVAS_ZOOM_IN 	= 	'Zoom in',
	MAP_CANVAS_ZOOM_OUT = 	'Zoom out',
	UTILITY_RELEASE 	= 	'|T%s:24:24:0:0|t Release to use',
	UTILITY_REMOVE 		= 	'|T%s:24:24:0:0|t Remove',
},
CUSTOMBINDS = {
	-- Headers
	-----------------------------------------------------------
	CP_MOUSE 			= 	'Mouse Simulation',
	CP_UTILITY 			= 	'Utility',
	CP_CAMERA 			= 	'Camera',
	CP_TARGETING 		= 	'Targeting',
	CP_PAGER 			= 	'Action Set (Hold)',
	-- Bindings
	-----------------------------------------------------------
	CP_TOGGLEADDON		= 	'Toggle ConsolePort On/Off',
	CP_UTILITYBELT		= 	'Utility Ring',
	CP_PETRING 			= 	'Pet Ring',
	CP_RAIDCURSOR		= 	'Toggle Raid Cursor',
	CP_RAIDCURSOR_F 	= 	'Focus Raid Cursor',
	CP_RAIDCURSOR_T 	= 	'Target Raid Cursor',
	CP_EM_FRAMES		=	'Target Unit Frames (Hold)',
	CP_EM_PLATES		=	'Target Nameplates (Hold)',
	CP_EM_NEAREST		= 	'Target Nearest or Nameplates (Hold)',
	CP_TOGGLEMOUSE		= 	'Toggle Mouse Look',
	CP_FOCUSCAST		= 	FOCUS_CAST_KEY_TEXT .. ' (Hold)',
	CP_PAGE2 			= 	BINDING_NAME_ACTIONPAGE2 .. ' (Hold)',
	CP_PAGE3 			= 	BINDING_NAME_ACTIONPAGE3 .. ' (Hold)',
	CP_PAGE4 			= 	BINDING_NAME_ACTIONPAGE4 .. ' (Hold)',
	CP_PAGE5 			= 	BINDING_NAME_ACTIONPAGE5 .. ' (Hold)',
	CP_PAGE6 			= 	BINDING_NAME_ACTIONPAGE6 .. ' (Hold)',
	CP_CAMZOOMIN		= 	BINDING_NAME_CAMERAZOOMIN .. ' (x5)',
	CP_CAMZOOMOUT		= 	BINDING_NAME_CAMERAZOOMOUT .. ' (x5)',
	CP_ZOOMIN_HOLD 		= 	BINDING_NAME_CAMERAZOOMIN .. ' (Hold)',
	CP_ZOOMOUT_HOLD 	= 	BINDING_NAME_CAMERAZOOMOUT .. ' (Hold)',
	CP_CAMLOOKBEHIND	= 	'Look Behind',
	-- Strings in case controller has no texture for the binding XML
	-----------------------------------------------------------
	CP_X_CENTER			= 	'|c75757575Guide |caaee5555(disabled)|r',
	CP_T5 				= 	'|c75757575Extra 1 |caaee5555(disabled)|r',
	CP_T6 				= 	'|c75757575Extra 2 |caaee5555(disabled)|r',
	CP_T7 				= 	'|c75757575Extra 3 |caaee5555(disabled)|r',
	CP_T8 				= 	'|c75757575Extra 4 |caaee5555(disabled)|r',
	-- Headers
	-----------------------------------------------------------
	CAMERAORSELECTORMOVE 	= 	'Left Mouse Button',
	TURNORACTION 			= 	'Right Mouse Button',
},
ACTIONBAR = {
	EYE_HEADER 			= '|cff1eff00ConsolePort Action Bar|r: %s',
	EYE_LOCKED			= '|c75757575Locked|r',
	EYE_UNLOCKED		= '|cffffe00aUnlocked|r',
	EYE_LEFTCLICK 		= '%s Show/hide modified actions. (Left click)',
	EYE_RIGHTCLICK 		= '%s Toggle cover art display. (Right click)',
	EYE_LEFTCLICK_SHIFT = '%s%s Lock/unlock the bar. (Shift+Left click)',
	EYE_LEFTCLICK_CTRL 	= '%s%s Reset position. (Ctrl+Left click)',
	EYE_SCROLL 			= 'Mouse wheel: Change scale.',
	EYE_SCROLL_SHIFT 	= 'Shift + Mouse wheel: Change width.',
	-----------------------------------------------------------
	CFG_LOCK 			= 'Lock action bar',
	CFG_LOCKPET 		= 'Lock pet ring',
	CFG_DISABLEPET 		= 'Disable pet ring',
	CFG_DISABLETOTEM	= 'Disable totem ring',
	CFG_DISABLESTANCE   = 'Disable stance ring',
	CFG_DISABLEDND		= 'Disable drag and drop',
	CFG_DISABLERETICLE	= 'Disable reticle cast on release',
	CFG_HIDEINCOMBAT 	= 'Hide in combat',
	CFG_HIDEPETINCOMBAT = 'Hide pet ring in combat',
	CFG_HIDEOUTOFCOMBAT = 'Fade out of combat',
	CFG_SHOWALLBUTTONS 	= 'Always show all buttons',
	CFG_WATCHBAR_OFF 	= 'Disable watch bars',
	CFG_WATCHBAR_ALPHA 	= 'Keep watch bars visible',
	CFG_WATCHBAR_EXP 	= 'Disable experience bar',
	CFG_WATCHBAR_AP 	= 'Disable artifact power bar',
	CFG_QUICKMENU 		= 'Show quick menu',
	CFG_MOUSE_ENABLE 	= 'Width/scale on mouse wheel',
	CFG_ART_UNDERLAY 	= 'Show class art underlay',
	CFG_ART_BLEND		= 'Blend class art underlay',
	CFG_ART_FLASH		= 'Flash art underlay on proc',
	CFG_ART_SMALL 		= 'Smaller art underlay',
	CFG_ART_TINT		= 'Show color tint',
	CFG_COLOR_RAINBOW 	= 'I like rainbows',
	CFG_DISABLE_ICONS	= 'Hide main button icons',
	CFG_DISABLE_MINIS	= 'Hide modifier icons',
	CFG_OLD_BORDERS		= 'Use beveled borders',
	CFG_CAST_DEFAULT	= 'Show default cast bar',
	CFG_CAST_NOHOOK		= 'Disable cast bar modification',
	CFG_VALID_ENTRIES 	= "Valid:\n%s",
	CFG_COLOR_TOOLTIP 	= '|cFFFF0000%s|r |cFF00FF00%s|r |cFF0000FF%s|r |cFFFFFFFF%s|r\nLeft click: change color.\nRight click: reset color.',
	-----------------------------------------------------------
},
HEADERS = {
	CP_LEFT 			= 'Directional Pad',
	CP_RIGHT			= 'Action Buttons',
	CP_CENTER			= 'Center Buttons',
	CP_TRIG				= 'Triggers',
	CP_EXTRA 			= 'Extra',
}}


-- Fill in non-existing values in the locale tables
do
	local function CheckLocale(dbTable, defaultTable)
		for key, value in pairs(defaultTable) do
			if type(value) == 'table' then
				if not dbTable[key] then
					dbTable[key] = {}
				end
				CheckLocale(dbTable[key], value)
			elseif type(value) == 'string' and not dbTable[key] then
				dbTable[key] = value
			end
		end
	end

	for val, tbl in pairs(DEFAULT) do
		if not db[val] then
			db[val] = tbl
		end
		CheckLocale(db[val], tbl)
	end
end

DEFAULT = nil

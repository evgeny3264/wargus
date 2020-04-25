--       _________ __                 __
--      /   _____//  |_____________ _/  |______     ____  __ __  ______
--      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
--      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ \
--     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
--             \/                  \/          \//_____/            \/
--  ______________________                           ______________________
--                        T H E   W A R   B E G I N S
--         Stratagus - A free fantasy real time strategy game engine
--
--      options.lua - Define the menu for options.
--
--      (c) Copyright 2006-2016 by Jimmy Salmon, Pali Rohár, Kyran Jackson and cybermind
--
--      This program is free software; you can redistribute it and/or modify
--      it under the terms of the GNU General Public License as published by
--      the Free Software Foundation; either version 2 of the License, or
--      (at your option) any later version.
--
--      This program is distributed in the hope that it will be useful,
--      but WITHOUT ANY WARRANTY; without even the implied warranty of
--      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--      GNU General Public License for more details.
--
--      You should have received a copy of the GNU General Public License
--      along with this program; if not, write to the Free Software
--      Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--

function AddSoundOptions(menu, offx, offy, centerx, bottom)
   local b

   b = menu:addLabel(_("Sound Options"), 128, 11, Fonts["game"])

   b = Label(_("Effects Volume"))
   b:setFont(CFont:Get("game"))
   b:adjustSize();
   menu:add(b, offx + 16, offy + 36 * 1)

   local soundslider = {}
   local soundsliderleftbutton = {}
   local soundsliderrightbutton = {}
   -- slider button to decrease slider value
   soundsliderleftbutton = menu:addImageLeftSliderButton("", nil, 21, offy + 36 * 1.5,
							 function() soundslider:setValue(soundslider:getValue() - 25.5); SetEffectsVolume(soundslider:getValue()) end)

   -- slider button to increase slider value
   soundsliderrightbutton = menu:addImageRightSliderButton("", nil, 213, offy + 36 * 1.5,
							   function() soundslider:setValue(soundslider:getValue() + 25.5); SetEffectsVolume(soundslider:getValue()) end)

   -- slider itself
   soundslider = menu:addImageSlider(0, 255, 172, 18, offx + 41, offy + 36 * 1.5, g_marker, g_slider,
				     function() SetEffectsVolume(soundslider:getValue()) end)

   -- set the value so the game saves it
   soundslider:setValue(GetEffectsVolume())

   b = Label("min")
   b:setFont(CFont:Get("small"))
   b:adjustSize();
   menu:addCentered(b, offx + 32, offy + 36 * 2 + 2)

   b = Label("max")
   b:setFont(CFont:Get("small"))
   b:adjustSize();
   menu:addCentered(b, offx + 224, offy + 36 * 2 + 2)

   menu:addLabel(_("Sound:"), 12, 176, Fonts["game"], false)
   menu:addLabel(_("On"), 60, 202, Fonts["game"], false)
   menu:addLabel(_("Off"), 60, 224, Fonts["game"], false)

   local effectscheckbox = {}
   effectscheckbox = menu:addImageRadioButton("", "effectscheckbox", 37, 200, offi, offi2, oni, oni2, function()
						 SetEffectsEnabled(true)
						 soundslider:setEnabled(true)
						 soundsliderrightbutton:setEnabled(true)
						 soundsliderleftbutton:setEnabled(true)
   end)
   effectscheckbox:setMarked(IsEffectsEnabled())

   effectscheckbox = menu:addImageRadioButton("", "effectscheckbox", 37, 222, offi, offi2, oni, oni2, function()
						 SetEffectsEnabled(false)
						 soundslider:setEnabled(false)
						 soundsliderrightbutton:setEnabled(false)
						 soundsliderleftbutton:setEnabled(false)
   end)
   if (IsEffectsEnabled() == true) then
      effectscheckbox:setMarked(false)
      soundslider:setEnabled(true)
      soundsliderrightbutton:setEnabled(true)
      soundsliderleftbutton:setEnabled(true)
   else
      effectscheckbox:setMarked(true)
      soundslider:setEnabled(false)
      soundsliderrightbutton:setEnabled(false)
      soundsliderleftbutton:setEnabled(false)
   end

   b = Label(_("Music Volume"))
   b:setFont(CFont:Get("game"))
   b:adjustSize();
   menu:add(b, offx + 16, offy + 36 * 2.75)

   local musicslider = {}
   local musicsliderleftbutton = {}
   local musicsliderrightbutton = {}
   -- slider button to decrease slider value
   musicsliderleftbutton = menu:addImageLeftSliderButton("", nil, 21, offy + 36 * 3.25, function() musicslider:setValue(musicslider:getValue() - 25.5); SetMusicVolume(musicslider:getValue()) end)

   -- slider button to decrease slider value
   musicsliderrightbutton = menu:addImageRightSliderButton("", nil, 213, offy + 36 * 3.25, function() musicslider:setValue(musicslider:getValue() + 25.5); SetMusicVolume(musicslider:getValue()) end)

   -- slider itself
   musicslider = menu:addImageSlider(0, 255, 172, 18, offx + 41, offy + 36 * 3.25, g_marker, g_slider, function() SetMusicVolume(musicslider:getValue()) end)

   -- set the value so the game saves it
   musicslider:setValue(GetMusicVolume())

   b = Label("min")
   b:setFont(CFont:Get("small"))
   b:adjustSize();
   menu:addCentered(b, offx + 32, 137)

   b = Label("max")
   b:setFont(CFont:Get("small"))
   b:adjustSize();
   menu:addCentered(b, offx + 224, 137)

   local stereoSound = menu:addImageCheckBox(_("Stereo Sound"), offx + 16, offy + 36 * 4.25, offi, offi2, oni, oni2, function() end)
   stereoSound:setMarked(Preference.StereoSound)
   stereoSound:setActionCallback(
      function()
	 Preference.StereoSound = stereoSound:isMarked()
   end)

   menu:addLabel(_("Music:"), 112, 176, Fonts["game"], false)
   menu:addLabel(_("On"), 160, 202, Fonts["game"], false)
   menu:addLabel(_("Off"), 160, 224, Fonts["game"], false)

   local musiccheckbox = {}
   musiccheckbox = menu:addImageRadioButton("", "musiccheckbox", 138, 200, offi, offi2, oni, oni2, function()
					       SetMusicEnabled(true)
					       musicslider:setEnabled(true)
					       musicsliderrightbutton:setEnabled(true)
					       musicsliderleftbutton:setEnabled(true)
					       MusicStopped()
   end)
   musiccheckbox:setMarked(IsMusicEnabled())

   musiccheckbox = menu:addImageRadioButton("", "musiccheckbox", 138, 222, offi, offi2, oni, oni2, function()
					       SetMusicEnabled(false)
					       musicslider:setEnabled(false)
					       musicsliderrightbutton:setEnabled(false)
					       musicsliderleftbutton:setEnabled(false)
   end)
   if (IsMusicEnabled() == true) then
      musiccheckbox:setMarked(false)
      musicslider:setEnabled(true)
      musicsliderrightbutton:setEnabled(true)
      musicsliderleftbutton:setEnabled(true)
   else
      musiccheckbox:setMarked(true)
      musicslider:setEnabled(false)
      musicsliderrightbutton:setEnabled(false)
      musicsliderleftbutton:setEnabled(false)
   end

   b = menu:addHalfButton("~!OK", "o", 16 + 12 + 106, 288 - 40,
			  function()
			     wc2.preferences.EffectsVolume = GetEffectsVolume()
			     wc2.preferences.EffectsEnabled = IsEffectsEnabled()
			     wc2.preferences.MusicVolume = GetMusicVolume()
			     wc2.preferences.MusicEnabled = IsMusicEnabled()
			     wc2.preferences.StereoSound = Preference.StereoSound
			     SavePreferences()
			     menu:stop()
   end)

   b = menu:addHalfButton(_("~!Cancel"), "c", 16, 288 - 40,
			  function()
			     menu:stop()
   end)
end

function RunGameSoundOptionsMenu()
   local menu = WarGameMenu(panel(1))
   menu:resize(256, 288)

   AddSoundOptions(menu, 0, 0, 256/2 - 192/2, 256)

   if GameCycle > 0 then
      menu:run(false)
   else
      menu:run()
   end
end

function RunPreferencesMenu()
   local menu = WarGameMenu(panel(5))
   menu:resize(352, 352)
   menu:addLabel(_("Preferences"), 352 / 2, 11, Fonts["large"], true)

   local showHotkeys = menu:addImageCheckBox(_("Show Hotkeys"), 10, 10 + 18,  offi, offi2, oni, oni2,
					     function()
   end)
   showHotkeys:setMarked(UI.ButtonPanel.ShowCommandKey)
   showHotkeys:setActionCallback(
      function()
	 UI.ButtonPanel.ShowCommandKey = showHotkeys:isMarked()
   end)

   local grabMouse = menu:addImageCheckBox(_("Grab Mouse"), 10, 10 + 18 * 2, offi, offi2, oni, oni2, function()end)
   grabMouse:setMarked(GetGrabMouse())
   grabMouse:setActionCallback(
      function()
	 SetGrabMouse(grabMouse:isMarked())
   end)

   local showDamage = menu:addImageCheckBox(_("~!*Show damage"), 10, 10 + 18 * 3, offi, offi2, oni, oni2, function() end)
   showDamage:setActionCallback(
      function()
	 if showDamage:isMarked() == true then
	    SetDamageMissile("missile-hit")
	 else
	    SetDamageMissile(nil)
	 end
   end)
   showDamage:setMarked(wc2.preferences.ShowDamage)

   local showButtonPopups = menu:addImageCheckBox(_("~!*Show button popups"), 10, 10 + 18 * 4, offi, offi2, oni, oni2,
						  function()
   end)
   showButtonPopups:setMarked(wc2.preferences.ShowButtonPopups)

   local mineNotifications = menu:addImageCheckBox(_("Mine notifications"), 10, 10 + 18 * 5,  offi, offi2, oni, oni2, function() end)
   mineNotifications:setActionCallback(
      function()
	 Preference.MineNotifications = mineNotifications:isMarked()
   end)
   mineNotifications:setMarked(Preference.MineNotifications)

   local showOrders = menu:addImageCheckBox(_("Show orders"), 10, 10 + 18 * 6,  offi, offi2, oni, oni2, function() end)
   showOrders:setActionCallback(
      function()
	 if showOrders:isMarked() == true then
	    Preference.ShowOrders = 1
	 else
	    Preference.ShowOrders = 0
	 end
   end)
   if Preference.ShowOrders > 0 then
      showOrders:setMarked(true)
   else
      showOrders:setMarked(false)
   end

   local useFancyBuildings = menu:addImageCheckBox(_("Mirrored buildings"), 10, 10 + 18 * 7,  offi, offi2, oni, oni2, function() end)
   useFancyBuildings:setActionCallback(
      function()
	 SetFancyBuildings(useFancyBuildings:isMarked())
   end)
   useFancyBuildings:setMarked(wc2.preferences.UseFancyBuildings)

   local showMessages = menu:addImageCheckBox(_("Show messages"), 10, 10 + 18 * 8,  offi, offi2, oni, oni2, function() end)
   showMessages:setActionCallback(
      function()
	 Preference.ShowMessages = showMessages:isMarked()
   end)
   showMessages:setMarked(wc2.preferences.ShowMessages)

   local pauseOnLeave = menu:addImageCheckBox(_("Pause on leave"), 10, 10 + 18 * 9, offi, offi2, oni, oni2, function() end)
   pauseOnLeave:setActionCallback(
      function()
	 Preference.PauseOnLeave = pauseOnLeave:isMarked()
   end)
   pauseOnLeave:setMarked(wc2.preferences.PauseOnLeave)

   local enhancedEffects = menu:addImageCheckBox(_("~!*Enhanced effects"), 10, 10 + 18 * 10, offi, offi2, oni, oni2, function() end)
   enhancedEffects:setMarked(wc2.preferences.EnhancedEffects)

   local deselectInMine = menu:addImageCheckBox(_("Deselect in mines"), 10, 10 + 18 * 11, offi, offi2, oni, oni2, function() end)
   deselectInMine:setActionCallback(
      function()
	 Preference.DeselectInMine = deselectInMine:isMarked()
   end)
   deselectInMine:setMarked(wc2.preferences.DeselectInMine)

   local fogOfWar
   if (not IsNetworkGame()) then
      fogOfWar = menu:addImageCheckBox(_("Fog of War"), 10, 10 + 18 * 12, offi, offi2, oni, oni2, function() end)
      fogOfWar:setActionCallback(
	 function()
	    SetFogOfWar(fogOfWar:isMarked())
      end)
      fogOfWar:setMarked(wc2.preferences.FogOfWar)
   end

   local selectionStyleList = {"rectangle", "alpha-rectangle", "circle", "alpha-circle", "corners"}
   local selectionStyleList1 = {_("rectangle"), _("alpha-rectangle"), _("circle"), _("alpha-circle"), _("corners")}
   menu:addLabel(_("Selection style:"), 225, 28 + 19 * 0, Fonts["game"], false)
   local selectionStyle = menu:addDropDown(selectionStyleList1, 225, 28 + 19 * 1, function(dd) end)
   selectionStyle:setSelected(tableindex(selectionStyleList, wc2.preferences.SelectionStyle) - 1)
   selectionStyle:setActionCallback(
      function()
	 SetSelectionStyle(selectionStyleList[selectionStyle:getSelected() + 1])
   end)
   selectionStyle:setSize(120, 16)

   local viewportModeList = {_("single"), _("horizontal 1 + 1"), _("horizontal 1 + 2"), _("vertical 1 + 1"), _("quad")}
   menu:addLabel(_("Viewport mode:"), 225, 28 + 19 * 2, Fonts["game"], false)
   local viewportMode = menu:addDropDown(viewportModeList, 225, 28 + 19 * 3, function(dd) end)
   viewportMode:setSelected(wc2.preferences.ViewportMode)
   viewportMode:setActionCallback(
      function()
	 SetNewViewportMode(viewportMode:getSelected())
   end)
   viewportMode:setSize(120, 16)

   menu:addLabel(_("~!*SF2 soundfont path :"), 10, 10 + 18 * 13, Fonts["game"], false)
   local sf2SoundfontPath = menu:addTextInputField(Preference.SF2Soundfont, 10, 10 + 18 * 14, 200)

   menu:addLabel(_("~!* - requires restart"), 10, 10 + 18 * 16, Fonts["game"], false)


   menu:addHalfButton("~!OK", "o", 206, 352 - 40,
		      function()
			 wc2.preferences.GrabMouse = GetGrabMouse()
			 wc2.preferences.ShowCommandKey = UI.ButtonPanel.ShowCommandKey
			 wc2.preferences.MineNotifications = Preference.MineNotifications
			 wc2.preferences.ShowDamage = showDamage:isMarked()
			 wc2.preferences.ShowButtonPopups = showButtonPopups:isMarked()
			 wc2.preferences.UseFancyBuildings = useFancyBuildings:isMarked()
			 wc2.preferences.ShowMessages = Preference.ShowMessages
			 wc2.preferences.PauseOnLeave = Preference.PauseOnLeave
			 wc2.preferences.EnhancedEffects = enhancedEffects:isMarked()
			 wc2.preferences.DeselectInMine = Preference.DeselectInMine
			 Preference.SF2SoundFont = sf2SoundfontPath:getText()
			 wc2.preferences.SF2SoundFont = sf2SoundfontPath:getText()
			 if (not IsNetworkGame()) then
			    wc2.preferences.FogOfWar = fogOfWar:isMarked()
			 end
			 if Preference.ShowOrders > 0 then
			    wc2.preferences.ShowOrders = true
			 else
			    wc2.preferences.ShowOrders = false
			 end
			 wc2.preferences.SelectionStyle = selectionStyleList[selectionStyle:getSelected() + 1]
			 wc2.preferences.ViewportMode = viewportMode:getSelected()
			 SavePreferences()
			 menu:stop(1)
   end)

   menu:addHalfButton(_("~!Cancel"), "c", 40, 352 - 40,
		      function()
			 menu:stop()
   end)
   if GameCycle > 0 then
      menu:run(false)
   else
      menu:run()
   end
end

function RunSpeedsMenu()
   local menu = WarGameMenu(panel(1))

   menu:addLabel(_("Speed Settings"), 128, 8, Fonts["game"])
   menu:addLabel(_("Game Speed"), 12, 44, Fonts["game"], false)

   local gamespeed = {}
   -- slider button to decrease slider value
   gamespeed = menu:addImageLeftSliderButton("", nil, 21, 60, function() gamespeed:setValue(gamespeed:getValue() - 5); SetGameSpeed(gamespeed:getValue()) end)

   -- slider button to decrease slider value
   gamespeed = menu:addImageRightSliderButton("", nil, 213, 60, function() gamespeed:setValue(gamespeed:getValue() + 5); SetGameSpeed(gamespeed:getValue()) end)

   -- slider itself
   gamespeed = menu:addImageSlider(15, 75, 172, 18, 41, 60, g_marker, g_slider, function() SetGameSpeed(gamespeed:getValue()) end)

   -- set the value so the game saves it
   gamespeed:setValue(GetGameSpeed())

   menu:addLabel(_("slow "), 22, 80, Fonts["small"], false)
   local l = Label(_("fast"))
   l:setFont(Fonts["small"])
   l:adjustSize()
   menu:add(l, 234 - l:getWidth(), 80)

   menu:addLabel(_("Mouse Scroll Speed"), 12, 112, Fonts["game"], false)

   local mousescrollspeed = {}
   -- slider button to decrease slider value
   mousescrollspeed = menu:addImageLeftSliderButton("", nil, 21, 128, function() mousescrollspeed:setValue(mousescrollspeed:getValue() - .5); SetMouseScrollSpeed(mousescrollspeed:getValue()) end)

   -- slider button to decrease slider value
   mousescrollspeed = menu:addImageRightSliderButton("", nil, 213, 128, function() mousescrollspeed:setValue(mousescrollspeed:getValue() + .5); SetMouseScrollSpeed(mousescrollspeed:getValue()) end)

   -- slider itself
   mousescrollspeed = menu:addImageSlider(1, 10, 172, 18, 41, 128, g_marker, g_slider, function() SetMouseScrollSpeed(mousescrollspeed:getValue()) end)

   -- set the value so the game saves it
   mousescrollspeed:setValue(GetMouseScrollSpeed())

   menu:addLabel(_("slow "), 22, 148, Fonts["small"], false)
   local l = Label(_("fast"))
   l:setFont(Fonts["small"])
   l:adjustSize()
   menu:add(l, 228 - l:getWidth() + 6, 148)

   menu:addLabel(_("Key Scroll Speed"), 12, 180, Fonts["game"], false)

   local keyscrollspeed = {}
   -- slider button to decrease slider value
   keyscrollspeed = menu:addImageLeftSliderButton("", nil, 21, 196, function() keyscrollspeed:setValue(keyscrollspeed:getValue() - .5); SetMouseScrollSpeed(keyscrollspeed:getValue()) end)

   -- slider button to decrease slider value
   keyscrollspeed = menu:addImageRightSliderButton("", nil, 213, 196, function() keyscrollspeed:setValue(keyscrollspeed:getValue() + .5); SetMouseScrollSpeed(keyscrollspeed:getValue()) end)

   -- slider itself
   keyscrollspeed = menu:addImageSlider(1, 10, 172, 18, 41, 196, g_marker, g_slider,
					function()
					   SetKeyScrollSpeed(keyscrollspeed:getValue())
   end)

   -- set the value so the game saves it
   keyscrollspeed:setValue(GetKeyScrollSpeed())

   menu:addLabel(_("slow "), 22, 216, Fonts["small"], false)
   local l = Label(_("fast"))
   l:setFont(Fonts["small"])
   l:adjustSize()
   menu:add(l, 228 - l:getWidth() + 6, 216)

   menu:addHalfButton("~!OK", "o", 16 + 12 + 106, 288 - 40,
		      function()
			 wc2.preferences.GameSpeed = GetGameSpeed()
			 wc2.preferences.MouseScrollSpeed = GetMouseScrollSpeed()
			 wc2.preferences.KeyScrollSpeed = GetKeyScrollSpeed()
			 SavePreferences()
			 menu:stop(1)
   end)

   menu:addHalfButton(_("~!Cancel"), "c", 16, 288 - 40,
		      function()
			 menu:stop()
   end)

   if GameCycle > 0 then
      menu:run(false)
   else
      menu:run()
   end
end

function SetVideoSize(width, height)
   if (Video:ResizeScreen(width, height) == false) then
      return
   end
   bckground:Resize(Video.Width, Video.Height)
   backgroundWidget = ImageWidget(bckground)
   Load("scripts/ui.lua")
   wc2.preferences.VideoViewportWidth = Video.ViewportWidth
   wc2.preferences.VideoViewportHeight = Video.ViewportHeight
   SavePreferences()
end

function BuildOptionsMenu()
   local menu = WarMenu()
   local offx = (Video.Width - 352) / 2
   local offy = (Video.Height - 352) / 2
   local checkTexture
   local b

   local videoModes = {
      640, 480,
      800, 480,
      720, 480,
      720, 576,
      800, 600,
      1024, 600,
      1024, 768,
      1152, 864,
      1280, 720,
      1280, 768,
      1280, 800,
      1280, 960,
      1280, 1024,
      1360, 768,
      1366, 768,
      1440, 900,
      1400, 1050,
      1600, 900,
      1600, 1200,
      1600, 1280,
      1680, 1050,
      1920, 1080,
      1920, 1200,
      1920, 1440,
      2560, 1600
   }

   local vlist = {}
   for i=1,table.getn(videoModes)/2 do
      vlist[i]=""..tostring(videoModes[i*2-1]).." x "..tostring(videoModes[i*2])..""
   end

   if (wargus.tales == false) then
      menu:addLabel(wargus.Name .. " V" .. wargus.Version .. ", " .. wargus.Copyright, ((Video.Width - 640) / 2 + 320), (Video.Height - 90) + 18*4, Fonts["small"]) -- Copyright information.
   end

   menu:addLabel(_("Video Options"), offx + 176, offy + 1 + 26*-2)
   menu:addLabel(_("Video Resolution"), offx + 16, offy + 34 , Fonts["game"], false)

   videoList = menu:addImageListBox(offx + 16, offy + 50, 200, 7*(table.getn(videoModes)/2+1), vlist)

   local function cb(s)
      SetVideoSize(videoModes[videoList:getSelected()*2+1], videoModes[videoList:getSelected()*2+2])
      menu:stop(1)
   end
   videoList:setActionCallback(cb)


   b = menu:addImageCheckBox(_("Full Screen"), offx + 17, offy + 55 + 26*7 + 14, offi, offi2, oni, oni2,
			     function()
				ToggleFullScreen()
				wc2.preferences.VideoFullScreen = Video.FullScreen
				SavePreferences()
				menu:stop(1)
   end)
   b:setMarked(Video.FullScreen)

   menu:addHalfButton("~!OK", "o", offx + 123, offy + 55 + 26*11 + 14, function() menu:stop() end)

   return menu:run()
end

function RunConfirmRestart(menu)
   local confirm = WarGameMenu(panel(4))
   confirm:resize(288, 128)

   local mes = MultiLineLabel(_("You need to restart game to apply changes, exit now?"))
   mes:setFont(Fonts["game"])
   mes:setAlignment(MultiLineLabel.CENTER)
   mes:setVerticalAlignment(MultiLineLabel.TOP)
   mes:setLineWidth(250)
   mes:setWidth(288)
   mes:setHeight(48)
   mes:setBackgroundColor(dark)
   confirm:add(mes, 0, 25)

   confirm:addHalfButton(_("~!Yes"), "y", 1 * (300 / 3) - 90, 120 - 16 - 27,
			 function()
			    confirm:stop()
			    menu:stop()
			    Exit(0)
   end)

   confirm:addHalfButton(_("~!No"), "n", 3 * (300 / 3) - 130, 120 - 16 - 27,
			 function() confirm:stop() end)

   return confirm:run()
end

function RunLanguageMenu()
   local menu = WarGameMenu(panel(5))
   menu:resize(352, 352)
   local b
   local languageList

   local langlist = {}
   if (LanguageTable ~= nil) then
      for i=1,table.getn(LanguageTable)/3 do
	 langlist[i]=tostring(LanguageTable[(i-1)*3+1])
      end
   end

   menu:addLabel(_("Language Options"), 176, 10)

   menu:addLabel(_("Available languages:"), 16, 34, Fonts["game"], false)
   languageList = menu:addImageListBox(16, 50, 300, math.max(250, 8*(table.getn(LanguageTable)/3+1)), langlist)

   menu:addHalfButton("~!OK", "o", 40, 320, function()
			 if (languageList:getSelected() >= 0) then
			    wc2.preferences.StratagusTranslation = LanguageTable[languageList:getSelected()*3 + 2]
			    wc2.preferences.GameTranslation = LanguageTable[languageList:getSelected()*3 + 3]
			    SetTranslationsFiles(wc2.preferences.StratagusTranslation, wc2.preferences.GameTranslation)
			    SavePreferences()
			    RunConfirmRestart(menu)
			 end
			 menu:stop()
   end)

   menu:addHalfButton(_("~!Cancel"), "c", 206, 320, function()
			 menu:stop()
   end)

   if GameCycle > 0 then
      menu:run(false)
   else
      menu:run()
   end
end


function RunOptionsMenu()
   local continue = 1
   while (continue == 1) do
      continue = BuildOptionsMenu()
   end
end

function RunGameOptionsMenu()
   local menu = WarGameMenu(panel(1))

   menu:addLabel(_("Game Options"), 128, 11)
   menu:addFullButton(_("Speeds (~<F6~>)"), "f6", 16, 40 + 36*0,
		      function() RunSpeedsMenu() end)
   menu:addFullButton(_("Sound (~<F7~>)"), "f7", 16, 40 + 36*1,
		      function() RunGameSoundOptionsMenu() end)
   menu:addFullButton(_("Preferences (~<F8~>)"), "f8", 16, 40 + 36*2,
		      function()
			 RunPreferencesMenu()
			 if (GameCycle == 0) then
			    menu:stopAll(1)
			 end
   end)
   if (GameCycle > 0) then
      menu:addFullButton(_("Diplomacy (~<F9~>)"), "f9", 16, 40 + 36*3,
			 function() RunDiplomacyMenu() end)
   else
      menu:addFullButton(_("Video (~<F9~>)"), "f9", 16, 40 + 36*3,
			 function() RunOptionsMenu(); menu:stopAll(1) end)
      menu:addFullButton(_("Language"), "f13", 16, 40 + 36*4,
			 function() RunLanguageMenu(); menu:stopAll(1) end)
   end
   menu:addFullButton(_("Previous (~<Esc~>)"), "escape", 128 - (224 / 2), 288 - 40,
		      function() menu:stop() end)
   if (GameCycle > 0) then
      menu:run(false)
   else
      menu:run()
   end
end

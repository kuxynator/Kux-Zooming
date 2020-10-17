print("__Kux-Zooming__/control.lua")
modules = {}
local playerMemory = require("module/playerMemory")
local modSettings = require("module/modSettings")
local zoomCalculator = require("module/zoomCalculator")
local binoculars_controler = require("module/binoculars_controler")
local constants = require("constants")
local debug = require("lib/debug")
local interface = require("module/interface")

if script.active_mods["gvv"] then require("__gvv__.gvv")() end
interface.register()

local function syncZoomLevel(player)
    local zoomLevel = nil
    local lastRenderModee = playerMemory.getLastRenderMode(player)
    local wasInSync = nil

    if player.render_mode == 1 and lastRenderModee ~= 1 then
        zoomLevel = playerMemory.getLastGameZoomLevel(player)
        --debug.trace("getLastGameZoomLevel: ",playerMemory.getLastGameZoomLevel(player))
        wasInSync = false
    elseif player.render_mode ~= 1 and lastRenderModee == 1 then
        zoomLevel = playerMemory.getLastChartZoomLevel(player)
        if zoomLevel > constants.BaseMapWorldThreshold then zoomLevel = constants.BaseMapWorldThreshold end
        --debug.trace("getLastChartZoomLevel: ",playerMemory.getLastChartZoomLevel(player))
        wasInSync = false
    else
        zoomLevel = playerMemory.getCurrentZoomLevel(player)zoomLevel = playerMemory.getCurrentZoomLevel(player)
        wasInSync = true
    end

	if wasInSync == false then
		playerMemory.setHasMapMoved(player, true) -- maybe not moved but no warranty, so we set it to true
        playerMemory.setCurrentZoomLevel(player, zoomLevel)
        debug.trace("zoomLevel: ",zoomLevel," (",player.render_mode,"<",playerMemory.getLastRenderMode(player),")")
    end

    return zoomLevel
end

local function zoomIn(player, tick)
    -- prevents double-zoom-in when user has the same key assigned to both actions (in such case both events have the same tick)
    if tick == playerMemory.getLastZoomInTick(player) then return
    else playerMemory.setLastZoomInTick(player, tick) end

    local zoomLevel = syncZoomLevel(player)
    local renderMode = player.render_mode

	if player.render_mode == defines.render_mode.game then	
        zoomLevel = zoomCalculator.calculateZoomedInLevel(player)
        player.zoom = zoomLevel
        debug.trace("zoomLevel: "..zoomLevel)
		--player.character_running_speed_modifier = 1 / zoomLevel
	else
		zoomLevel = zoomCalculator.updateCurrentZoom_ByUserZoomingInOnMap(player)
        --player.open_map(playerMemory.getLastKnownMapPosition(player), zoomLevel)
        debug.trace("zoomLevel: "..zoomLevel)
        --player.character_running_speed_modifier = 1 / zoomLevel
    end

    playerMemory.setLastRenderMode(player, renderMode)
    if renderMode == defines.render_mode.game then
        playerMemory.setLastGameZoomLevel(player, zoomLevel)
    else
        playerMemory.setLastChartZoomLevel(player, zoomLevel)
	end
	interface.onZoomFactorChanged_raise(player, zoomLevel, renderMode)
end

local function zoomOut(player, tick)
    --debug.trace("ZoomingReinvented_alt-zoom-out");

    local zoomLevel = syncZoomLevel(player)
    local renderMode = player.render_mode

    local shouldSwitchBackToMap = zoomCalculator.getShouldSwitchBackToMap(player)
    local zoomLevel = 1

--[[
    if shouldSwitchBackToMap then
            local mapZoomLevel = zoomCalculator.calculateZoomOut_backToMapView(player)
            player.open_map(playerMemory.getLastKnownMapPosition(player), mapZoomLevel)
        return
    end
]]--
    if player.render_mode == defines.render_mode.game then
        zoomLevel = zoomCalculator.calculateZoomedOutLevel(player)
		player.zoom = zoomLevel		
        debug.trace("zoomLevel: "..zoomLevel)
		--player.character_running_speed_modifier = 1 / zoomLevel
	else
		zoomLevel = zoomCalculator.updateCurrentZoom_ByUserZoomingOutOnMap(player)
        --zoomLevel = zoomCalculator.calculateZoomedOutLevel(player)
        --player.open_map(playerMemory.getLastKnownMapPosition(player), zoomLevel)
        debug.trace("zoomLevel: "..zoomLevel)
    end

    playerMemory.setLastRenderMode(player, renderMode)
    if renderMode == defines.render_mode.game then
        playerMemory.setLastGameZoomLevel(player, zoomLevel)
    else
        playerMemory.setLastChartZoomLevel(player, zoomLevel)
	end
	interface.onZoomFactorChanged_raise(player, zoomLevel, renderMode)
end

local function toggleMap(player)
    local zoomLevel = playerMemory.getCurrentZoomLevel(player)
    local renderMode = player.render_mode

    if player.render_mode == defines.render_mode.game then
        playerMemory.setLastGameZoomLevel(player, zoomLevel) -- store current zoom level

        -- toggle to map
        zoomLevel = zoomCalculator.calculateOpenMapZoomLevel(player)
        player.open_map(player.position, zoomLevel)
        renderMode = defines.render_mode.chart
        playerMemory.setLastKnownMapPosition(player, player.position)
        playerMemory.setLastChartZoomLevel(player, zoomLevel)

        debug.trace("zoomLevel: "..zoomLevel.." map")
    else
        playerMemory.setLastChartZoomLevel(player, zoomLevel) -- store current zoom level

        -- toogle to game
        player.close_map()
        renderMode = defines.render_mode.game
        zoomLevel = 1
        player.zoom = zoomLevel
        playerMemory.setLastGameZoomLevel(player, zoomLevel)

        debug.trace("zoomLevel: "..zoomLevel.." game")
        --player.character_running_speed_modifier = 1
    end
    playerMemory.setCurrentZoomLevel(player, zoomLevel)
	playerMemory.setLastRenderMode(player, renderMode)
	interface.onZoomFactorChanged_raise(player, zoomLevel, renderMode)
end

-------------------------------------------------------------------------------

script.on_event("ZoomingReinvented_alt-zoom-out", function(event)
    zoomOut(game.players[event.player_index], event.tick)
end)

script.on_event("ZoomingReinvented_zoom-in", function(event)
    zoomIn(game.players[event.player_index], event.tick)
end)

script.on_event("ZoomingReinvented_alt-zoom-in", function(event)
    zoomIn(game.players[event.player_index], event.tick)
end)

script.on_event("ZoomingReinvented_toggle-map", function(event)
    toggleMap(game.players[event.player_index])
end)

script.on_event(defines.events.on_selected_entity_changed, function(event)
	--print("on_selected_entity_changed")
	local player = game.get_player(event.player_index)
	--print("on_selected_entity_changed "..tostring(player).." "..tostring(event.player_index))
    if player.render_mode == defines.render_mode.chart_zoomed_in and player.selected then
        playerMemory.setLastKnownMapPosition(player, player.selected.position)
    end
end)

script.on_event("ZoomingReinvented_quick-zoom-in", function(event)
    local player = game.players[event.player_index]
    local zoomLevel = modSettings.getMaxWorldZoomOut(player)

    if player.render_mode == defines.render_mode.chart_zoomed_in and not player.selected then
       player.zoom = zoomLevel
    else
        -- if player selected something, then last_known_map_position has been already updated to its position
        player.zoom_to_world(playerMemory.getLastKnownMapPosition(player), zoomLevel)
    end

    playerMemory.setCurrentZoomLevel(player, zoomLevel)
end)

script.on_event("ZoomingReinvented_quick-zoom-out", function(event)
    local player = game.players[event.player_index]
    local zoom_level = modSettings.getQuickZoomOutZoomLevel(player)

    player.open_map({0, 0}, zoom_level)

    -- do not reset last_known_map_position to allow to use quick-zoom-in to go back to it
    playerMemory.setCurrentZoomLevel(player, zoom_level)
end)

script.on_event(defines.events.on_player_used_capsule, function(event)
    if event.item.name == "ZoomingReinvented_binoculars" then
        local player = game.players[event.player_index]
        binoculars_controler.use(player, event.position)
    end
end)

script.on_event("ZoomingReinvented_move-down", function(event)
    local player = game.players[event.player_index]
    if(player.render_mode ~= defines.render_mode.game) then
        playerMemory.setHasMapMoved(player, true)
    end
end)

script.on_event("ZoomingReinvented_move-left", function(event)
    local player = game.players[event.player_index]
    if(player.render_mode ~= defines.render_mode.game) then
        playerMemory.setHasMapMoved(player, true)
    end
end)

script.on_event("ZoomingReinvented_move-right", function(event)
    local player = game.players[event.player_index]
    if(player.render_mode ~= defines.render_mode.game) then
        playerMemory.setHasMapMoved(player, true)
    end
end)

script.on_event("ZoomingReinvented_move-up", function(event)
    local player = game.players[event.player_index]
    if(player.render_mode ~= defines.render_mode.game) then
        playerMemory.setHasMapMoved(player, true)
    end
end)

script.on_event("ZoomingReinvented_drag-map", function(event)
    local player = game.players[event.player_index]
    if(player.render_mode ~= defines.render_mode.game) then
        playerMemory.setHasMapMoved(player, true)
    end
end)



-- This is called once when a new save game is created 
-- or once when a save file is loaded that previously didn't contain the mod. 
-- This is always called before other event handlers 
-- and is meant for setting up initial values that a mod will use for its lifetime.
script.on_init(function ()
    --game.print("on_init")
end)

-- This is called every time a save file is loaded 
-- *except* for the instance when a mod is loaded into a save file that it previously wasn't part of. 
-- Additionally this is called when connecting to any other game in a multiplayer session and should never change the game state.
script.on_load(function ()
    --game.print("on_load")
end)
script.on_nth_tick(60, function(tickEvent)
	script.on_nth_tick(nil)
	-- game.print("Start")
end)

script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
	if event.player_index == nil then return end -- changed by a script
	modSettings.validateAndFix(game.players[event.player_index])
	debug.onSettingsChanged()
end)

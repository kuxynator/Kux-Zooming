local modSettings = require("module/modSettings")

--- Player memory module
-- @module playerMemory
local module = {}

local function getDefaultValues(player)
    return {
        object_name = "PlayerMemory",
        lastKnownMapPosition = player.position,
        currentZoom = 1,
        mapZoomOutEnabled = true,
        lastZoomInTick = 0,
        lastRenderMode = defines.render_mode.game,
        lastGameZoomLevel = 1,
        lastChartZoomLevel = modSettings.getDefaultMapZoomLevel(player),
        hasMapMoved = false
    }
end

local function getPlayerMemory(player)
    global.playerMemory = global.playerMemory or {}
    local default = getDefaultValues(player)getDefaultValues(player);
    local m = global.playerMemory[player.index] or default
    m.player = player    

    -- migrate new fields
    m.lastKnownMapPosition = m.lastKnownMapPosition or default.lastKnownMapPosition
    m.currentZoom          = m.currentZoom          or default.currentZoom
    m.lastZoomInTick       = m.lastZoomInTick       or default.lastZoomInTick
    m.lastRenderMode       = m.lastRenderMode       or default.lastRenderMode
    m.lastGameZoomLevel    = m.lastGameZoomLevel    or default.lastGameZoomLevel
    m.lastChartZoomLevel   = m.lastChartZoomLevel   or default.lastChartZoomLevel
    m.hasMapMoved          = m.hasMapMoved          or default.hasMapMoved

    global.playerMemory[player.index] = m;
    return m
end

-------------------------------------------------------------------------------

function module.get(player)
    return getPlayerMemory(player)
end

function module.getLastKnownMapPosition(player) return getPlayerMemory(player).lastKnownMapPosition end
function module.setLastKnownMapPosition(player, position) getPlayerMemory(player).lastKnownMapPosition = position end

function module.getCurrentZoomLevel(player) return getPlayerMemory(player).currentZoom end
function module.setCurrentZoomLevel(player, zoomLevel) getPlayerMemory(player).currentZoom = zoomLevel end

function module.getLastZoomInTick(player) return getPlayerMemory(player).lastZoomInTick end
function module.setLastZoomInTick(player, tick) getPlayerMemory(player).lastZoomInTick = tick end

function module.getLastRenderMode(player) return getPlayerMemory(player).lastRenderMode end
function module.setLastRenderMode(player, renderMode) getPlayerMemory(player).lastRenderMode = renderMode end

function module.getLastChartZoomLevel(player) return getPlayerMemory(player).lastChartZoomLevel end
function module.setLastChartZoomLevel(player, zoomLevel) getPlayerMemory(player).lastChartZoomLevel = zoomLevel end

function module.getLastGameZoomLevel(player) return getPlayerMemory(player).lastGameZoomLevel end
function module.setLastGameZoomLevel(player, zoomLevel) getPlayerMemory(player).lastGameZoomLevel = zoomLevel end

function module.getHasMapMoved(player) return getPlayerMemory(player).hasMapMoved end
function module.setHasMapMoved(player, hasMapMoved) getPlayerMemory(player).hasMapMoved = hasMapMoved end

-- local playerMemory = require("playerMemory")
return module

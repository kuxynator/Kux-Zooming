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
    global.playerMemoryTable = global.playerMemoryTable or {}
    local default = getDefaultValues(player)
    local pm = global.playerMemoryTable[player.index] or default
    pm.player = player

    -- migrate new fields
    pm.lastKnownMapPosition = pm.lastKnownMapPosition or default.lastKnownMapPosition
    pm.currentZoom          = pm.currentZoom          or default.currentZoom
    pm.lastZoomInTick       = pm.lastZoomInTick       or default.lastZoomInTick
    pm.lastRenderMode       = pm.lastRenderMode       or default.lastRenderMode
    pm.lastGameZoomLevel    = pm.lastGameZoomLevel    or default.lastGameZoomLevel
    pm.lastChartZoomLevel   = pm.lastChartZoomLevel   or default.lastChartZoomLevel
    pm.hasMapMoved          = pm.hasMapMoved          or default.hasMapMoved

    global.playerMemoryTable[player.index] = pm;
    return pm
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

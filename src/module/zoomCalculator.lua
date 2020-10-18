local constants    = require("constants")
local playerMemory = require("module/playerMemory")
local modSettings  = require("module/modSettings")

--- Zoom calculator module
-- @module zoomCalculator
local module = {}

function module.calculateZoomedInLevel(player)
	local zoomSensitivity = modSettings.getZoomSensitivity(player)
	local zoomLevel = playerMemory.getCurrentZoomLevel(player)
	local newZoomLevel = zoomLevel * zoomSensitivity

	local maxZoomInLevel = constants.MaxWorldZoomInLevel
	if newZoomLevel > maxZoomInLevel then
		return zoomLevel -- do not zoom
	end

	playerMemory.setCurrentZoomLevel(player, newZoomLevel)
	return newZoomLevel
end

function module.calculateZoomedOutLevel(player)
	local zoomSensitivity = modSettings.getZoomSensitivity(player)
	local zoomLevel = playerMemory.getCurrentZoomLevel(player)
	local newZoomLevel = zoomLevel / zoomSensitivity

	local maxZoomOutLevel = modSettings.getMaxWorldZoomOut(player)
	if newZoomLevel < maxZoomOutLevel then
		return zoomLevel -- do not zoom
	end
	playerMemory.setCurrentZoomLevel(player, newZoomLevel)
	return newZoomLevel
end

function module.getShouldSwitchBackToMap(player)
	local currentZoomLevel = playerMemory.getCurrentZoomLevel(player)
	local maxWorldZoomOutLevel = modSettings.getMaxWorldZoomOut(player)
	return player.render_mode == defines.render_mode.chart_zoomed_in and currentZoomLevel == maxWorldZoomOutLevel
end

function module.calculateZoomOut_backToMapView(player)
	local zoom_sensitivity = modSettings.getZoomSensitivity(player)

	local newZoomLevel = playerMemory.getCurrentZoomLevel(player) / zoom_sensitivity
	local maxZoomOutLevel = constants.MAX_MAP_ZOOM_OUT_LEVEL

	if newZoomLevel < maxZoomOutLevel then
		newZoomLevel = maxZoomOutLevel
	end

	playerMemory.setCurrentZoomLevel(player, newZoomLevel)

	return playerMemory.getCurrentZoomLevel(player)
end

function module.calculateOpenMapZoomLevel(player)
	local zoomLevel = modSettings.getDefaultMapZoomLevel(player)
	playerMemory.setCurrentZoomLevel(player, zoomLevel)
	return zoomLevel
end

function module.updateCurrentZoom_ByUserZoomingInOnMap(player)
	local zoomLevel = playerMemory.getCurrentZoomLevel(player)
	local newZoomLevel = zoomLevel * constants.BASE_GAME_ANY_MAP_ZOOM_SENSITIVITY
	if newZoomLevel < constants.BaseMapMaxZoomLevel then
		playerMemory.setCurrentZoomLevel(player, newZoomLevel)
		return newZoomLevel
	else
		return zoomLevel
	end
end

function module.updateCurrentZoom_ByUserZoomingOutOnMap(player)
	local zoomLevel = playerMemory.getCurrentZoomLevel(player)
	local newZoomLevel = zoomLevel / constants.BASE_GAME_ANY_MAP_ZOOM_SENSITIVITY
	if newZoomLevel > constants.BaseMapMinZoomLevel then
		playerMemory.setCurrentZoomLevel(player, newZoomLevel)
		return newZoomLevel
	else
	   return zoomLevel
	end
end

return module

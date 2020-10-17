--- modSettings module
-- @module modSettings
local module = {}

module.validateAndFix = function(player)
    local maxWorldZoomOutLevel = module.getMaxWorldZoomOut(player)

    local defaultMapZoomLevel = module.getDefaultMapZoomLevel(player)
    if defaultMapZoomLevel >= maxWorldZoomOutLevel then
        local newValue = maxWorldZoomOutLevel - 0.0001
        player.print("Invalid settings! Default map zoom level (" .. defaultMapZoomLevel .. ") has to be lower than Max world zoom out level (" .. maxWorldZoomOutLevel .. "). Changed to " .. newValue)
        settings.get_player_settings(player.index)["ZoomingReinvented_default-map-zoom-level"] = { value = newValue }
    end

    local quickZoomOutZoomLevel = module.getQuickZoomOutZoomLevel(player)
    if quickZoomOutZoomLevel >= maxWorldZoomOutLevel then
        local newValue = maxWorldZoomOutLevel - 0.0001
        player.print("Invalid settings! 'Quick zoom out' map zoom level (" .. quickZoomOutZoomLevel .. ") has to be lower than Max world zoom out level (" .. maxWorldZoomOutLevel .. "). Changed to " .. newValue)
        settings.get_player_settings(player.index)["ZoomingReinvented_quick-zoom-out-zoom-level"] = { value = newValue }
    end

    local binocularsZoomLevel = module.getBinocularsZoomLevel(player)
    if binocularsZoomLevel < maxWorldZoomOutLevel then
        local newValue = maxWorldZoomOutLevel
        player.print("Invalid settings! Binoculars zoom level (" .. binocularsZoomLevel .. ") has to be greater or equal to Max world zoom out level (" .. maxWorldZoomOutLevel .. "). Changed to " .. newValue)
        settings.get_player_settings(player.index)["ZoomingReinvented_binoculars-zoom-level"] = { value = newValue }
    end
end

module.getZoomSensitivity = function(player)
    return player.mod_settings["ZoomingReinvented_zoom-sensitivity"].value
end

module.getMaxWorldZoomOut = function(player)
    return player.mod_settings["ZoomingReinvented_max-world-zoom-out"].value
end

module.getDefaultMapZoomLevel = function(player)
    return player.mod_settings["ZoomingReinvented_default-map-zoom-level"].value
end

module.getQuickZoomOutZoomLevel = function(player)
    return player.mod_settings["ZoomingReinvented_quick-zoom-out-zoom-level"].value
end

module.getBinocularsZoomLevel = function(player)
    return player.mod_settings["ZoomingReinvented_binoculars-zoom-level"].value
end

module.is_binoculars_double_action_enabled = function(player)
    return player.mod_settings["ZoomingReinvented_binoculars-double-action-enabled"].value
end

module.isDebugMode = function(player)
    return player.mod_settings["ZoomingReinvented_debug"].value
end

return module

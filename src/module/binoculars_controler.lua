local constant = require("constants")
local playerMemory = require("module/playerMemory")
local modSettings = require("module/modSettings")

local binoculars_controler = {}

binoculars_controler.use = function(player, position)
    local double_action_enabled = modSettings.is_binoculars_double_action_enabled(player)
    local zoom_level

    if double_action_enabled and player.render_mode == defines.render_mode.chart and playerMemory.getCurrentZoomLevel(player) < constant.MIN_MAP_ZOOM_LEVEL_WITH_LABELS_VISIBLE then
        zoom_level = constant.MIN_MAP_ZOOM_LEVEL_WITH_LABELS_VISIBLE
        player.open_map(position, zoom_level)
    else
        zoom_level = modSettings.getBinocularsZoomLevel(player)
        player.zoom_to_world(position, zoom_level)
    end

    playerMemory.setCurrentZoomLevel(player, zoom_level)
    playerMemory.setLastKnownMapPosition(player, position)
end

return binoculars_controler

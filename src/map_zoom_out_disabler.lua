local player_memory = require("player_memory")
local mod_settings = require("mod_settings")

local map_zoom_out_disabler = {}

map_zoom_out_disabler.disable = function (player)
    if player.render_mode ~= defines.render_mode.game then
        player_memory.set_map_zoom_out_enabled(player, false)
    end
end

map_zoom_out_disabler.enable = function (player)
    player_memory.set_map_zoom_out_enabled(player, true)
end


map_zoom_out_disabler.is_enabled = function (player)
    local map_zoom_out_disabling_active = mod_settings.is_disable_map_zoom_out_active(player)
    local map_zoom_out_enabled = player_memory.is_map_zoom_out_enabled(player)
    return not map_zoom_out_disabling_active or map_zoom_out_enabled
end

return map_zoom_out_disabler

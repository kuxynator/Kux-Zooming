local mod_settings = {}

mod_settings.validate_and_fix = function(player)
    local max_world_zoom_out_level = mod_settings.get_max_world_zoom_out(player)

    local default_map_zoom_level = mod_settings.get_default_map_zoom_level(player)
    if default_map_zoom_level >= max_world_zoom_out_level then
        local new_value = max_world_zoom_out_level - 0.0001
        player.print("Invalid settings! Default map zoom level (" .. default_map_zoom_level .. ") has to be lower than Max world zoom out level (" .. max_world_zoom_out_level .. "). Changed to " .. new_value)
        settings.get_player_settings(player.index)["ZoomingReinvented_default-map-zoom-level"] = { value = new_value }
    end

    local quick_zoom_out_zoom_level = mod_settings.get_quick_zoom_out_zoom_level(player)
    if quick_zoom_out_zoom_level >= max_world_zoom_out_level then
        local new_value = max_world_zoom_out_level - 0.0001
        player.print("Invalid settings! 'Quick zoom out' map zoom level (" .. quick_zoom_out_zoom_level .. ") has to be lower than Max world zoom out level (" .. max_world_zoom_out_level .. "). Changed to " .. new_value)
        settings.get_player_settings(player.index)["ZoomingReinvented_quick-zoom-out-zoom-level"] = { value = new_value }
    end

    local binoculars_zoom_level = mod_settings.get_binoculars_zoom_level(player)
    if binoculars_zoom_level < max_world_zoom_out_level then
        local new_value = max_world_zoom_out_level
        player.print("Invalid settings! Binoculars zoom level (" .. binoculars_zoom_level .. ") has to be greater or equal to Max world zoom out level (" .. max_world_zoom_out_level .. "). Changed to " .. new_value)
        settings.get_player_settings(player.index)["ZoomingReinvented_binoculars-zoom-level"] = { value = new_value }
    end
end

mod_settings.get_zoom_sensitivity = function(player)
    return player.mod_settings["ZoomingReinvented_zoom-sensitivity"].value
end

mod_settings.get_max_world_zoom_out = function(player)
    return player.mod_settings["ZoomingReinvented_max-world-zoom-out"].value
end

mod_settings.get_default_map_zoom_level = function(player)
    return player.mod_settings["ZoomingReinvented_default-map-zoom-level"].value
end

mod_settings.get_quick_zoom_out_zoom_level = function(player)
    return player.mod_settings["ZoomingReinvented_quick-zoom-out-zoom-level"].value
end

mod_settings.get_binoculars_zoom_level = function(player)
    return player.mod_settings["ZoomingReinvented_binoculars-zoom-level"].value
end

mod_settings.is_binoculars_double_action_enabled = function(player)
    return player.mod_settings["ZoomingReinvented_binoculars-double-action-enabled"].value
end

mod_settings.is_disable_map_zoom_out_active = function(player)
    return player.mod_settings["ZoomingReinvented_disable-map-zoom-out"].value
end

return mod_settings

local player_memory = {}

local function default_values(player)
    return {
        last_known_map_position = player.position,
        current_zoom = 1,
        map_zoom_out_enabled = true,
        last_zoom_in_tick = 0
    }
end

local function get_player_memory(player)
    global.player_memory = global.player_memory or {}
    global.player_memory[player.index] = global.player_memory[player.index] or default_values(player)

    -- migration from previous mod version
    global.player_memory[player.index].last_zoom_in_tick = global.player_memory[player.index].last_zoom_in_tick or default_values(player).last_zoom_in_tick

    return global.player_memory[player.index]
end


function player_memory.get_last_known_map_position(player)
    return get_player_memory(player).last_known_map_position
end

function player_memory.set_last_known_map_position(player, position)
    get_player_memory(player).last_known_map_position = position
end

function player_memory.get_current_zoom_level(player)
    return get_player_memory(player).current_zoom
end

function player_memory.set_current_zoom_level(player, zoom_level)
    get_player_memory(player).current_zoom = zoom_level
end

function player_memory.is_map_zoom_out_enabled(player)
    return get_player_memory(player).map_zoom_out_enabled
end

function player_memory.set_map_zoom_out_enabled(player, enabled)
    get_player_memory(player).map_zoom_out_enabled = enabled
end

function player_memory.get_last_zoom_in_tick(player)
    return get_player_memory(player).last_zoom_in_tick
end

function player_memory.set_last_zoom_in_tick(player, tick)
    get_player_memory(player).last_zoom_in_tick = tick
end

return player_memory

-- consoming: none|game-only (game-only: only script)
data:extend {
    {
        type = "custom-input",
        name = "ZoomingReinvented_zoom-in",
        key_sequence = "",
        linked_game_control = "zoom-in",
        consuming = "none" -- "none"
    },
    {
        type = "custom-input",
        name = "ZoomingReinvented_alt-zoom-in",
        key_sequence = "",
        linked_game_control = "alt-zoom-in",
        consuming = "none" -- "none"
    },
    {
        type = "custom-input",
        name = "ZoomingReinvented_zoom-out",
        key_sequence = "",
        linked_game_control = "zoom-out",
        consuming = "none" -- "game-only"
    },
    {
        type = "custom-input",
        name = "ZoomingReinvented_alt-zoom-out",
        key_sequence = "",
        linked_game_control = "alt-zoom-out",
        consuming = "none" -- "game-only"
    },
    {
        type = "custom-input",
        name = "ZoomingReinvented_toggle-map",
        key_sequence = "",
        linked_game_control = "toggle-map",
        consuming = "game-only"
    },
    {
        type = "custom-input",
        name = "ZoomingReinvented_quick-zoom-in",
        key_sequence = "UP"
    },
    {
        type = "custom-input",
        name = "ZoomingReinvented_quick-zoom-out",
        key_sequence = "DOWN"
    },
}

data:extend {
    {
        type = "custom-input",
        name = "ZoomingReinvented_move-down",
        key_sequence = "",
        linked_game_control = "move-down"
    },
    {
        type = "custom-input",
        name = "ZoomingReinvented_move-left",
        key_sequence = "",
        linked_game_control = "move-left"
    },
    {
        type = "custom-input",
        name = "ZoomingReinvented_move-right",
        key_sequence = "",
        linked_game_control = "move-right"
    },
    {
        type = "custom-input",
        name = "ZoomingReinvented_move-up",
        key_sequence = "",
        linked_game_control = "move-up"
    },
    {
        type = "custom-input",
        name = "ZoomingReinvented_drag-map",
        key_sequence = "",
        linked_game_control = "drag-map"
    }
}

data:extend {
    {
        type = "capsule",
        name = "ZoomingReinvented_binoculars",
        subgroup = "tool",
        order = "z[binoculars]",
        icons = {
            {
                icon = "__Kux-Zooming__/graphics/binoculars.png",
                icon_size = 32,
            }
        },
        capsule_action =
        {
            type = "artillery-remote",
            flare = "zoom-in-flare"
        },
        flags = {},
        stack_size = 1,
        stackable = false
    },
    {
        type = "recipe",
        name = "ZoomingReinvented_binoculars-recipe",
        enabled = true,
        ingredients = {
            {"iron-plate", 1}
        },
        result = "ZoomingReinvented_binoculars",
    },
    {
        type = "artillery-flare",
        name = "zoom-in-flare",
        flags = {"placeable-off-grid", "not-on-map"},
        map_color = {r=0, g=0, b=0},
        life_time = 1,
        shots_per_flare = 0,
        pictures =
        {
            {
                filename = "__Kux-Zooming__/graphics/binoculars.png",
                width = 1,
                height = 1,
                scale = 0
            }
        }
    }
}

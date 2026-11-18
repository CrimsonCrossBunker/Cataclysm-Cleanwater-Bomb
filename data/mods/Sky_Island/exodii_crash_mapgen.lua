local ccb = require("ccb")

local rows = {
    "|||||",
    "||A||",
    "|_C_|",
    "||M||",
    "||m||",
}
local terrain = {
    ["|"] = "t_wall_metal",
    ["M"] = "t_door_metal_locked",
    ["m"] = "t_secretdoor_metal_c",
    ["_"] = "t_metal_floor",
    ["A"] = "t_metal_floor",
    ["C"] = "t_metal_floor",
}
local furniture = {
    ["A"] = "f_autodoc",
    ["C"] = "f_autodoc_couch",
}
local empty_furniture = { "f_null", "f_null" }

ccb.content.add_nested_mapgen {
    id = "nest_exodii_crash_building_big_2",
    size = #rows,
    build = function(layout)
        layout:erase_before_terrain()
        for y, row in ipairs(rows) do
            for x = 1, #row do
                local glyph = row:sub(x, x)
                layout:terrain(x - 1, y - 1, terrain[glyph])
                layout:furniture(x - 1, y - 1, furniture[glyph] or empty_furniture)
                if glyph == "_" then
                    layout:place_item_group("SUS_exodii_storage_highvalue", x - 1, y - 1, { chance = 40 })
                    layout:place_item_group("si_exodii_cbms_high_value", x - 1, y - 1, { chance = 33 })
                end
            end
        end
        layout:stamp_named("nest_exodii_crash_6x6_roof", 0, 0, 1)
    end,
}

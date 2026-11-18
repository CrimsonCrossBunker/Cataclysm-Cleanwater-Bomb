local ccb = require("ccb")
local content = ccb.content

local function add_roof(id, rows)
    content.add_nested_mapgen {
        id = id,
        size = #rows,
        build = function(layout)
            for y, row in ipairs(rows) do
                for x = 1, #row do
                    if row:sub(x, x) == "R" then layout:terrain(x - 1, y - 1, "t_metal_roof") end
                end
            end
        end,
    }
end

add_roof("nest_exodii_crash_6x6_roof", {
    "RRRRRR",
    "RRRRRR",
    "RRRRRR",
    "RRRRRR",
    "RRRRRR",
    "RRRRRR",
})

add_roof("nest_exodii_crash_oval_roof", {
    " RRRR ",
    "RRRRRR",
    "RRRRRR",
    "RRRRRR",
    "RRRRRR",
    " RRRR ",
})

add_roof("nest_exodii_crash_3x3_roof", {
    "RRR",
    "RRR",
    "RRR",
})

local terrain = {
    ["|"] = "t_wall_metal",
    ["M"] = "t_door_metal_locked",
    ["m"] = "t_secretdoor_metal_c",
    ["_"] = "t_metal_floor",
    ["."] = "t_metal_floor",
}
-- Keep the native furniture choice on each glyph, including null-only choices.
local furniture = {
    ["|"] = { "f_null", "f_null" },
    ["M"] = { "f_null", "f_null" },
    ["m"] = { "f_null", "f_null" },
    ["_"] = { "f_null", "f_null" },
    ["."] = { "f_null", "f_null" },
    ["*"] = { "f_wreckage", "f_null" },
}

local function add_room(id, rows, loot, roof)
    content.add_nested_mapgen {
        id = id,
        size = #rows,
        build = function(layout)
            if roof then layout:erase_before_terrain() end
            for y, row in ipairs(rows) do
                for x = 1, #row do
                    local glyph = row:sub(x, x)
                    if terrain[glyph] then layout:terrain(x - 1, y - 1, terrain[glyph]) end
                    if furniture[glyph] then layout:furniture(x - 1, y - 1, furniture[glyph]) end
                    local items = loot[glyph]
                    if items then
                        layout:place_item_group(items.group, x - 1, y - 1,
                            { chance = items.chance, repetitions = items.repetitions })
                    end
                end
            end
            if roof then layout:stamp_named(roof, 0, 0, 1) end
        end,
    }
end

add_room("nest_exodii_crash_building_big_1", {
    "||||||",
    "|____|",
    "|____|",
    "|_.._|",
    "||MM||",
    "||mm||",
}, {
    ["_"] = { group = "SUS_exodii_storage_lowvalue", chance = 100 },
}, "nest_exodii_crash_6x6_roof")

add_room("nest_exodii_crash_building_big_1", {
    "||||||",
    "||||||",
    "||__||",
    "||__||",
    "||MM||",
    "||mm||",
}, {
    ["_"] = { group = "SUS_exodii_storage_medvalue", chance = 100 },
}, "nest_exodii_crash_6x6_roof")

add_room("nest_exodii_crash_building_big_1", {
    " |||| ",
    "||||||",
    "||__||",
    "||__||",
    "||MM||",
    " |mm| ",
}, {
    ["_"] = { group = "SUS_exodii_storage_medvalue", chance = 100 },
}, "nest_exodii_crash_oval_roof")

add_room("nest_exodii_crash_building_big_1", {
    "||||||",
    "||||||",
    "||__||",
    "||__||",
    "||||||",
    "||||||",
}, {
    ["_"] = { group = "SUS_exodii_storage_medvalue", chance = 100, repetitions = { 1, 2 } },
}, "nest_exodii_crash_6x6_roof")

add_room("nest_exodii_crash_building_big_2", {
    "|||||",
    "|||||",
    "||_||",
    "||M||",
    "||m||",
}, {
    ["_"] = { group = "SUS_exodii_storage_highvalue", chance = 100 },
}, "nest_exodii_crash_6x6_roof")

add_room("nest_exodii_crash_building_big_2", {
    "|||||",
    "|||||",
    "||_||",
    "|||||",
    "|||||",
}, {
    ["_"] = { group = "SUS_exodii_storage_highvalue", chance = 100 },
}, "nest_exodii_crash_6x6_roof")

add_room("nest_exodii_crash_building_big_2", {
    " |m| ",
    "||M||",
    "||_||",
    "|||||",
    " ||| ",
}, {
    ["_"] = { group = "SUS_exodii_storage_highvalue", chance = 100 },
}, "nest_exodii_crash_oval_roof")

add_room("nest_exodii_crash_building_small_1", {
    "|||",
    "|_|",
    "|m|",
}, {
    ["_"] = { group = "SUS_exodii_storage_lowvalue", chance = 100 },
}, "nest_exodii_crash_3x3_roof")

add_room("nest_exodii_crash_building_small_1", {
    "|||",
    "|_|",
    "|||",
}, {
    ["_"] = { group = "SUS_exodii_storage_lowvalue", chance = 100 },
}, "nest_exodii_crash_3x3_roof")

add_room("nest_exodii_crash_building_smashed", {
    "    * ",
    " * ** ",
    " *** *",
    " **** ",
    " ***  ",
    "      ",
}, {
    ["*"] = { group = "recycle_steel", chance = 50, repetitions = { 1, 3 } },
    [" "] = { group = "recycle_steel", chance = 20 },
})

add_room("nest_exodii_crash_building_smashed", {
    "*     ",
    " * ** ",
    "****  ",
    "  *** ",
    "***** ",
    " *   *",
}, {
    ["*"] = { group = "recycle_steel", chance = 50, repetitions = { 1, 3 } },
    [" "] = { group = "recycle_steel", chance = 20 },
})

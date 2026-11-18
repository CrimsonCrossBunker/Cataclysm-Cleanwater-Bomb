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

content.add_nested_mapgen {
    id = "nest_exodii_scouts",
    size = 3,
    build = function(layout)
        layout:furniture({ 0, 2 }, { 0, 2 }, "f_exodii_signpost")
        layout:spawn_monster("mon_exodii_quad", 0, { 0, 2 })
        layout:spawn_monster("mon_exodii_worker", { 1, 2 }, { 0, 2 },
            { chance = 50, repetitions = { 1, 3 } })
    end,
}

content.add_nested_mapgen {
    id = "nest_exodii_zombies",
    size = 3,
    build = function(layout)
        layout:spawn_monster("mon_zomborg", { 0, 2 }, { 0, 2 }, { repetitions = { 1, 4 } })
    end,
}

local ground_terrain = {
    ["."] = { { "t_glassed_sand", 10 }, "t_sandmound" },
    [","] = { { "t_glassed_sand", 3 }, { "t_grass_dead", 3 }, "t_sandmound", "t_sand" },
    [";"] = { "t_rock_floor_no_roof", { "t_sand", 5 }, "t_sandmound" },
    ["|"] = { { "t_rock_floor_no_roof", 10 }, "t_sand" },
}
local ground_furniture = {
    ["."] = { { "f_null", 2000 }, { "f_rubble_rock", 100 } },
    [","] = { { "f_null", 2000 }, { "f_rubble_rock", 100 }, { "f_boulder_small", 12 }, "f_boulder_medium" },
    [";"] = { { "f_null", 2000 }, { "f_rubble_rock", 30 }, { "f_boulder_small", 6 }, "f_boulder_medium", "f_boulder_large" },
    ["|"] = { { "f_null", 2000 }, { "f_rubble_rock", 10 }, "f_wreckage" },
}

local main_crash = {
    "        .........       ",
    "     ...............    ",
    "   .......,,,,,.......  ",
    "  .....,,,,,,,,,,.....  ",
    "  ...,,,,,,,,,,,,,,.... ",
    " ....,,,;;;;;;;,,,,.... ",
    " ...,,,;;;;;;;;;,,,,... ",
    "....,,;;;;;;;;;;,,,,....",
    "...,,,,;;;||||;;,,,,,...",
    "...,;,;;|||||;;;;,,,,...",
    "...,,;;;;||||||;;,,,,...",
    "...,;,;|||||||;;;,,,,...",
    "...,,,,;;||||||;,,,,,...",
    "...,;,,;;|||||;;,,,,,...",
    "...,,,;;|||||||;;,,,,...",
    "...,,,,,;;||;;;;,,,,,...",
    "....,,;,;;;;;;;,,,,,....",
    " ...,,,,,,;;;;;;;,,,... ",
    " ....,,,,,;;;;;,,,,.... ",
    " ....,,,,,,,,,,,,,,.... ",
    "  .......,,,,,,.......  ",
    "  ....................  ",
    "    ................    ",
    "       ..........       ",
}
local scattered_crash = {
    "          .   .         ",
    "     ...  ..  ..   .    ",
    "      ....,, ,,. ...    ",
    "  ...   .,,,,,,,,.. ..  ",
    "   ..,.. ,,,,,,,,,,..   ",
    "    .,,,;;;;;;;,,,,. .  ",
    "      ,;;;;;;;;;,,,,..  ",
    "  ..,,;;;;;;;;;;,,,,    ",
    "...  ,,;;;;|||;;,,,,,...",
    "   ,;,;;|||||;;;;,,,,.. ",
    "...,,;;;;||||||;;,,,    ",
    "   ,;,;|||||||;;;,,,,.. ",
    "... ,,,;|||||||;,,,,,...",
    "..., ,,;;|||||;;,,,,,.. ",
    "   ,,,;;|||||||;;,,,    ",
    "...   ,,;;||;;;;,,,,,...",
    "   .,,;,;;;;;;;,,,,,... ",
    " ...  ,,,,;;;;;;;,,,.   ",
    "    .,,,,,;;;;;,,,, ..  ",
    " ....,,,,,,,,,,,,,,  .. ",
    "  ..  ...,,,,, .. ..    ",
    "    ..  ...... .. ...   ",
    "      ...  ..  .   .    ",
    "      .                 ",
}

local room_choices = {
    { "nest_exodii_crash_building_big_1", 30 },
    { "nest_exodii_crash_building_big_2", 10 },
    { "nest_exodii_crash_building_small_1", 40 },
    { "nest_exodii_crash_building_smashed", 20 },
}

local function crash_site(rows, room_range, encounters)
    return function(layout)
        layout:erase_before_terrain()
        for y, row in ipairs(rows) do
            for x = 1, #row do
                local glyph = row:sub(x, x)
                if ground_terrain[glyph] then
                    layout:terrain(x - 1, y - 1, ground_terrain[glyph])
                    layout:furniture(x - 1, y - 1, ground_furniture[glyph])
                end
            end
        end
        layout:stamp_named(room_choices, room_range, room_range)
        if encounters then layout:stamp_named(encounters, { 7, 14 }, { 16, 18 }) end
    end
end

content.add_update_mapgen {
    id = "mx_exodii_crash_big_1",
    build = crash_site(main_crash, { 6, 10 }, { { "nest_exodii_scouts", 5 }, { "nest_exodii_zombies", 20 } }),
}

content.add_update_mapgen {
    id = "mx_exodii_crash_big_2",
    build = crash_site(scattered_crash, { 7, 10 }, { { "nest_exodii_scouts", 5 }, { "nest_exodii_zombies", 20 } }),
}

content.add_nested_mapgen {
    id = "mx_exodii_crash_big_1_pat",
    size = 24,
    build = crash_site(main_crash, { 6, 10 }, { { "nest_exodii_scouts", 20 }, { "nest_exodii_zombies", 5 } }),
}

content.add_nested_mapgen {
    id = "mx_exodii_crash_big_1_chop_shop",
    size = 24,
    build = crash_site(main_crash, { 6, 10 }),
}

for i = 1, 2 do
    local crash = content.MapExtra {
        id = "mx_exocrash_" .. i,
        name = content.text("Crashed pod"),
        description = content.text("There is some kind of crashed metal pod here."),
        generator_method = "update_mapgen",
        generator_id = "mx_exodii_crash_big_" .. i,
        z_levels = { 0, 0 },
        symbol = "x",
        color = "light_gray",
        autonote_visibility = "details",
    }
    crash:flag("EXODII")
    content.add(crash)
end

local ccb = require("ccb")
local mapgen = ccb.services.mapgen

local directions = { "_north", "_east", "_south", "_west" }

local function rotate(x, y, turns)
    if turns == 1 then return 23 - y, x end
    if turns == 2 then return 23 - x, 23 - y end
    if turns == 3 then return y, 23 - x end
    return x, y
end

local function generate(id, rows, terrain, furniture, place_supplies)
    local terrain_ids = {}
    for i, direction in ipairs(directions) do terrain_ids[i] = id .. direction end
    mapgen.define {
        id = id,
        terrain_ids = terrain_ids,
        after_generate = function(ctx)
            local turns = ctx:get_rotation()
            for y, row in ipairs(rows) do
                for x = 1, #row do
                    local tile = row:sub(x, x)
                    local tx, ty = rotate(x - 1, y - 1, turns)
                    ctx:set_terrain_id(tx, ty, terrain[tile])
                    if furniture and furniture[tile] then
                        ctx:set_furniture_id(tx, ty, furniture[tile])
                    end
                end
            end
            if place_supplies then place_supplies(ctx, turns) end
        end,
    }
end

generate("sky_island_core", {
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "           ...          ",
    "           ...          ",
    "           ...          ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "           YXZ          ",
    "                        ",
    "                        ",
    "                        ",
    "            V           ",
}, {
    [" "] = "t_grass",
    ["."] = "t_concrete",
    ["V"] = "t_concrete",
    ["X"] = "t_grass",
    ["Y"] = "t_grass",
    ["Z"] = "t_grass",
}, {
    ["X"] = "f_exitportal",
    ["V"] = "f_islandstatue",
}, function(ctx, turns)
    local x, y = rotate(11, 19, turns)
    ctx:place_item_group(x, y, x, y, "starterkit_items", 100, "")
    x, y = rotate(13, 19, turns)
    ctx:place_item_group(x, y, x, y, "si_trash_heap", 100, "")

    local x1, y1 = rotate(10, 16, turns)
    local x2, y2 = rotate(14, 20, turns)
    ctx:queue_zone(math.min(x1, x2), math.min(y1, y2), math.max(x1, x2), math.max(y1, y2),
        "ZONE_START_POINT", "your_followers", "", "")
end)

generate("sky_island_corner", {
    ",,,,,,,,,,,,,,,,,,,,,,,,",
    ",,,,,...................",
    ",,,...                  ",
    ",,..                    ",
    ",,.                     ",
    ",..                     ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
}, {
    [" "] = "t_grass",
    ["."] = "t_fake_air",
    [","] = "t_open_air",
})

generate("sky_island_edge", {
    ",,,,,,,,,,,,,,,,,,,,,,,,",
    "........................",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
}, {
    [" "] = "t_grass",
    ["."] = "t_fake_air",
    [","] = "t_open_air",
})

local solid_stone = {}
for y = 1, 24 do solid_stone[y] = string.rep(" ", 24) end

generate("sky_island_subcore", solid_stone, {
    [" "] = "t_warprock",
})

generate("sky_island_subcorner", {
    ",,,,,,,,,,,,,,,,,,,,,,,,",
    ",,,,,...................",
    ",,,...                  ",
    ",,..                    ",
    ",,.                     ",
    ",..                     ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
    ",.                      ",
}, {
    [" "] = "t_warprock",
    ["."] = "t_open_air",
    [","] = "t_open_air",
})

generate("sky_island_subedge", {
    ",,,,,,,,,,,,,,,,,,,,,,,,",
    "........................",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
    "                        ",
}, {
    [" "] = "t_warprock",
    ["."] = "t_open_air",
    [","] = "t_open_air",
})

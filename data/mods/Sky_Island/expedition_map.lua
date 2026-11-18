local ccb = require("ccb")
local mapgen = ccb.services.mapgen
local M = {}
local marked = ccb.content.text("Marked")
local encounter_range = { 1, 22 }

local function stamp(rows, terrain, furniture)
    local layout = mapgen.patch()
    layout:erase_before_terrain()
    for y, row in ipairs(rows) do
        for x = 1, #row do
            local key = row:sub(x, x)
            if terrain[key] then layout:terrain(x - 1, y - 1, terrain[key]) end
            if furniture[key] then layout:furniture(x - 1, y - 1, furniture[key]) end
        end
    end
    local patch = mapgen.patch()
    patch:stamp(layout, { 0, 13 }, { 0, 13 })
    return patch
end

local function marked_group(patch, group, repetitions, pack_size)
    patch:spawn_group(group, encounter_range, encounter_range, {
        repetitions = repetitions,
        pack_size = pack_size,
        mission_target = true,
        name = marked,
    })
end

function M.reach_extract()
    return stamp({
        "  -     -  ",
        " ----D---- ",
        "--.......--",
        " -.......- ",
        " -.......- ",
        " D...X...D ",
        " -.......- ",
        " -.......- ",
        "--.......--",
        " ----D---- ",
        "  -     -  ",
    },
        { ["D"] = "t_door_c", ["-"] = "t_wall_r_glow", ["."] = "t_carpet_red", ["X"] = "t_carpet_red", ["x"] = "t_carpet_red" },
        { ["X"] = "f_returnportal" })
end

function M.treasure()
    return stamp({
        "  x  ",
        " xxx ",
        "xxoxx",
        " xxx ",
        "  x  ",
    },
        { ["x"] = "t_carpet_green", ["o"] = "t_carpet_purple" },
        { ["o"] = "f_warpshardrewardstatue" })
end

function M.kill_light()
    local patch = mapgen.patch()
    marked_group(patch, "GROUP_SI_ZOMEASY", { 4, 8 })
    return patch
end

function M.kill_horde()
    local patch = mapgen.patch()
    marked_group(patch, "GROUP_SI_ZOMEASY", { 8, 24 })
    return patch
end

function M.kill_mid()
    local patch = mapgen.patch()
    marked_group(patch, "GROUP_SI_ZOMEASY", { 0, 4 })
    marked_group(patch, "GROUP_SI_ZOMMID", { 3, 8 })
    return patch
end

function M.kill_mid_horde()
    local patch = mapgen.patch()
    marked_group(patch, "GROUP_SI_ZOMEASY", { 0, 6 })
    marked_group(patch, "GROUP_SI_ZOMMID", { 8, 20 })
    return patch
end

function M.kill_hard()
    local patch = mapgen.patch()
    marked_group(patch, "GROUP_SI_ZOMEASY", { 0, 4 })
    marked_group(patch, "GROUP_SI_ZOMMID", { 0, 2 })
    marked_group(patch, "GROUP_SI_ZOMHARD", { 4, 8 })
    return patch
end

function M.kill_elite()
    local patch = mapgen.patch()
    marked_group(patch, "GROUP_SI_ZOMMID", { 0, 2 })
    marked_group(patch, "GROUP_SI_ZOMHARD", { 0, 1 })
    marked_group(patch, "GROUP_SI_ZOMELITE", { 4, 8 })
    return patch
end

function M.kill_boss()
    local patch = mapgen.patch()
    marked_group(patch, "GROUP_SI_ZOMBOSS")
    return patch
end

function M.kill_boss_multi()
    local patch = mapgen.patch()
    marked_group(patch, "GROUP_SI_ZOMBOSS", nil, { 2, 5 })
    return patch
end

function M.kill_boss_group()
    local patch = mapgen.patch()
    marked_group(patch, "GROUP_SI_ZOMBOSS")
    marked_group(patch, "GROUP_SI_ZOMELITE", { 2, 5 })
    return patch
end

function M.kill_boss_horde()
    local patch = mapgen.patch()
    marked_group(patch, "GROUP_SI_ZOMBOSS")
    marked_group(patch, "GROUP_SI_ZOMEASY", { 10, 22 })
    return patch
end

function M.kill_migo()
    local patch = mapgen.patch()
    marked_group(patch, "GROUP_SI_MIGO", { 2, 5 })
    return patch
end

function M.kill_migo_elite()
    local patch = mapgen.patch()
    marked_group(patch, "GROUP_SI_MIGO", { 0, 2 })
    marked_group(patch, "GROUP_SI_MIGO_ELITE")
    return patch
end

function M.assassin1()
    local patch = mapgen.patch()
    patch:spawn_npc("bandit", encounter_range, encounter_range, 1, true)
    return patch
end

function M.assassin2()
    local patch = mapgen.patch()
    patch:spawn_npc("thug", encounter_range, encounter_range, 1, true)
    return patch
end

function M.assassin3()
    local patch = mapgen.patch()
    patch:spawn_npc("thug", encounter_range, encounter_range, { 1, 2 }, true)
    patch:spawn_npc("bandit", encounter_range, encounter_range, { 0, 1 }, true)
    patch:spawn_npc("bandit", encounter_range, encounter_range, 1, true)
    return patch
end

return M

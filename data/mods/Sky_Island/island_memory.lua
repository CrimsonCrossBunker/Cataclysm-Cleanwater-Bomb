local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")
local M = {}

local locations = {
    { "OM_island_center", 0, 0, 0 },
    { "OM_island_nw", -1, -1, 0 },
    { "OM_island_n", 0, -1, 0 },
    { "OM_island_ne", 1, -1, 0 },
    { "OM_island_w", -1, 0, 0 },
    { "OM_island_e", 1, 0, 0 },
    { "OM_island_sw", -1, 1, 0 },
    { "OM_island_s", 0, 1, 0 },
    { "OM_island_se", 1, 1, 0 },
    { "OM_island_subcenter", 0, 0, -1 },
    { "OM_island_subnw", -1, -1, -1 },
    { "OM_island_subn", 0, -1, -1 },
    { "OM_island_subne", 1, -1, -1 },
    { "OM_island_subw", -1, 0, -1 },
    { "OM_island_sube", 1, 0, -1 },
    { "OM_island_subsw", -1, 1, -1 },
    { "OM_island_subs", 0, 1, -1 },
    { "OM_island_subse", 1, 1, -1 },
}

function M.remember(character)
    for _, location in ipairs(locations) do
        -- Each native location action searches independently, including its map load.
        local offset
        if location[2] ~= 0 or location[3] ~= 0 or location[4] ~= 0 then
            offset = services.coords.tripoint_rel_omt(location[2], location[3], location[4])
        end
        local target = services.overmap.find_target(state.position(character):project_to("omt"),
            { terrain = "sky_island_core", match = services.enums.value("OtMatchType", "CONTAINS") },
            { offset = offset })
        local found = services.world.find_location(target:project_to("ms"))
        if found.found then state.set(location[1], found.position) end
    end
end

return M

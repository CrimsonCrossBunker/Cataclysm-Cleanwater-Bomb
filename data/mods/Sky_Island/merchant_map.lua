local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")
local M = {}

local templates = {
    "si_exodii_cbm_merchant",
    "si_human_ammo_merchant",
    "si_triffid_decor_merchant",
}

local function update(patch)
    local position = state.point("OM_island_n"):project_to("omt")
    local target = state.checked(services.overmap.tile_token(position))
    state.checked(services.mapgen.run_update(target, patch))
end

function M.place(choice)
    local template = templates[choice]
    local patch = services.mapgen.patch()
    patch:spawn_npc(template, 12, 10, { unique_id = template })
    update(patch)
end

function M.clear()
    for _, template in ipairs(templates) do
        local patch = services.mapgen.patch()
        patch:remove_npc(template, template)
        update(patch)
    end
    local patch = services.mapgen.patch()
    patch:clear_items(11, 9, 13, 11)
    update(patch)
end

return M

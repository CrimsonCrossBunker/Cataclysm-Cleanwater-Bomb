local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local items = services.items

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function collect_slot_items(character, slot, recursive, out)
    local holder = { kind = "character", character = character, slot = slot }
    local options = { page_size = 256, recursive = recursive }
    local page = value(items.page(holder, options))
    while true do
        for _, entry in ipairs(page.items) do
            out[#out + 1] = entry.handle
        end
        if not page.continuation then
            break
        end
        page = value(items.page(holder, options, page.continuation))
    end
end

local subsumed_armor_flags = {
    "SHAPESHIFTED_ARMOR",
    "SEMITANGIBLE",
    "UNRESTRICTED",
    "INTANGIBLE_ARMOR",
    "UNBREAKABLE",
}

local function item_has_flag(item_handle, flag_name)
    return value(items.has_flag(item_handle, id("json_flag", flag_name)))
end

-- Collect all handles across pages before mutating flags so holder cursors stay valid.
local function subsume_worn_armor(character)
    local worn = {}
    collect_slot_items(character, "worn", false, worn)
    for _, handle in ipairs(worn) do
        if not item_has_flag(handle, "SEMITANGIBLE")
            and not item_has_flag(handle, "UNRESTRICTED")
            and not item_has_flag(handle, "INTEGRATED")
        then
            for _, flag_name in ipairs(subsumed_armor_flags) do
                value(items.set_flag(handle, id("json_flag", flag_name), true))
            end
        end
    end
end

local function return_subsumed_armor(character)
    local all_items = {}
    for _, slot in ipairs({ "worn", "wielded", "inventory" }) do
        collect_slot_items(character, slot, true, all_items)
    end
    for _, handle in ipairs(all_items) do
        if item_has_flag(handle, "SHAPESHIFTED_ARMOR") then
            for _, flag_name in ipairs(subsumed_armor_flags) do
                value(items.set_flag(handle, id("json_flag", flag_name), false))
            end
        end
    end
end

return {
    subsume = subsume_worn_armor,
    restore = return_subsumed_armor,
}

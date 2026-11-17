local ccb = require("ccb")
local services = ccb.services

local difficulty = {}
local setting = "NH_item_difficulty"
local categories = {
    "guns", "magazines", "ammo", "weapons", "tools", "clothing", "food", "drugs",
    "manuals", "books", "mods", "veh_parts", "other", "fuel", "spare_parts",
    "tool_magazine", "armor",
}
local rare_categories = { ammo = true, food = true, drugs = true }
local levels = {
    {
        label = function() return ccb.services.translate("Creeping Despair") end,
        description = function()
            return ccb.services.translate("Creeping Despair makes items rarer than vanilla.")
        end,
        notice = function() return ccb.services.translate("A creeping sense of despair approaches…") end,
        rate = 0.6,
        rare_rate = 0.4,
    },
    {
        label = function() return ccb.services.translate("Fervent Despair") end,
        description = function()
            return ccb.services.translate("Fervent Despair makes items rarer than Creeping Despair.")
        end,
        notice = function() return ccb.services.translate("An intense sensation of despair fills you…") end,
        rate = 0.4,
        rare_rate = 0.3,
    },
    {
        label = function() return ccb.services.translate("Overwhelming Despair") end,
        description = function()
            return ccb.services.translate("Overwhelming Despair makes items rarer than Fervent Despair.")
        end,
        notice = function() return ccb.services.translate("You are overcome by despair…") end,
        rate = 0.2,
        rare_rate = 0.1,
    },
}

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function apply_level(index, chosen)
    local level = levels[index]
    if chosen then
        services.message(level.notice())
    end
    if index == 2 then
        services.message(ccb.services.translate("Difficulty set to Harder."))
    end
    local updates = {}
    for _, id in ipairs(categories) do
        updates[#updates + 1] = {
            id = services.types.id("item_category", id),
            spawn_rate = rare_categories[id] and level.rare_rate or level.rate,
        }
    end
    checked(services.item_categories.set_spawn_rates(updates))
    if chosen or index == 2 then
        checked(services.variables.set_global(setting, index - 1, { include_before = false }))
    end
end

function difficulty.choose()
    local entries = {}
    for index, level in ipairs(levels) do
        local key = tostring(index)
        entries[index] = { id = key, hotkey = key, label = level.label(), description = level.description() }
    end
    local selected = services.interaction.choose(entries, {
        title = ccb.services.translate("Select a difficulty"),
        allow_cancel = false,
    })
    if selected.accepted then
        apply_level(selected.index, true)
    end
end

ccb.runtime.handler("initialize_item_difficulty", function()
    local current = checked(services.variables.get_global_number(setting, { strict = true }))
    if not current.exists then
        difficulty.choose()
    elseif current.value >= 0 then
        -- The previous selector used the last threshold not greater than the saved value.
        local index = math.floor(math.min(current.value, #levels - 1)) + 1
        apply_level(index, false)
    end
end, 1)
ccb.runtime.on("game:game_start", "initialize_item_difficulty")
ccb.runtime.on("game:game_load", "initialize_item_difficulty")

return difficulty

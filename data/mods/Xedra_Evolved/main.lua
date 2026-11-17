local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

if content.is_mod_active("classic_zombies") then
    local allowed = content.Blacklist { kind = "monster", whitelist = true, exclusive = true }
    allowed:category("XE_CLASSIC")
    content.add(allowed)
end

local variables = services.variables

-- The remaining inventor scripts read these names from the world save.
local starting_difficulties = {
    { "base_difficulty_1", 2 },
    { "base_difficulty_2", 3 },
    { "base_difficulty_3", 4 },
    { "energy_difficulty_1", 2 },
    { "energy_difficulty_2", 3 },
    { "energy_difficulty_3", 4 },
    { "AI_difficulty_1", 5 },
    { "dimension_difficulty_1", 5 },
}

local function set_starting_variable(key, value)
    local result = variables.set_global(key, value, { include_before = false })
    if not result.ok then
        error(result.error.message)
    end
end

ccb.runtime.handler("initialize_inventor_difficulty", function()
    local initialized = variables.get_global_number("XE_INITIALIZATION", { strict = true })
    if not initialized.ok then
        error(initialized.error.message)
    end
    if initialized.value.value == 1 then
        return
    end

    for _, variable in ipairs(starting_difficulties) do
        set_starting_variable(variable[1], variable[2])
    end
    set_starting_variable("XE_INITIALIZATION", 1)
end, 1)
ccb.runtime.on("game:game_begin", "initialize_inventor_difficulty")

ccb.runtime.handler("initialize_encounter_timer", function()
    local result = variables.set(services.characters.avatar(), "timer_xe_RandEnc",
        services.time_snapshot().turn, { include_before = false })
    if not result.ok then
        error(result.error.message)
    end
end, 1)
ccb.runtime.on("game:game_start", "initialize_encounter_timer")

require("character_start")
require("consumables")
require("vampire_diet")
require("vampire_weakness_messages")
require("vampire_weakness_reshuffle")
require("anathema_sunlight")
require("anathema_progression")
require("vampire_infection")
require("vampire_ascension")
if content.is_mod_active("skyisland") then
    require("mod_interactions.skyisland.vampire_amplifiers")
end

require("nested_recipes")

require("morale_types")

require("flags")
require("monster_flags")

require("speech")

require("ammunition_types")

require("ammo_effects")
require("monster_attacks")

require("tool_qualities")

require("vitamins")

require("snippets")

require("conditional_enchantments")

require("enchantments")

require("enchantment_values")

require("enchantments_character_state")

require("enchantment_variables")

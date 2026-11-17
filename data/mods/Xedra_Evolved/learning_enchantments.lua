local ccb = require("ccb")
local content = ccb.content

local function modern_technology_ignorance(id, skill, proficiency, exemption, effect)
    local handler = id .. "_active"
    ccb.runtime.handler(handler, function(ctx)
        local state = ctx.character_inputs
        return state.proficiency_percentages[proficiency] < 100
            and (exemption == nil or not state.traits[exemption])
    end)
    local enchantment = content.Enchantment {
        id = id,
        condition_handler = handler,
        load_character_inputs = { proficiency_percentages = { proficiency }, traits = { exemption } },
    }:skill(skill, { multiply = -1 })
    if effect then
        enchantment:effect(effect, 1)
    end
    content.add(enchantment)
end

local computer_proficiency = "prof_paraclesian_computer_understanding"
local electronics_proficiency = "prof_paraclesian_electronics_understanding"
local cannot_use_computers = "effect_paraclesian_cannot_use_computers_flag"
modern_technology_ignorance("ench_paraclesian_modern_technology_computer_ignorance",
    "computer", computer_proficiency, nil, cannot_use_computers)
modern_technology_ignorance("ench_paraclesian_modern_technology_electronics_ignorance",
    "electronics", electronics_proficiency)
modern_technology_ignorance("ench_paraclesian_homullus_modern_technology_computer_ignorance",
    "computer", computer_proficiency, "HOMULLUS_CAN_USE_COMPUTERS", cannot_use_computers)
modern_technology_ignorance("ench_paraclesian_homullus_modern_technology_electronics_ignorance",
    "electronics", electronics_proficiency, "HOMULLUS_CAN_USE_ELECTRONICS")

ccb.runtime.handler("sylph_fulgurating_strikes_advanced_active", function(ctx)
    local spells = ctx.character_inputs.spell_levels
    return spells.sylph_call_lightning >= 10 or spells.sylph_crash_of_lightning >= 5
end)

content.add(content.Enchantment {
    id = "ench_sylph_fulgurating_strikes_advanced",
    condition_handler = "sylph_fulgurating_strikes_advanced_active",
    load_character_inputs = { spell_levels = { "sylph_call_lightning", "sylph_crash_of_lightning" } },
}:hit_you({ id = "sylph_fulgurating_strikes_lightning_fields", self = false, trigger_once_in = 3 }))

ccb.runtime.handler("sylph_shout_multiplier", function(ctx)
    return 1 + ctx.character_inputs.spell_school_level_sums.SYLPH / 20
end)

content.add(content.Enchantment {
    id = "ench_sylph_louder_shouting",
    condition = "ACTIVE",
    load_character_inputs = { spell_school_level_sums = { "SYLPH" } },
}:value("SHOUT_NOISE", { multiply_handler = "sylph_shout_multiplier" }))

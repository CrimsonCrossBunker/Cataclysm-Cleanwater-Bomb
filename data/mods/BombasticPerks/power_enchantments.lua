local ccb = require("ccb")
local content = ccb.content

local drug_effects = {
    "jetinjector",
    "stimpack",
    "adrenaline",
    "meth",
    "cig",
    "high",
    "weed_high",
    "drunk",
    "betablock",
    "stim",
    "stim_overdose",
    "datura",
}

local function drug_bonus(ctx)
    local bonus = 0
    for _, effect in ipairs(drug_effects) do
        if ctx.character_inputs.effect_intensities[effect] > 0 then
            bonus = bonus + 3
        end
    end
    return bonus
end

-- perks.json
ccb.runtime.handler("power_enchantment_inline_ench_perk_speedballing_0_value_0_add", function(ctx)
    return drug_bonus(ctx)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_speedballing_0", condition = "ALWAYS",
    load_character_inputs = {
        effect_intensities = {
            "adrenaline",
            "betablock",
            "cig",
            "datura",
            "drunk",
            "high",
            "jetinjector",
            "meth",
            "stim",
            "stim_overdose",
            "stimpack",
            "weed_high"
        }
    },
    native_modifier_order = true,
}
    :value("SPEED", {
        add_handler = "power_enchantment_inline_ench_perk_speedballing_0_value_0_add",
        load_skills = {}
    }))

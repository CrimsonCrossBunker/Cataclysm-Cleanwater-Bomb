local ccb = require("ccb")
local content = ccb.content

local random = ccb.services.random

local function clamp(value, minimum, maximum)
    return math.min(math.max(value, minimum), maximum)
end

local function native_random(maximum)
    local rounded = maximum < 0 and math.ceil(maximum - 0.5) or math.floor(maximum + 0.5)
    return random.native_int(math.min(0, rounded), math.max(0, rounded))
end

-- mod_interactions/bombastic_perks/perks/perks.json
ccb.runtime.handler("interaction_enchantment_inline_ench_perk_low_int_mana_0_value_0_add", function(ctx)
    return ((16 - clamp(ctx.character_inputs.stats.intelligence, 8, 16)) * 62.5)
end)

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_perk_LOW_INT_MANA_0", condition = "ALWAYS",
    load_character_inputs = { stats = true },
    native_modifier_order = true,
}
    :value("MAX_MANA", {
        add_handler = "interaction_enchantment_inline_ench_perk_low_int_mana_0_value_0_add",
        load_skills = {}
    }))

ccb.runtime.handler("interaction_enchantment_inline_ench_perk_xe_vampire_killer_0_melee_damage_0_add", function(ctx)
    return random.native_float(2, 10)
end)

ccb.runtime.handler("interaction_enchantment_inline_ench_perk_xe_vampire_killer_0_melee_damage_1_add", function(ctx)
    return random.native_float(25, 35)
end)

ccb.runtime.handler("interaction_enchantment_inline_ench_perk_xe_vampire_killer_0_melee_damage_2_add", function(ctx)
    return native_random(1)
end)

ccb.runtime.handler("interaction_enchantment_active_inline_ench_perk_xe_vampire_killer_0", function(ctx)
    return (ctx.character_inputs.wielded_flags["WHIP"] and
        ((ctx.character_inputs.nearby_monsters["monsters_1"] >= 1) or
        (ctx.character_inputs.nearby_monsters["monsters_2"] >= 1)))
end)

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_perk_xe_vampire_killer_0",
    condition_handler = "interaction_enchantment_active_inline_ench_perk_xe_vampire_killer_0",
    load_character_inputs = {
        nearby_monsters = {
            monsters_1 = {
                attitude = "both",
                radius = 3,
                species = { "RENFIELD" }
            },
            monsters_2 = {
                attitude = "both",
                radius = 3,
                species = { "VAMPIRE" }
            }
        },
        wielded_flags = { "WHIP" }
    },
    native_modifier_order = true,
}
    :value("WEAKPOINT_ACCURACY", { multiply = 2.5 })
    :melee_damage("bash", {
        add_handler = "interaction_enchantment_inline_ench_perk_xe_vampire_killer_0_melee_damage_0_add",
        load_skills = {}
    })
    :melee_damage("cut", {
        add_handler = "interaction_enchantment_inline_ench_perk_xe_vampire_killer_0_melee_damage_1_add",
        load_skills = {}
    })
    :melee_damage("heat", {
        add_handler = "interaction_enchantment_inline_ench_perk_xe_vampire_killer_0_melee_damage_2_add",
        load_skills = {}
    }))

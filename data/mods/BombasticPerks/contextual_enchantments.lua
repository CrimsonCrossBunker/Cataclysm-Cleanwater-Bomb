local ccb = require("ccb")
local content = ccb.content

local random = ccb.services.random

local function native_random(maximum)
    local rounded = maximum < 0 and math.ceil(maximum - 0.5) or math.floor(maximum + 0.5)
    return random.native_int(math.min(0, rounded), math.max(0, rounded))
end

-- perks.json
ccb.runtime.handler("contextual_enchantment_active_inline_ench_perk_bedtime_reader_0", function(ctx)
    return (((ctx.character_inputs.environment.turns_since_midnight / 3600) >= 20) or
        ((ctx.character_inputs.environment.turns_since_midnight / 3600) <= 1))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_bedtime_reader_0",
    condition_handler = "contextual_enchantment_active_inline_ench_perk_bedtime_reader_0",
    load_character_inputs = { environment = { turns_since_midnight = true } },
    native_modifier_order = true,
}
    :value("READING_SPEED_MULTIPLIER", { multiply = -0.5 }))

ccb.runtime.handler("contextual_enchantment_active_inline_ench_perk_static_stockpile_0", function(ctx)
    return ((ctx.character_inputs.environment.outside and
        (ctx.character_inputs.environment.weather == "lightning" or
        ctx.character_inputs.environment.weather == "thunder")) or
        (ctx.character_inputs.nearby_monsters["monsters_1"] > 0))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_static_stockpile_0",
    condition_handler = "contextual_enchantment_active_inline_ench_perk_static_stockpile_0",
    load_character_inputs = {
        environment = { outside = true, weather = true },
        nearby_monsters = {
            monsters_1 = {
                attitude = "hostile",
                radius = 15,
                types = {
                    "mon_zombie_brute_shocker",
                    "mon_zombie_electric",
                    "mon_skeleton_electric",
                    "mon_frog_shocker",
                    "mon_zombie_static",
                    "mon_amalgamation_zapper",
                    "mon_zombie_nullfield",
                    "mon_exodii_worker",
                    "mon_exodii_quad",
                    "mon_zomborg",
                    "mon_zomborg_devourer",
                    "mon_robofac_skittergun",
                    "mon_EMP_hack",
                    "mon_c4_hack",
                    "mon_flashbang_hack",
                    "mon_gasbomb_hack",
                    "mon_grenade_hack",
                    "mon_manhack",
                    "exodii_sniper_drone",
                    "mon_tazer_hack",
                    "mon_lab_security_drone_GM",
                    "mon_lab_security_drone_YM",
                    "mon_lab_security_drone_BM",
                    "mon_lab_security_drone_BM2",
                    "mon_lab_security_drone_GR",
                    "mon_lab_security_drone_BS",
                    "mon_secubot",
                    "mon_talon_m202a1",
                    "mon_secubot_america",
                    "mon_skitterbot",
                    "mon_science_bot",
                    "mon_robofac_prototype",
                    "mon_dispatch",
                    "mon_dispatch_military"
                }
            }
        }
    },
    native_modifier_order = true,
}
    :value("POWER_TRICKLE", { add = 500000 })
    :melee_damage("electric", { add = 3 }))

ccb.runtime.handler("contextual_enchantment_active_inline_ench_perk_fencing_footwork_0", function(ctx)
    return ctx.character_inputs.wielded_categories["FENCING_WEAPONRY"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_fencing_footwork_0",
    condition_handler = "contextual_enchantment_active_inline_ench_perk_fencing_footwork_0",
    load_character_inputs = { wielded_categories = { "FENCING_WEAPONRY" } },
    native_modifier_order = true,
}
    :value("BONUS_DODGE", { add = 1 })
    :value("MOVECOST_FLATGROUND_MOD", { multiply = -0.05 }))

ccb.runtime.handler("contextual_enchantment_inline_ench_perk_artifact_resonance_exploitation_0_value_0_add", function(ctx)
    return native_random(1)
end)

ccb.runtime.handler("contextual_enchantment_inline_ench_perk_artifact_resonance_exploitation_0_value_1_multiply", function(ctx)
    return random.native_float(0.1, 0.3)
end)

ccb.runtime.handler("contextual_enchantment_inline_ench_perk_artifact_resonance_exploitation_0_value_2_multiply", function(ctx)
    return random.native_float(0, 0.1)
end)

ccb.runtime.handler("contextual_enchantment_inline_ench_perk_artifact_resonance_exploitation_0_value_3_multiply", function(ctx)
    return random.native_float((-0.05), 0)
end)

ccb.runtime.handler("contextual_enchantment_inline_ench_perk_artifact_resonance_exploitation_0_value_4_multiply", function(ctx)
    return random.native_float((-0.15), 0)
end)

ccb.runtime.handler("contextual_enchantment_inline_ench_perk_artifact_resonance_exploitation_0_incoming_damage_0_add", function(ctx)
    return (native_random(8) + 2)
end)

ccb.runtime.handler("contextual_enchantment_inline_ench_perk_artifact_resonance_exploitation_0_incoming_damage_1_add", function(ctx)
    return (native_random(8) + 2)
end)

ccb.runtime.handler("contextual_enchantment_inline_ench_perk_artifact_resonance_exploitation_0_incoming_damage_2_add", function(ctx)
    return (native_random(8) + 2)
end)

ccb.runtime.handler("contextual_enchantment_active_inline_ench_perk_artifact_resonance_exploitation_0", function(ctx)
    return (ctx.character_inputs.artifact_resonance > 2000)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_artifact_resonance_exploitation_0",
    condition_handler = "contextual_enchantment_active_inline_ench_perk_artifact_resonance_exploitation_0",
    load_character_inputs = { artifact_resonance = true },
    native_modifier_order = true,
}
    :value("BONUS_DODGE", {
        add_handler = "contextual_enchantment_inline_ench_perk_artifact_resonance_exploitation_0_value_0_add",
        load_skills = {}
    })
    :value("REGEN_STAMINA", {
        multiply_handler = "contextual_enchantment_inline_ench_perk_artifact_resonance_exploitation_0_value_1_multiply",
        load_skills = {}
    })
    :value("FORCEFIELD", {
        multiply_handler = "contextual_enchantment_inline_ench_perk_artifact_resonance_exploitation_0_value_2_multiply",
        load_skills = {}
    })
    :value("MOVE_COST", {
        multiply_handler = "contextual_enchantment_inline_ench_perk_artifact_resonance_exploitation_0_value_3_multiply",
        load_skills = {}
    })
    :value("PAIN", {
        multiply_handler = "contextual_enchantment_inline_ench_perk_artifact_resonance_exploitation_0_value_4_multiply",
        load_skills = {}
    })
    :incoming_damage("heat", {
        add_handler = "contextual_enchantment_inline_ench_perk_artifact_resonance_exploitation_0_incoming_damage_0_add",
        load_skills = {}
    })
    :incoming_damage("electric", {
        add_handler = "contextual_enchantment_inline_ench_perk_artifact_resonance_exploitation_0_incoming_damage_1_add",
        load_skills = {}
    })
    :incoming_damage("cold", {
        add_handler = "contextual_enchantment_inline_ench_perk_artifact_resonance_exploitation_0_incoming_damage_2_add",
        load_skills = {}
    }))

ccb.runtime.handler("contextual_enchantment_active_inline_ench_perk_eating_window_0", function(ctx)
    return (((ctx.character_inputs.environment.turns_since_midnight / 3600) >= 12) and
        ((ctx.character_inputs.environment.turns_since_midnight / 3600) <= 18))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_eating_window_0",
    condition_handler = "contextual_enchantment_active_inline_ench_perk_eating_window_0",
    load_character_inputs = { environment = { turns_since_midnight = true } },
    native_modifier_order = true,
}
    :value("KCAL", { multiply = 1.5 })
    :value("VITAMIN_ABSORB_MOD", { multiply = 1.5 }))

ccb.runtime.handler("contextual_enchantment_active_inline_ench_perk_eating_window_1", function(ctx)
    return (((ctx.character_inputs.environment.turns_since_midnight / 3600) < 12) or
        ((ctx.character_inputs.environment.turns_since_midnight / 3600) > 18))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_eating_window_1",
    condition_handler = "contextual_enchantment_active_inline_ench_perk_eating_window_1",
    load_character_inputs = { environment = { turns_since_midnight = true } },
    native_modifier_order = true,
}
    :value("KCAL", { multiply = -50 })
    :value("VITAMIN_ABSORB_MOD", { multiply = -50 }))

ccb.runtime.handler("contextual_enchantment_active_inline_ench_perk_gunslinger_0", function(ctx)
    return ctx.character_inputs.wielded_skills["pistol"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_gunslinger_0",
    condition_handler = "contextual_enchantment_active_inline_ench_perk_gunslinger_0",
    load_character_inputs = { wielded_skills = { "pistol" } },
    native_modifier_order = true,
}
    :value("AIMING_SPEED", { multiply = 0.75 })
    :value("RELOADING_SPEED", { multiply = -0.45 }))

ccb.runtime.handler("contextual_enchantment_active_inline_ench_revolvers_are_cool_0", function(ctx)
    return (ctx.character_inputs.wielded_flags["RELOAD_ONE"] and
        ctx.character_inputs.wielded_skills["pistol"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_revolvers_are_cool_0",
    condition_handler = "contextual_enchantment_active_inline_ench_revolvers_are_cool_0",
    load_character_inputs = { wielded_flags = { "RELOAD_ONE" }, wielded_skills = { "pistol" } },
    native_modifier_order = true,
}
    :value("WEAPON_DISPERSION", { multiply = -0.25 })
    :value("RANGED_DAMAGE", { add = 6 })
    :value("RANGE", { add = 4 }))

ccb.runtime.handler("contextual_enchantment_active_inline_ench_22_is_cool_0", function(ctx)
    return ctx.character_inputs.wielded_ammunition["22"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_22_is_cool_0",
    condition_handler = "contextual_enchantment_active_inline_ench_22_is_cool_0",
    load_character_inputs = { wielded_ammunition = { "22" } },
    native_modifier_order = true,
}
    :value("RANGED_ARMOR_PENETRATION", { add = 5 })
    :value("WEAKPOINT_ACCURACY", { multiply = 3 }))

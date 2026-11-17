local ccb = require("ccb")
local content = ccb.content

-- Definition IDs keep bionic enchantments independent of the display language.

-- data/json/bionics.json

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_alarm_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("MOTION_ALARM", { add = 5 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_climate_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("CLIMATE_CONTROL_HEAT", { add = 50 })
    :value("CLIMATE_CONTROL_CHILL", { add = 50 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_cloak_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :effect("invisibility", 1))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_dex_enhancer_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("DEXTERITY", { add = 2 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_dex_enhancer_1", condition = "INACTIVE",
    native_modifier_order = true,
}
    :value("DEXTERITY", { add = -1 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_digestion_0",
    native_modifier_order = true,
}
    :value("KCAL", { multiply = 0.5 })
    :value("VITAMIN_ABSORB_MOD", { multiply = 0.5 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_ears_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("HEARING_MULT", { multiply = 2.5 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_voice_b_0",
    native_modifier_order = true,
}
    :value("SHOUT_NOISE", { add = 25 })
    :value("SHOUT_NOISE_STR_MULT", { add = 2 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_eye_enhancer_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("PERCEPTION", { add = 2 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_eye_enhancer_1", condition = "INACTIVE",
    native_modifier_order = true,
}
    :value("PERCEPTION", { add = -1 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_flashlight_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("LUMINATION", { add = 60 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_flashlight_highmode_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("LUMINATION", { add = 500 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_tattoo_led_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("LUMINATION", { add = 5 }))

ccb.runtime.handler("bionic_ground_sonar_detect", function(ctx)
    return (ctx.target_inputs.flags.DIGS or (ctx.target_inputs.divable and ctx.target_inputs.flags.CAN_DIG))
end)

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_ground_sonar_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :vision({
        condition_handler = "bionic_ground_sonar_detect",
        target_inputs = {
            flags = { "DIGS", "CAN_DIG" },
            divable = true
        },
        distance = 20,
        descriptions = {
            {
                id = "ground_sonar_sense",
                color = "c_green",
                symbol = "?",
                text = content.text("You sense some creature moving underground here.")
            }
        }
    }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_hydraulics_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :effect("bio_hydraulics_eff", 1))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_int_enhancer_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("INTELLIGENCE", { add = 2 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_int_enhancer_1", condition = "INACTIVE",
    native_modifier_order = true,
}
    :value("INTELLIGENCE", { add = -1 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_leukocyte_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("EFFECTIVE_HEALTH_MOD", { add = 100 })
    :value("MOD_HEALTH", { add = -50 })
    :value("MOD_HEALTH_CAP", { add = -200 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_memory_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("READING_EXP", { add = 2 })
    :value("SKILL_RUST_RESIST", { add = 20 })
    :value("LEARNING_FOCUS", { add = 10 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_night_0", emitter = "emit_shadow_field", condition = "ACTIVE",
    native_modifier_order = true,
})

ccb.runtime.handler("bionic_ench_bio_razors_0_active", function(ctx)
    return not (ctx.character_inputs.armed)
end)

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_razors_0",
    condition_handler = "bionic_ench_bio_razors_0_active",
    load_character_inputs = { armed = true },
    native_modifier_order = true,
}
    :melee_damage("stab", { add = 2 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_recycler_0", condition = "ALWAYS",
    native_modifier_order = true,
}
    :value("HUNGER", { multiply = -0.5 })
    :value("THIRST", { multiply = -0.5 })
    :value("METABOLISM", { multiply = -0.5 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_speed_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("SPEED", { multiply = 0.1 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_str_enhancer_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("STRENGTH", { add = 2 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_str_enhancer_1", condition = "INACTIVE",
    native_modifier_order = true,
}
    :value("STRENGTH", { add = -1 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_synlungs_0", condition = "ALWAYS",
    native_modifier_order = true,
}
    :value("MOD_HEALTH", { add = -1 })
    :value("MOD_HEALTH_CAP", { add = -10 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_targeting_0", condition = "ALWAYS",
    native_modifier_order = true,
}
    :value("WEAPON_DISPERSION", { multiply = -0.25 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_jointservo_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("MOVE_COST", { multiply = -0.1 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_jointservo_1", condition = "INACTIVE",
    native_modifier_order = true,
}
    :value("MOVE_COST", { multiply = 0.1 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_weight_0",
    native_modifier_order = true,
}
    :value("CARRY_WEIGHT", { add = 20000 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_soporific_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("SLEEPY", { add = 30 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_recoil_0", condition = "ALWAYS",
    native_modifier_order = true,
}
    :value("RECOIL_MODIFIER", { multiply = -0.35 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_betavoltaic_0",
    native_modifier_order = true,
}
    :value("POWER_TRICKLE", { add = 1000 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_pitch_perfect_0", condition = "ALWAYS",
    native_modifier_order = true,
}
    :value("THROW_STR", { multiply = 0.5 })
    :value("THROW_DAMAGE", { multiply = 0.25 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_nl_laser_reader_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("READING_SPEED_MULTIPLIER", { multiply = -0.2 })
    :value("LUMINATION", { add = 10 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_exodii_cyberframe_1a_0",
    native_modifier_order = true,
}
    :value("STRENGTH", { add = 4 })
    :value("DEXTERITY", { add = 4 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_exodii_cyberframe_1a_1",
    native_modifier_order = true,
}
    :mutation("EXODII_CYBERFRAME_LARGE"))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_exodii_leg_bionic_basic_armored_left_0",
    native_modifier_order = true,
}
    :bodypart_change("leg_bionic_basic_l", "")
    :bodypart_change("foot_bionic_basic_l", ""))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_exodii_leg_bionic_basic_armored_right_0",
    native_modifier_order = true,
}
    :bodypart_change("leg_bionic_basic_r", "")
    :bodypart_change("foot_bionic_basic_r", ""))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_exodii_leg_bionic_treads_0",
    native_modifier_order = true,
}
    :bodypart_change("bionic_treads_leg", ""))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_exodii_leg_bionic_treads_1",
    native_modifier_order = true,
}
    :value("MOVECOST_OBSTACLE_MOD", { multiply = 6 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_exodii_arm_bionic_basic_armored_left_0",
    native_modifier_order = true,
}
    :bodypart_change("arm_bionic_basic_l", "")
    :bodypart_change("hand_bionic_basic_l", ""))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_exodii_arm_bionic_basic_armored_right_0",
    native_modifier_order = true,
}
    :bodypart_change("arm_bionic_basic_r", "")
    :bodypart_change("hand_bionic_basic_r", ""))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_exodii_cyberframe_1b_0",
    native_modifier_order = true,
}
    :value("STRENGTH", { add = 2 })
    :value("DEXTERITY", { add = 4 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_exodii_leg_bionic_basic_left_0",
    native_modifier_order = true,
}
    :bodypart_change("leg_bionic_basic_l", "")
    :bodypart_change("foot_bionic_basic_l", ""))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_exodii_leg_bionic_basic_right_0",
    native_modifier_order = true,
}
    :bodypart_change("leg_bionic_basic_r", "")
    :bodypart_change("foot_bionic_basic_r", ""))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_exodii_arm_bionic_basic_left_0",
    native_modifier_order = true,
}
    :bodypart_change("arm_bionic_basic_l", "")
    :bodypart_change("hand_bionic_basic_l", ""))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_exodii_arm_bionic_basic_right_0",
    native_modifier_order = true,
}
    :bodypart_change("arm_bionic_basic_r", "")
    :bodypart_change("hand_bionic_basic_r", ""))

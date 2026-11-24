local ccb = require("ccb")
local services = ccb.services
local H = require("ccb_runtime_helpers").create()

H.spawn_monster_pop = function(actor, mon_id, count, min_r, max_r)
    local s = H.char_snap(actor)
    if not s or not s.creature then return end
    local gid = H.safe_id("monster", mon_id) or H.safe_id("monster_group", mon_id)
    if not gid then return end
    services.spawns.population(gid, s.creature.position, {
        count = math.floor(count),
        min_radius = math.floor(min_r),
        max_radius = math.floor(max_r),
    })
end

H.jmath_xedra_chronomancer_level = function(ctx, _0)
    return ((2 * H.char_stat(H.u(ctx), "intelligence")) * _0)
end

H.jmath_spell_train_factor = function(ctx, _0)
    return (((H.char_has_trait(H.u(ctx), "EATER") * 500) + 1000) / (((_0 > 0)) and ((_0 + 40)) or (0)))
end

H.jmath_vampire_total_tier_one_traits = function(ctx)
    return ((((((((((H.char_has_trait(H.u(ctx), "EYEGLEAM") + H.char_has_trait(H.u(ctx), "BLOOD_FUN")) + H.char_has_trait(H.u(ctx), "STAMINAFORBLOOD")) + H.char_has_trait(H.u(ctx), "COMMUNE_NIGHT")) + H.char_has_trait(H.u(ctx), "VAMPIRIC_STRENGTH")) + H.char_has_trait(H.u(ctx), "VAMPIRIC_RESILIENCE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_HEIGHTENED_SENSES")) + H.char_has_trait(H.u(ctx), "VAMPIRE_HEALTH_BONUS")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SENSE_CHILDREN_OF_THE_NIGHT")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SILENT_MOVE")) + H.char_has_trait(H.u(ctx), "DHAMPIR_REDUCED_COLD_TEMPS"))
end

H.jmath_vampire_total_tier_one_traits_plus_potency = function(ctx)
    return (H.jmath_vampire_total_tier_one_traits(ctx) + H.creature_effect_intensity(H.u(ctx), "effect_player_anathema_potency_boost"))
end

H.jmath_vampire_total_tier_two_traits = function(ctx)
    return (((((((((((((((((H.char_has_trait(H.u(ctx), "BLOODHEAL") + H.char_has_trait(H.u(ctx), "COAGULANTWEAVE")) + H.char_has_trait(H.u(ctx), "VAMPIRIC_DODGE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_FEAR_GAZE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_WALK_ON_WALLS")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BEAST_CLAWS")) + H.char_has_trait(H.u(ctx), "VAMPIRIC_STEALTH_BONUS")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SEE_HEAT")) + H.char_has_trait(H.u(ctx), "VAMPIRE_FEIGN_DEATH")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BLOOD_TEMPORARY_BOOST")) + H.char_has_trait(H.u(ctx), "EYEGLEAM_UPGRADE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SEE_THROUGH_NIGHT_EYES")) + H.char_has_trait(H.u(ctx), "BLOOD_FUN_UPGRADE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SILENT_MOVE_UPGRADE")) + H.char_has_trait(H.u(ctx), "DHAMPIR_FANGS")) + H.char_has_trait(H.u(ctx), "DHAMPIR_SLOWFALL")) + H.char_has_trait(H.u(ctx), "DHAMPIR_RESIST_DISEASE_POISON_INFECTION")) + H.char_has_trait(H.u(ctx), "DHAMPIR_BLACKEN_SOUL_ARION"))
end

H.jmath_vampire_total_tier_three_traits = function(ctx)
    return ((((((((((((((H.char_has_trait(H.u(ctx), "BLOODHASTE") + H.char_has_trait(H.u(ctx), "HYPNOTIC_GAZE")) + H.char_has_trait(H.u(ctx), "MAGICFORBLOOD")) + H.char_has_trait(H.u(ctx), "VAMPIRE_COMMAND_BEAST")) + H.char_has_trait(H.u(ctx), "VAMPIRE_EARTH_SLUMBER")) + H.char_has_trait(H.u(ctx), "VAMPIRE_CARDIO_BONUS")) + H.char_has_trait(H.u(ctx), "VAMPIRE_MOTION_ALARM")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BONUS_HP")) + H.char_has_trait(H.u(ctx), "VAMPIRE_STORE_MORE_BLOOD")) + H.char_has_trait(H.u(ctx), "VAMPIRE_INSTANT_BLEED")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BIG_STOMACH")) + H.char_has_trait(H.u(ctx), "VAMPIRE_DETECT_VAMPIRES")) + H.char_has_trait(H.u(ctx), "DHAMPIR_REDUCED_PAIN")) + H.char_has_trait(H.u(ctx), "DHAMPIR_MEND_WOUNDS_FASTER")) + H.char_has_trait(H.u(ctx), "DHAMPIR_AVOID_EAT_SLEEP_DRINK"))
end

H.jmath_vampire_total_tier_four_traits = function(ctx)
    return ((((((((((((H.char_has_trait(H.u(ctx), "TRUE_VAMPIRE_POWER") + H.char_has_trait(H.u(ctx), "VAMPIRE_TORPOR")) + H.char_has_trait(H.u(ctx), "VAMPIRE_DOMINATE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_NO_BREATHE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_NO_ILLNESS")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BAT_FORM")) + H.char_has_trait(H.u(ctx), "VAMPIRE_WOLF_FORM")) + H.char_has_trait(H.u(ctx), "VAMPIRE_MIST_FORM")) + H.char_has_trait(H.u(ctx), "VAMPIRE_STORE_MORE_BLOOD_UPGRADE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_INVISIBLE_IN_DARK")) + H.char_has_trait(H.u(ctx), "VAMPIRE_NO_ILLNESS_UPGRADE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_FORM_UPGRADE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BLOOD_FOR_POTENCY"))
end

H.jmath_vampire_total_tier_four_traits_plus_potence = function(ctx)
    return (H.jmath_vampire_total_tier_four_traits(ctx) + (H.char_has_trait(H.u(ctx), "TRUE_VAMPIRE_POWER") * 5))
end

H.jmath_vampire_total_tier_five_traits = function(ctx)
    return ((((((((((H.char_has_trait(H.u(ctx), "VAMPIRE_MASTER_MORTAL_MIND") + H.char_has_trait(H.u(ctx), "VAMPIRE_DISTILLATE_INNER_BLOOD")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SHADOW_FORM")) + H.char_has_trait(H.u(ctx), "VAMPIRE_LAST_BREATH_MIST")) + H.char_has_trait(H.u(ctx), "VAMPIRE_IRON_MIND")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BLIND_THE_SUN")) + H.char_has_trait(H.u(ctx), "VAMPIRE_HEAL_IN_DARK")) + H.char_has_trait(H.u(ctx), "VAMPIRE_DRINK_VAMPIRE_BLOOD")) + H.char_has_trait(H.u(ctx), "VAMPIRE_GAIN_BLOOD_GIFTS")) + H.char_has_trait(H.u(ctx), "VAMPIRE_LAST_BREATH_MIST_UPGRADE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_MASTER_MORTAL_MIND_UPGRADE"))
end

H.jmath_vampire_total_tier_five_traits_plus_cauldron = function(ctx)
    return (H.jmath_vampire_total_tier_five_traits(ctx) + (H.char_has_trait(H.u(ctx), "VAMPIRE_BLOOD_FOR_POTENCY_REAL") * 10))
end

H.jmath_xe_fey_magick_mana_penalty_secondary = function(ctx)
    return (((1 - (H.char_mana(H.u(ctx), "current") / H.char_mana(H.u(ctx), "maximum"))) - 0.2) / 1.5)
end

H.jmath_xe_fey_magick_mana_penalty = function(ctx)
    return (((H.char_mana(H.u(ctx), "current") < (H.char_mana(H.u(ctx), "maximum") / 2))) and (H.jmath_xe_fey_magick_mana_penalty_secondary(ctx)) or (0))
end

ccb.runtime.handler("dlg_p_xedra_evolved_5ec7ca106bcd", function(ctx)
    return ((H.char_vitamin(H.u(ctx), "xedra_chronomancer_insight") >= H.var_num(H.u(ctx), "chronomancer_menu_insight_cost")) and (ctx:evaluate_conditional("chronomancer_menu_spell_conditions") == true))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_7b4bc1011653", function(ctx)
    return (H.global_var_num("global_xedra_chronomancy_setting_hide_insight_messages") == 0)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_164a52567b2b", function(ctx)
    return (H.global_var_num("global_xedra_chronomancy_setting_hide_insight_messages") == 1)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_8af6f3690c03", function(ctx)
    return (H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_bubble") <= 0)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_07283b57c144", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_bubble") > 0) and (H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_bubble") < H.jmath_xedra_chronomancer_level(ctx, 1)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_e06eed9d7398", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_freeze_target") > 0) and (H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_freeze_target") < H.jmath_xedra_chronomancer_level(ctx, 1)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_eb5a1c338423", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_normalize_time") > 0) and (H.char_spell_level(H.u(ctx), "xedra_chronomancer_normalize_time") < H.jmath_xedra_chronomancer_level(ctx, 1)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_3c6a72c6b80d", function(ctx)
    return (H.char_spell_level(H.u(ctx), "xedra_chronomancer_entropic_burst") <= 0)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_d7a4238f8023", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_entropic_burst") > 0) and (H.char_spell_level(H.u(ctx), "xedra_chronomancer_entropic_burst") < H.jmath_xedra_chronomancer_level(ctx, 1)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_4183b6eb5b37", function(ctx)
    return (H.char_spell_level(H.u(ctx), "xedra_chronomancer_revert_wound") <= 0)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_428f501dd629", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_revert_wound") > 0) and (H.char_spell_level(H.u(ctx), "xedra_chronomancer_revert_wound") < H.jmath_xedra_chronomancer_level(ctx, 1)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_75f4521b94a8", function(ctx)
    return (H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_loop") <= 0)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_4e392be2ce43", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_loop") > 0) and (H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_loop") < H.jmath_xedra_chronomancer_level(ctx, 1)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_f8ec20b85090", function(ctx)
    return (H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_stop") <= 0)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_e4b849fa6818", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_stop") > 0) and (H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_stop") < H.jmath_xedra_chronomancer_level(ctx, 1)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_fff11404d2d9", function(ctx)
    return (H.char_spell_level(H.u(ctx), "xedra_chronomancer_revert_location") <= 0)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_954d1f4970ff", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_revert_location") > 0) and (H.char_spell_level(H.u(ctx), "xedra_chronomancer_revert_location") < H.jmath_xedra_chronomancer_level(ctx, 1)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_02b29db42e8f", function(ctx)
    return (H.char_spell_level(H.u(ctx), "xedra_chronomancer_cement_time") <= 0)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_98864fc3e560", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_cement_time") > 0) and (H.char_spell_level(H.u(ctx), "xedra_chronomancer_cement_time") < H.jmath_xedra_chronomancer_level(ctx, 1)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_0594f8e6d416", function(ctx)
    return (H.char_spell_level(H.u(ctx), "xedra_chronomancer_paradox") <= 0)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_6cc6a4257264", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_paradox") > 0) and (H.char_spell_level(H.u(ctx), "xedra_chronomancer_paradox") < H.jmath_xedra_chronomancer_level(ctx, 1)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_478871cf2099", function(ctx)
    return (H.char_spell_level(H.u(ctx), "xedra_chronomancer_chronal_acceleration") <= 0)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_85792181c1c8", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_chronal_acceleration") > 0) and (H.char_spell_level(H.u(ctx), "xedra_chronomancer_chronal_acceleration") < H.jmath_xedra_chronomancer_level(ctx, 1)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_a74d6ae6637b", function(ctx)
    return (H.char_spell_level(H.u(ctx), "xedra_chronomancer_stable_loop") <= 0)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_1b596f4c9f53", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_stable_loop") > 0) and (H.char_spell_level(H.u(ctx), "xedra_chronomancer_stable_loop") < H.jmath_xedra_chronomancer_level(ctx, 1)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_02b12571ca75", function(ctx)
    return (H.char_spell_level(H.u(ctx), "xedra_chronomancer_destabilizing_strikes") <= 0)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_a119d45027b3", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_destabilizing_strikes") > 0) and (H.char_spell_level(H.u(ctx), "xedra_chronomancer_destabilizing_strikes") < H.jmath_xedra_chronomancer_level(ctx, 1)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_78ecdeb1c9fc", function(ctx)
    return (H.char_spell_level(H.u(ctx), "xedra_chronomancer_stabilize_timeline") <= 0)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_29aeebc23c8f", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_stabilize_timeline") > 0) and (H.char_spell_level(H.u(ctx), "xedra_chronomancer_stabilize_timeline") < H.jmath_xedra_chronomancer_level(ctx, 1)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_a6260ec2b9a1", function(ctx)
    return (H.char_spell_level(H.u(ctx), "xedra_chronomancer_reverse_entropy") <= 0)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_8c141998200f", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_reverse_entropy") > 0) and (H.char_spell_level(H.u(ctx), "xedra_chronomancer_reverse_entropy") < H.jmath_xedra_chronomancer_level(ctx, 1)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_22b6c7bb78ce", function(ctx)
    return (H.char_spell_level(H.u(ctx), "xedra_chronomancer_rewrite_wound_causality") <= 0)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_bbb60c818474", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_rewrite_wound_causality") > 0) and (H.char_spell_level(H.u(ctx), "xedra_chronomancer_rewrite_wound_causality") < H.jmath_xedra_chronomancer_level(ctx, 1)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_ee2c93501b7d", function(ctx)
    return (H.char_spell_level(H.u(ctx), "xedra_chronomancer_rewrite_equipment_causality") <= 0)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_6b9ae0e2f0b9", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_rewrite_equipment_causality") > 0) and (H.char_spell_level(H.u(ctx), "xedra_chronomancer_rewrite_equipment_causality") < H.jmath_xedra_chronomancer_level(ctx, 1)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_31b069a572b2", function(ctx)
    return H.truthy(H.char_has_trait(H.u(ctx), "XEDRA_CHRONOMANCER_LOOPING_WOUND"))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_15974d739448", function(ctx)
    return H.truthy(H.char_has_trait(H.u(ctx), "XEDRA_CHRONOMANCER_TIME_SLOWDOWN"))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_5131adbaea5f", function(ctx)
    return H.truthy(H.char_has_trait(H.u(ctx), "XEDRA_CHRONOMANCER_UNSTABLE_POWERS"))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_6f9d73792bd9", function(ctx)
    return (H.var_num(H.u(ctx), "num_perks") > 0)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_c4ea3cbe252c", function(ctx)
    return ((H.char_has_trait(H.u(ctx), "perk_ALCHEMY3") == 1) and H.char_know_recipe(H.u(ctx), "cold_iron_ingot") and (not ((H.char_has_trait(H.u(ctx), "perk_ALCHEMY3_COLD_IRON") == 1))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_7ca7adc11f7e", function(ctx)
    return (H.global_var_num("Boann_Quests_Completed") < 10)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_04093a51dc35", function(ctx)
    return (H.global_var_num("Boann_Quests_Completed") >= 10)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_4df51e8438f5", function(ctx)
    return (H.global_var_num("Boann_Quests_Accepted") == 10)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_1e8a51a49649", function(ctx)
    return (H.global_var_num("Boann_Quests_Completed") >= 6)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_fa6979ea7ba7", function(ctx)
    return (H.global_var_num("Boann_Quests_Accepted") == 6)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_dfe207bd8294", function(ctx)
    return ((not (H.char_has_mission(H.u(ctx), "MISSION_GET_TRIFFID_HEART_FOR_BOANN"))) and (H.global_var_num("Boann_Quests_Completed") >= 6) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "completed_boann_bring_triffid_heart", "")))))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_b71db82a456b", function(ctx)
    return ((not (H.char_has_mission(H.u(ctx), "MISSION_KILL_TITAN_BEETLE_FOR_BOANN"))) and (H.global_var_num("Boann_Quests_Completed") >= 6) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "completed_boann_kill_titan_beetle", "")))))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_1f936a76f1ea", function(ctx)
    return ((not (H.char_has_mission(H.u(ctx), "MISSION_GET_SHADOW_SINGULARITY_PIECE_FOR_BOANN"))) and (H.global_var_num("Boann_Quests_Completed") >= 6) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "completed_boann_bring_shadow_piece", "")))))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_637cfb78c98b", function(ctx)
    return ((not (H.char_has_mission(H.u(ctx), "MISSION_KILL_STAR_CROWN_HOUND_FOR_BOANN"))) and (H.global_var_num("Boann_Quests_Completed") >= 6) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "completed_boann_kill_star_crown_hound", "")))))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_b52f0aa23941", function(ctx)
    return H.npc_allies_global(1)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_3a5567108775", function(ctx)
    return ((H.char_has_trait(H.npc(ctx), "DREAMER") == 1) and (H.char_mana(H.npc(ctx), "current") >= 1000))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_b585fe569540", function(ctx)
    return (((H.char_has_trait(H.npc(ctx), "DREAMER") == 1)) and (H.char_mana(H.npc(ctx), "current") < 1000))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_8f5a48321ea0", function(ctx)
    return ((H.char_has_trait(H.npc(ctx), "DREAMER") == 1) and (H.char_mana(H.npc(ctx), "current") < 1000))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_cc4fda4d8531", function(ctx)
    return (((H.npc_opinion(H.npc(ctx), "trust") <= 0) or (H.npc_opinion(H.npc(ctx), "value") <= 0)) and (H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1) and (not ((H.char_has_trait(H.npc(ctx), "LILIN_TRAITS") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "BLOOD_OF_SAINTS") == 1))) and (not ((H.char_has_trait(H.u(ctx), "TURN_INTO_OWL_TRAITS") == 1))) and (not ((H.char_has_trait(H.u(ctx), "LILIN_WAR_OWL_FORM_TRAITS") == 1))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_12ee142e1d0d", function(ctx)
    return ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1) and (not ((H.char_has_trait(H.npc(ctx), "LILIN_TRAITS") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "BLOOD_OF_SAINTS") == 1))) and (not ((H.char_has_trait(H.u(ctx), "TURN_INTO_OWL_TRAITS") == 1))) and (not ((H.char_has_trait(H.u(ctx), "LILIN_WAR_OWL_FORM_TRAITS") == 1))) and (H.npc_opinion(H.npc(ctx), "trust") >= 10) and (H.npc_opinion(H.npc(ctx), "value") >= 10))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_d209ac6c7dc0", function(ctx)
    return ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1) and (not ((H.char_has_trait(H.npc(ctx), "LILIN_TRAITS") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "BLOOD_OF_SAINTS") == 1))) and (not ((H.char_has_trait(H.u(ctx), "TURN_INTO_OWL_TRAITS") == 1))) and (not ((H.char_has_trait(H.u(ctx), "LILIN_WAR_OWL_FORM_TRAITS") == 1))) and (not (((H.npc_opinion(H.npc(ctx), "trust") >= 10) and (H.npc_opinion(H.npc(ctx), "value") >= 10)))) and (H.npc_opinion(H.npc(ctx), "trust") > 0) and (H.npc_opinion(H.npc(ctx), "value") > 0))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_a9d361425c82", function(ctx)
    return (H.global_var_num("npc_randomize_book_find_mission") == 1)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_3602997c83c2", function(ctx)
    return (H.global_var_num("npc_randomize_book_find_mission") == 2)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_a2107f3d14c6", function(ctx)
    return (H.global_var_num("npc_randomize_book_find_mission") == 3)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_079cda004454", function(ctx)
    return (H.global_var_num("npc_randomize_book_find_mission") > 3)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_d5491a924f31", function(ctx)
    return (H.global_var_num("npc_randomize_game_find_mission") == 1)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_d7f5e506e1e2", function(ctx)
    return (H.global_var_num("npc_randomize_game_find_mission") == 2)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_766b0181e6cf", function(ctx)
    return (H.global_var_num("npc_randomize_game_find_mission") == 3)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_df132bd89a85", function(ctx)
    return (H.global_var_num("npc_randomize_game_find_mission") > 3)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_f7e025645017", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "trust") >= 10) and (H.npc_opinion(H.npc(ctx), "value") >= 10) and H.char_has_mission(H.u(ctx), "KILL_YOUR_BEST_FRIEND") and (not (H.char_has_mission(H.u(ctx), "mission_best_friend_bookhunt1"))) and (not (H.char_has_mission(H.u(ctx), "mission_best_friend_bookhunt2"))) and (not (H.char_has_mission(H.u(ctx), "mission_best_friend_bookhunt3"))) and (not (H.char_has_mission(H.u(ctx), "mission_best_friend_gamehunt1"))) and (not (H.char_has_mission(H.u(ctx), "mission_best_friend_gamehunt2"))) and (not (H.char_has_mission(H.u(ctx), "mission_best_friend_gamehunt3"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "best_friend", "")))))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_0ed2fb4e6714", function(ctx)
    return ((H.char_has_mission(H.u(ctx), "mission_best_friend_gamehunt1") or H.char_has_mission(H.u(ctx), "mission_best_friend_gamehunt2") or H.char_has_mission(H.u(ctx), "mission_best_friend_gamehunt3")) and (H.npc_opinion(H.npc(ctx), "trust") >= 10) and (H.npc_opinion(H.npc(ctx), "value") >= 10) and H.char_has_mission(H.u(ctx), "KILL_YOUR_BEST_FRIEND") and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "best_friend", "")))))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_6ccc3d78c9e3", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "trust") >= 10) and (H.npc_opinion(H.npc(ctx), "value") >= 10) and H.char_has_mission(H.u(ctx), "KILL_YOUR_BEST_FRIEND") and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "best_friend", "")))) and (not ((H.char_has_trait(H.npc(ctx), "VAMPIRE_SACRIFICE") == 1))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_fe36e8fba264", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "trust") <= 9) and (H.npc_opinion(H.npc(ctx), "value") <= 9) and H.char_has_mission(H.u(ctx), "KILL_YOUR_BEST_FRIEND"))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_b3eba08a0db3", function(ctx)
    return ((H.char_skill(H.u(ctx), "deduction") >= 4) or (H.char_stat(H.u(ctx), "intelligence") >= (14)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_89df39a2ceaa", function(ctx)
    return (H.char_skill(H.u(ctx), "deduction") >= 2)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_39c0e8670625", function(ctx)
    return (((H.char_has_trait(H.npc(ctx), "EGGSAC_SURVIVABLE") == 1) or (H.char_has_trait(H.npc(ctx), "EGGSAC_FATAL") == 1)) and (H.char_skill(H.u(ctx), "deduction") >= 2))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_6cda2b3c8c80", function(ctx)
    return (((H.npc_opinion(H.npc(ctx), "trust") <= 0) or (H.npc_opinion(H.npc(ctx), "value") <= 0)) and (not (H.char_has_flag(H.npc(ctx), "BLEED_IMMUNE"))) and (not ((H.char_has_trait(H.npc(ctx), "ACIDBLOOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CRUSTACEAN") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_INSECT") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CEPHALOPOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_GASTROPOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "BLOOD_OF_SAINTS") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "VAMPIRE") == 1))) and H.char_has_any_trait(H.u(ctx), { "VAMPIRE", "DHAMPIR_FANGS" }))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_a5fcb59a7720", function(ctx)
    return ((not (H.char_has_flag(H.npc(ctx), "BLEED_IMMUNE"))) and (not ((H.char_has_trait(H.npc(ctx), "ACIDBLOOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CRUSTACEAN") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_INSECT") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CEPHALOPOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_GASTROPOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "BLOOD_OF_SAINTS") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "VAMPIRE") == 1))) and (H.npc_opinion(H.npc(ctx), "trust") >= 10) and (H.npc_opinion(H.npc(ctx), "value") >= 10) and H.char_has_any_trait(H.u(ctx), { "VAMPIRE", "DHAMPIR_FANGS" }))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_5eb635ad05fd", function(ctx)
    return ((not (H.char_has_flag(H.npc(ctx), "BLEED_IMMUNE"))) and (not ((H.char_has_trait(H.npc(ctx), "ACIDBLOOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CRUSTACEAN") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_INSECT") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CEPHALOPOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_GASTROPOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "BLOOD_OF_SAINTS") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "VAMPIRE") == 1))) and (not (((H.npc_opinion(H.npc(ctx), "trust") >= 10) and (H.npc_opinion(H.npc(ctx), "value") >= 10)))) and (H.npc_opinion(H.npc(ctx), "trust") > 0) and (H.npc_opinion(H.npc(ctx), "value") > 0) and H.char_has_any_trait(H.u(ctx), { "VAMPIRE", "DHAMPIR_FANGS" }))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_a18ecb6198e3", function(ctx)
    return (H.char_vitamin(H.u(ctx), "human_blood_vitamin") > (-501))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_5f31aeb28f16", function(ctx)
    return (H.char_vitamin(H.u(ctx), "human_blood_vitamin") > 2501)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_ea187e67e5c3", function(ctx)
    return (H.char_vitamin(H.u(ctx), "human_blood_vitamin") <= (-501))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_35cc231b3499", function(ctx)
    return ((not (H.char_has_any_trait(H.u(ctx), { "VAMPIRE_ANATHEMA", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" }))) and ((not (H.char_know_recipe(H.u(ctx), "xe_vampire_blood_gift_research"))) or (not (H.char_know_recipe(H.u(ctx), "xe_vampire_blood_gift_refinement_research")))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "told_about_trueness", "")))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_69ebfe42166c", function(ctx)
    return (not (H.char_know_recipe(H.u(ctx), "xe_vampire_blood_gift_research")))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_e41f1ff7873a", function(ctx)
    return (H.char_has_any_trait(H.u(ctx), { "ARVORE", "IERDE", "SALAMANDER", "SYLPH", "UNDINE" }) and (H.char_proficiency(H.u(ctx), "prof_paraclesian_computer_understanding", "percent") < 100) and (H.char_skill(H.npc(ctx), "computer") >= 4) and (not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "asked_faction_npc_about_paraclesian_computer_teaching_high", "")))))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_1b42dfc646dd", function(ctx)
    return (H.char_has_any_trait(H.u(ctx), { "ARVORE", "IERDE", "SALAMANDER", "SYLPH", "UNDINE" }) and (H.char_proficiency(H.u(ctx), "prof_paraclesian_computer_understanding", "percent") < 100) and (H.char_skill(H.npc(ctx), "computer") < 4) and (not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "asked_faction_npc_about_paraclesian_computer_teaching_low", "")))))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_03bb319fd371", function(ctx)
    return ((H.char_has_trait(H.u(ctx), "HOMULLUS") == 1) and (H.char_proficiency(H.u(ctx), "prof_paraclesian_computer_understanding", "percent") < 100) and (H.char_skill(H.npc(ctx), "computer") >= 4) and (not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "asked_faction_npc_about_paraclesian_computer_teaching_high", "")))))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_5d87aaebc246", function(ctx)
    return ((H.char_has_trait(H.u(ctx), "HOMULLUS") == 1) and (H.char_proficiency(H.u(ctx), "prof_paraclesian_computer_understanding", "percent") < 100) and (H.char_skill(H.npc(ctx), "computer") < 4) and (not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "asked_faction_npc_about_paraclesian_computer_teaching_low", "")))))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_8d2fba5ec62c", function(ctx)
    return (H.char_has_any_trait(H.u(ctx), { "ARVORE", "IERDE", "SALAMANDER", "UNDINE" }) and (H.char_proficiency(H.u(ctx), "prof_paraclesian_electronics_understanding", "percent") < 100) and (H.char_skill(H.npc(ctx), "electronics") >= 4) and (not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "asked_faction_npc_about_paraclesian_electronics_teaching_high", "")))))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_9496abe6d689", function(ctx)
    return (H.char_has_any_trait(H.u(ctx), { "ARVORE", "IERDE", "SALAMANDER", "UNDINE" }) and (H.char_proficiency(H.u(ctx), "prof_paraclesian_electronics_understanding", "percent") < 100) and (H.char_skill(H.npc(ctx), "electronics") < 4) and (not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "asked_faction_npc_about_paraclesian_electronics_teaching_low", "")))))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_9ce0d1312c56", function(ctx)
    return ((H.char_has_trait(H.u(ctx), "SYLPH") == 1) and (H.char_proficiency(H.u(ctx), "prof_paraclesian_electronics_understanding", "percent") < 100) and (H.char_skill(H.npc(ctx), "electronics") >= 4) and (not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "asked_faction_npc_about_paraclesian_electronics_teaching_high", "")))))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_24000ffc3f7f", function(ctx)
    return ((H.char_has_trait(H.u(ctx), "SYLPH") == 1) and (H.char_proficiency(H.u(ctx), "prof_paraclesian_electronics_understanding", "percent") < 100) and (H.char_skill(H.npc(ctx), "electronics") < 4) and (not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "asked_faction_npc_about_paraclesian_electronics_teaching_low", "")))))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_34d8ebf4a392", function(ctx)
    return ((H.char_has_trait(H.u(ctx), "HOMULLUS") == 1) and (H.char_proficiency(H.u(ctx), "prof_paraclesian_electronics_understanding", "percent") < 100) and (H.char_skill(H.npc(ctx), "electronics") >= 4) and (not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "asked_faction_npc_about_paraclesian_electronics_teaching_high", "")))))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_d090792edc84", function(ctx)
    return ((H.char_has_trait(H.u(ctx), "HOMULLUS") == 1) and (H.char_proficiency(H.u(ctx), "prof_paraclesian_electronics_understanding", "percent") < 100) and (H.char_skill(H.npc(ctx), "electronics") < 4) and (not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "asked_faction_npc_about_paraclesian_electronics_teaching_low", "")))))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_bc1fa17bc005", function(ctx)
    return ((H.char_has_trait(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") == 1) and (H.char_spell_level(H.npc(ctx), "changeling_spring_prevent_bad_conditions_spell") >= 1) and (H.char_mana(H.npc(ctx), "maximum") >= math.max(((500 - (H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") * 4)) - (H.char_skill(H.npc(ctx), "gramarye") * 8)), 350)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_5106e877ba81", function(ctx)
    return ((H.char_has_trait(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") == 1) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (((H.char_snap(H.npc(ctx)) or {}).creature or {}).outside == true) and (H.char_spell_level(H.npc(ctx), "changeling_spring_healing_increase_while_outside_spell") >= 1) and (H.char_mana(H.npc(ctx), "maximum") >= math.max(((800 - (H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") * 8)) - (H.char_skill(H.npc(ctx), "gramarye") * 15)), 450)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_17d6465e06c8", function(ctx)
    return ((H.char_has_trait(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER") == 1) and (H.char_spell_level(H.npc(ctx), "changeling_summer_protect_from_hot_weather_spell") >= 1) and (H.char_mana(H.npc(ctx), "maximum") >= math.max(((250 - (H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER") * 2)) - (H.char_skill(H.npc(ctx), "gramarye") * 4.5)), 100)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_937b74baf8cf", function(ctx)
    return ((H.char_has_trait(H.u(ctx), "HYPNOTIC_GAZE") == 1) and (H.char_vitamin(H.u(ctx), "human_blood_vitamin") >= (-500)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_5a52ac7f915d", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "changeling_autumn_scare_humans_spell") > 0) and (H.char_mana(H.u(ctx), "current") > math.max(((300 - (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 4)) - (H.char_skill(H.u(ctx), "gramarye") * 7)), 150)))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_91d05d3070a1", function(ctx)
    return ((services.random.native_int(1, math.floor(100)) + (0)) > (((((((15 + (((H.global_var_num("global_what_is_the_season") == 1)) and (35) or (0))) + (((H.global_var_num("global_what_is_the_season") == 2)) and (15) or (0))) + (((H.global_var_num("global_what_is_the_season") == 4)) and (15) or (0))) + (5 * 9)) + (H.jmath_xe_fey_magick_mana_penalty(ctx) * 100)) - ((H.char_skill(H.u(ctx), "gramarye") * 6) + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 4)))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_332cbb5e6240", function(ctx)
    return ((H.char_sum_traits_cat(H.u(ctx), "FAIR_FOLK_COMMONER_BROWNIE", "ALL") < 3) and (not ((H.char_has_trait(H.u(ctx), "UNKNOWING_CHANGELING_NOBLE") == 1))))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_004b9d023580", function(ctx)
    return ((H.char_sum_traits_cat(H.u(ctx), "FAIR_FOLK_COMMONER_BROWNIE", "ALL") >= 3))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_79ce6c0fc7d3", function(ctx)
    return (H.global_var_num("sold_arvore_sample_to_bloodthorne_hunter") == 0)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_3f092d269806", function(ctx)
    return (H.global_var_num("sold_arvore_sample_to_bloodthorne_hunter") == 1)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_e5045d407662", function(ctx)
    return (H.global_var_num("sold_arvore_sample_to_bloodthorne_hunter") < 6)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_0a508fa5baff", function(ctx)
    return (H.global_var_num("vampire_hunters_owed_help") > 0)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_709ef5935fa8", function(ctx)
    return ((not ((H.char_has_trait(H.u(ctx), "VAMPIRE") == 1))) and (H.global_var_num("Vampire_Hunter_Quest_Completed") < 3) and (H.global_var_num("Vampire_Hunter_Quest_Accepted") < 3))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_fb994b54cfd1", function(ctx)
    return ((not ((H.char_has_trait(H.u(ctx), "VAMPIRE") == 1))) and (not (H.char_has_mission(H.u(ctx), "MISSION_VAMPIRE_HUNTER_LEADER_CURE_OR_KILL_TARGET"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "completed_hunters_kill_or_cure_target", "")))))) and (H.global_var_num("Vampire_Hunter_Quest_Completed") == 3) and (H.global_var_num("Vampire_Hunter_Quest_Accepted") == 3))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_529068208d5f", function(ctx)
    return ((not ((H.char_has_trait(H.u(ctx), "VAMPIRE") == 1))) and (H.global_var_num("Vampire_Hunter_Quest_Completed") >= 4))
end)

ccb.runtime.handler("dlg_p_xedra_evolved_a14958bd5c9c", function(ctx)
    return (H.global_var_num("Vampire_Hunter_Quest_Accepted") < 3)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_fa2c90835cf0", function(ctx)
    return (H.global_var_num("vampire_hunters_owed_help") >= 1)
end)

ccb.runtime.handler("dlg_p_xedra_evolved_5c3b94c5290a", function(ctx)
    return (H.global_var_num("vampire_hunters_owed_help") < 1)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_4158d561cb43", function(ctx)
    H.copy_var("context", nil, "chronomancer_menu_choice_id", "actor", H.u(ctx), "chronomancer_menu_learn_id", ctx)
    local _a1 = H.u(ctx)
    local _sn2 = H.var_str("actor", H.u(ctx), ctx, "chronomancer_menu_learn_id", "")
    local _sg3 = (_sn2 ~= "") and H.safe_id("spell", _sn2) or nil
    if _a1 and _sg3 then services.spells.set_level(_a1, _sg3, math.floor(1)) end
    local _a4 = H.u(ctx)
    local _vg5 = H.safe_id("vitamin", "xedra_chronomancer_insight")
    if _a4 and _vg5 then services.needs.modify_vitamin(_a4, _vg5, math.floor(-(H.var_num(H.u(ctx), "chronomancer_menu_insight_cost")))) end
    H.set_var("actor", H.u(ctx), ctx, "xedra_chronomancer_insight_count", H.char_vitamin(H.u(ctx), "xedra_chronomancer_insight"))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_81702efd677c", function(ctx)
    H.copy_var("context", nil, "chronomancer_menu_choice_id", "actor", H.u(ctx), "chronomancer_menu_learn_id", ctx)
    local _a6 = H.u(ctx)
    local _sn7 = H.var_str("actor", H.u(ctx), ctx, "chronomancer_menu_learn_id", "")
    local _sg8 = (_sn7 ~= "") and H.safe_id("spell", _sn7) or nil
    if _a6 and _sg8 then services.spells.set_level(_a6, _sg8, math.floor((H.char_spell_level(_a6, _sn7)) + (1))) end
    local _a9 = H.u(ctx)
    local _vg10 = H.safe_id("vitamin", "xedra_chronomancer_insight")
    if _a9 and _vg10 then services.needs.modify_vitamin(_a9, _vg10, math.floor(-(H.var_num(H.u(ctx), "chronomancer_menu_insight_cost")))) end
    H.set_var("actor", H.u(ctx), ctx, "xedra_chronomancer_insight_count", H.char_vitamin(H.u(ctx), "xedra_chronomancer_insight"))
    services.messages.add(ctx:expand_text(services.translate("You improve the spell!")), "good")
end)

ccb.runtime.handler("dlg_a_xedra_evolved_ecbdaa951f27", function(ctx)
    H.copy_var("context", nil, "chronomancer_menu_choice_id", "actor", H.u(ctx), "chronomancer_menu_learn_id", ctx)
    H.lose_trait(H.u(ctx), H.var_str("actor", H.u(ctx), ctx, "chronomancer_menu_learn_id", ""))
    local _a11 = H.u(ctx)
    local _vg12 = H.safe_id("vitamin", "xedra_chronomancer_insight")
    if _a11 and _vg12 then services.needs.modify_vitamin(_a11, _vg12, math.floor(-(H.var_num(H.u(ctx), "chronomancer_menu_insight_cost")))) end
    H.set_var("actor", H.u(ctx), ctx, "xedra_chronomancer_insight_count", H.char_vitamin(H.u(ctx), "xedra_chronomancer_insight"))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_025fe1f04f4d", function(ctx)
    H.set_var("global", nil, ctx, "global_xedra_chronomancy_setting_hide_insight_messages", 1)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_1ee970e6ee34", function(ctx)
    H.set_var("global", nil, ctx, "global_xedra_chronomancy_setting_hide_insight_messages", 0)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_37bf4214d9d0", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (10 * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_time_bubble", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 3)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_87d9b74af6e5", function(ctx)
    ctx:set_conditional("chronomancer_menu_spell_conditions", (0 == 0))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_1c5e5da1ab4a", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_bubble") * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_time_bubble", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 3)
    H.set_var("context", nil, ctx, "chronomancer_spell_level", H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_bubble"))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_c0b71bb83072", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_freeze_target") * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_time_freeze_target", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 3)
    H.set_var("context", nil, ctx, "chronomancer_spell_level", H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_freeze_target"))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_8577ba069972", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (H.char_spell_level(H.u(ctx), "xedra_chronomancer_normalize_time") * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_normalize_time", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 3)
    H.set_var("context", nil, ctx, "chronomancer_spell_level", H.char_spell_level(H.u(ctx), "xedra_chronomancer_normalize_time"))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_cb233f0b91fb", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", 80)
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 8)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (10 * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_entropic_burst", true)))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_216cd926ece8", function(ctx)
    ctx:set_conditional("chronomancer_menu_spell_conditions", (H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_bubble") >= 16))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_9ca86534e9a0", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (H.char_spell_level(H.u(ctx), "xedra_chronomancer_entropic_burst") * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_entropic_burst", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 8)
    H.set_var("context", nil, ctx, "chronomancer_spell_level", H.char_spell_level(H.u(ctx), "xedra_chronomancer_entropic_burst"))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_cee14717bcf5", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (10 * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_revert_wound", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 4)
    H.set_var("context", nil, ctx, "chronomancer_spell_level", H.char_spell_level(H.u(ctx), "xedra_chronomancer_revert_wound"))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_1a819b25b63f", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (H.char_spell_level(H.u(ctx), "xedra_chronomancer_revert_wound") * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_revert_wound", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 4)
    H.set_var("context", nil, ctx, "chronomancer_spell_level", H.char_spell_level(H.u(ctx), "xedra_chronomancer_revert_wound"))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_587ddafb09e8", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (10 * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_time_loop", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 5)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_eb92ea277d74", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_loop") * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_time_loop", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 5)
    H.set_var("context", nil, ctx, "chronomancer_spell_level", H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_loop"))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_af5018b125f5", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (15 * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_time_stop", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 10)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_28329a927547", function(ctx)
    ctx:set_conditional("chronomancer_menu_spell_conditions", (H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_freeze_target") >= 20))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_1aef20396c7d", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_stop") * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_time_stop", true)) * 1.5))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 10)
    H.set_var("context", nil, ctx, "chronomancer_spell_level", H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_stop"))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_0df961d5a7c1", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (10 * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_revert_location", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 8)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_69cdad98a75a", function(ctx)
    ctx:set_conditional("chronomancer_menu_spell_conditions", ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_stable_loop") >= 16) and (H.char_spell_level(H.u(ctx), "xedra_chronomancer_revert_wound") >= 16)))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_cdca0774c4c9", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (H.char_spell_level(H.u(ctx), "xedra_chronomancer_revert_location") * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_revert_location", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 8)
    H.set_var("context", nil, ctx, "chronomancer_spell_level", H.char_spell_level(H.u(ctx), "xedra_chronomancer_revert_location"))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_9ced1a10f928", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (15 * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_cement_time", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 10)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_41b1b34a4db9", function(ctx)
    ctx:set_conditional("chronomancer_menu_spell_conditions", ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_freeze_target") >= 16) and (H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_bubble") >= 16)))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_29a8f36e3839", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_cement_time") * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_cement_time", true)) * 1.5))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 10)
    H.set_var("context", nil, ctx, "chronomancer_spell_level", H.char_spell_level(H.u(ctx), "xedra_chronomancer_cement_time"))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_6cbab3670f7a", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (15 * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_paradox", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 10)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_bffa399f46dd", function(ctx)
    ctx:set_conditional("chronomancer_menu_spell_conditions", ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_cement_time") >= 15) and (H.char_spell_level(H.u(ctx), "xedra_chronomancer_entropic_burst") >= 15) and (H.char_spell_level(H.u(ctx), "xedra_chronomancer_stable_loop") >= 15)))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_27c3794e8a89", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", ((H.char_spell_level(H.u(ctx), "xedra_chronomancer_paradox") * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_paradox", true)) * 1.5))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 10)
    H.set_var("context", nil, ctx, "chronomancer_spell_level", H.char_spell_level(H.u(ctx), "xedra_chronomancer_paradox"))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_cccee07de106", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (10 * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_chronal_acceleration", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 8)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_c47db0be44aa", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (H.char_spell_level(H.u(ctx), "xedra_chronomancer_chronal_acceleration") * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_chronal_acceleration", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 8)
    H.set_var("context", nil, ctx, "chronomancer_spell_level", H.char_spell_level(H.u(ctx), "xedra_chronomancer_chronal_acceleration"))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_97c82251b24c", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (10 * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_stable_loop", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 5)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_b7c1b3a58a48", function(ctx)
    ctx:set_conditional("chronomancer_menu_spell_conditions", (H.char_spell_level(H.u(ctx), "xedra_chronomancer_time_loop") >= 16))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_4eaecdcdca6e", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (H.char_spell_level(H.u(ctx), "xedra_chronomancer_stable_loop") * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_stable_loop", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 5)
    H.set_var("context", nil, ctx, "chronomancer_spell_level", H.char_spell_level(H.u(ctx), "xedra_chronomancer_stable_loop"))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_cd288d13dae4", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (10 * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_destabilizing_strikes", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 6)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_6096d689d486", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (H.char_spell_level(H.u(ctx), "xedra_chronomancer_destabilizing_strikes") * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_destabilizing_strikes", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 6)
    H.set_var("context", nil, ctx, "chronomancer_spell_level", H.char_spell_level(H.u(ctx), "xedra_chronomancer_destabilizing_strikes"))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_729e6df32435", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (10 * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_stabilize_timeline", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 3)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_1354870a324f", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (H.char_spell_level(H.u(ctx), "xedra_chronomancer_stabilize_timeline") * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_stabilize_timeline", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 3)
    H.set_var("context", nil, ctx, "chronomancer_spell_level", H.char_spell_level(H.u(ctx), "xedra_chronomancer_stabilize_timeline"))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_6da4dcd431c6", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (10 * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_reverse_entropy", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 3)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_6395802b76f7", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (H.char_spell_level(H.u(ctx), "xedra_chronomancer_reverse_entropy") * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_reverse_entropy", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 3)
    H.set_var("context", nil, ctx, "chronomancer_spell_level", H.char_spell_level(H.u(ctx), "xedra_chronomancer_reverse_entropy"))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_633bdbcabb39", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (10 * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_rewrite_wound_causality", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 6)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_91e8684580a3", function(ctx)
    ctx:set_conditional("chronomancer_menu_spell_conditions", (H.char_spell_level(H.u(ctx), "xedra_chronomancer_revert_wound") >= 10))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_2530e835a651", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (H.char_spell_level(H.u(ctx), "xedra_chronomancer_rewrite_wound_causality") * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_rewrite_wound_causality", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 6)
    H.set_var("context", nil, ctx, "chronomancer_spell_level", H.char_spell_level(H.u(ctx), "xedra_chronomancer_rewrite_wound_causality"))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_5cb29fa32fa6", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (10 * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_rewrite_equipment_causality", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 6)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_cc4f5a63f105", function(ctx)
    ctx:set_conditional("chronomancer_menu_spell_conditions", (H.char_spell_level(H.u(ctx), "xedra_chronomancer_reverse_entropy") >= 10))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_fb72a14f1a31", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", (H.char_spell_level(H.u(ctx), "xedra_chronomancer_rewrite_equipment_causality") * H.char_spell_difficulty(H.u(ctx), "xedra_chronomancer_rewrite_equipment_causality", true)))
    H.set_var("context", nil, ctx, "chronomancer_menu_difficulty", 6)
    H.set_var("context", nil, ctx, "chronomancer_spell_level", H.char_spell_level(H.u(ctx), "xedra_chronomancer_rewrite_equipment_causality"))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_5caa4b4614c2", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "chronomancer_menu_insight_cost", 50)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_0379580f0feb", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "num_perks", (H.var_num(H.u(ctx), "num_perks")) - 1)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_19b7a9d02af2", function(ctx)
    ctx:set_conditional("perk_condition", (0 == 0))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_97107ed29271", function(ctx)
    H.set_var("global", nil, ctx, "regular_zombies_allowed", 0)
    H.set_var("global", nil, ctx, "special_zombies_allowed", 0)
    H.set_var("global", nil, ctx, "spiders_allowed", 0)
    H.set_var("global", nil, ctx, "triffids_allowed", 0)
    H.set_var("global", nil, ctx, "robots_allowed", 0)
    H.set_var("global", nil, ctx, "subspace_allowed", 0)
    H.set_var("global", nil, ctx, "exodii_allowed", 1)
    H.find_and_store_loc(H.u(ctx), ctx, "global", "your_spawnpoint", { terrain = "dm_field_office_8" }, { z = 0 }, nil, nil)
    local _a14 = H.u(ctx)
    local _pos13 = H.get_tripoint_var("global", nil, ctx, "your_spawnpoint")
    if _a14 and _pos13 then services.relocation.teleport_character(_a14, _pos13, nil) end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_39d3de69d719", function(ctx)
    H.find_and_store_loc(H.u(ctx), ctx, "context", "Boann_teleport", { terrain = "forest", match = "CONTAINS" }, { z = 0 }, nil, nil)
    ccb.presentation.notice(ctx:expand_text(services.translate("Boann dismissively waves a hand before you can say anything, and you are enveloped by a swirl of multicolored lights.")))
    H.spawn_monster_pop(H.npc(ctx), "mon_wild_huntsman", (4 + services.random.native_int(0, H.round_half_away(2))), 2, 7)
    H.spawn_monster_pop(H.npc(ctx), "mon_wild_hunt_hound", (8 + services.random.native_int(0, H.round_half_away(4))), 4, 10)
    local _a16 = H.u(ctx)
    local _pos15 = H.get_tripoint_var("context", nil, ctx, "Boann_teleport")
    if _a16 and _pos15 then services.relocation.teleport_character(_a16, _pos15, { force = true }) end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_ed11e2ea946f", function(ctx)
    H.consume_item(H.u(ctx), "jabberwock_heart", 1, 0)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_cf12c508fcee", function(ctx)
    H.receive_item(H.u(ctx), "horse_tack", 1, nil)
    H.set_var("global", nil, ctx, "Boann_Quests_Completed", (H.global_var_num("Boann_Quests_Completed")) + 1)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_4ab7cfd6e16e", function(ctx)
    H.set_var("global", nil, ctx, "Boann_Quests_Completed", (H.global_var_num("Boann_Quests_Completed")) + 1)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_d9b5051470de", function(ctx)
    H.receive_item(H.u(ctx), "spellbook_hedge_clairvoyance_cone", 1, nil)
    H.set_var("global", nil, ctx, "Boann_Quests_Completed", (H.global_var_num("Boann_Quests_Completed")) + 1)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_574ffce3087f", function(ctx)
    H.receive_item(H.u(ctx), "mana_recharge_sphere", 1, nil)
    H.set_var("global", nil, ctx, "Boann_Quests_Completed", (H.global_var_num("Boann_Quests_Completed")) + 1)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_f5eac8797fc4", function(ctx)
    H.receive_item(H.u(ctx), "boann_insignia", 1, nil)
    H.set_var("global", nil, ctx, "Boann_Quests_Completed", (H.global_var_num("Boann_Quests_Completed")) + 1)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_95172cc51252", function(ctx)
    H.receive_item(H.u(ctx), "winter_lord_estoc", 1, nil)
    H.set_var("global", nil, ctx, "Boann_Quests_Completed", (H.global_var_num("Boann_Quests_Completed")) + 1)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_6d0172cf5651", function(ctx)
    H.consume_item(H.u(ctx), "triffid_heart_chunk", 1, 0)
    H.receive_item(H.u(ctx), "helmet_verdant", 1, nil)
    H.receive_item(H.u(ctx), "armor_verdant_cuirass", 1, nil)
    H.receive_item(H.u(ctx), "gauntlets_verdant", 1, nil)
    H.receive_item(H.u(ctx), "leg_guards_verdant", 1, nil)
    H.receive_item(H.u(ctx), "boots_verdant", 1, nil)
    H.receive_item(H.u(ctx), "cloak_verdant", 1, nil)
    H.set_var("global", nil, ctx, "Boann_Quests_Completed", (H.global_var_num("Boann_Quests_Completed")) + 1)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_6d66d884babf", function(ctx)
    H.receive_item(H.u(ctx), "väinämöinens_kantele", 1, nil)
    H.set_var("global", nil, ctx, "Boann_Quests_Completed", (H.global_var_num("Boann_Quests_Completed")) + 1)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_f5ff0d9bcf33", function(ctx)
    H.consume_item(H.u(ctx), "shadow_singularity_piece", 1, 0)
    H.receive_item(H.u(ctx), "boann_banner", 1, nil)
    H.set_var("global", nil, ctx, "Boann_Quests_Completed", (H.global_var_num("Boann_Quests_Completed")) + 1)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_c9a3c948bbd8", function(ctx)
    H.receive_item(H.u(ctx), "dream_attuning_necklace", 1, nil)
    H.set_var("global", nil, ctx, "Boann_Quests_Completed", (H.global_var_num("Boann_Quests_Completed")) + 1)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_cc650a073f83", function(ctx)
    H.set_var("global", nil, ctx, "Boann_Quests_Accepted", (H.global_var_num("Boann_Quests_Accepted")) + 1)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_e9fbf4617322", function(ctx)
    if H.char_is_wearing(H.npc(ctx), "dream_attuning_necklace") then
        H.receive_item(H.u(ctx), "scrap_dreamdross", (3.5 + (0.5 * H.char_spell_level(H.npc(ctx), "create_dream_dross"))), nil)
        local _a17 = H.npc(ctx)
        if _a17 then services.spells.set_mana_raw(_a17, math.floor((H.char_mana(_a17, "current")) - (1000))) end
        local _a18 = H.npc(ctx)
        local _sg19 = H.safe_id("skill", "deduction")
        if _a18 and _sg19 then services.skills.set(_a18, _sg19, { exercise_raw = math.floor((H.char_skill_exp(_a18, "deduction", true)) + ((250 * services.gameplay.options.get_number("SKILL_TRAINING_SPEED")))) }) end
        local _a20 = H.npc(ctx)
        local _spg21 = H.safe_id("spell", "create_dream_dross")
        if _a20 and _spg21 then services.spells.set_experience(_a20, _spg21, math.floor((H.char_spell_exp(_a20, "create_dream_dross")) + ((((services.spells.experience_for_level(H.safe_id("spell", "create_dream_dross"), math.floor((H.char_spell_level(H.npc(ctx), "create_dream_dross") + 1))) or 0) - (services.spells.experience_for_level(H.safe_id("spell", "create_dream_dross"), math.floor(H.char_spell_level(H.npc(ctx), "create_dream_dross"))) or 0)) / H.jmath_spell_train_factor(ctx, 200)))), true) end
    else
        H.receive_item(H.u(ctx), "scrap_dreamdross", (1 + (0.5 * H.char_spell_level(H.npc(ctx), "create_dream_dross"))), nil)
        local _a22 = H.npc(ctx)
        if _a22 then services.spells.set_mana_raw(_a22, math.floor((H.char_mana(_a22, "current")) - (1000))) end
        local _a23 = H.npc(ctx)
        local _sg24 = H.safe_id("skill", "deduction")
        if _a23 and _sg24 then services.skills.set(_a23, _sg24, { exercise_raw = math.floor((H.char_skill_exp(_a23, "deduction", true)) + ((250 * services.gameplay.options.get_number("SKILL_TRAINING_SPEED")))) }) end
        local _a25 = H.npc(ctx)
        local _spg26 = H.safe_id("spell", "create_dream_dross")
        if _a25 and _spg26 then services.spells.set_experience(_a25, _spg26, math.floor((H.char_spell_exp(_a25, "create_dream_dross")) + ((((services.spells.experience_for_level(H.safe_id("spell", "create_dream_dross"), math.floor((H.char_spell_level(H.npc(ctx), "create_dream_dross") + 1))) or 0) - (services.spells.experience_for_level(H.safe_id("spell", "create_dream_dross"), math.floor(H.char_spell_level(H.npc(ctx), "create_dream_dross"))) or 0)) / H.jmath_spell_train_factor(ctx, 200)))), true) end
    end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_e76c503af014", function(ctx)
    H.receive_item(H.u(ctx), "scrap_dreamdross", services.random.native_float(1, 4), nil)
    if ((H.char_has_trait(H.npc(ctx), "THRESH_HOMULLUS") == 1) or (H.char_has_trait(H.npc(ctx), "THRESH_FAIR_FOLK_NOBLE") == 1)) then
        H.add_effect(H.npc(ctx), "effect_follower_summoned_dross", 432000)
    else
        H.add_effect(H.npc(ctx), "effect_follower_summoned_dross", 864000)
    end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_df03cb825851", function(ctx)
    if H.char_is_wearing(H.npc(ctx), "dream_attuning_necklace") then
        H.receive_item(H.u(ctx), "scrap_dreamdross", (3.5 + (0.5 * H.char_spell_level(H.npc(ctx), "create_dream_dross"))), nil)
        local _a27 = H.npc(ctx)
        if _a27 then services.spells.set_mana_raw(_a27, math.floor((H.char_mana(_a27, "current")) - (1000))) end
        local _a28 = H.npc(ctx)
        local _sg29 = H.safe_id("skill", "deduction")
        if _a28 and _sg29 then services.skills.set(_a28, _sg29, { exercise_raw = math.floor((H.char_skill_exp(_a28, "deduction", true)) + ((250 * services.gameplay.options.get_number("SKILL_TRAINING_SPEED")))) }) end
        local _a30 = H.npc(ctx)
        local _spg31 = H.safe_id("spell", "create_dream_dross")
        if _a30 and _spg31 then services.spells.set_experience(_a30, _spg31, math.floor((H.char_spell_exp(_a30, "create_dream_dross")) + ((((services.spells.experience_for_level(H.safe_id("spell", "create_dream_dross"), math.floor((H.char_spell_level(H.npc(ctx), "create_dream_dross") + 1))) or 0) - (services.spells.experience_for_level(H.safe_id("spell", "create_dream_dross"), math.floor(H.char_spell_level(H.npc(ctx), "create_dream_dross"))) or 0)) / H.jmath_spell_train_factor(ctx, 200)))), true) end
    else
        H.receive_item(H.u(ctx), "scrap_dreamdross", (1 + (0.5 * H.char_spell_level(H.npc(ctx), "create_dream_dross"))), nil)
        local _a32 = H.npc(ctx)
        if _a32 then services.spells.set_mana_raw(_a32, math.floor((H.char_mana(_a32, "current")) - (1000))) end
        local _a33 = H.npc(ctx)
        local _sg34 = H.safe_id("skill", "deduction")
        if _a33 and _sg34 then services.skills.set(_a33, _sg34, { exercise_raw = math.floor((H.char_skill_exp(_a33, "deduction", true)) + ((250 * services.gameplay.options.get_number("SKILL_TRAINING_SPEED")))) }) end
        local _a35 = H.npc(ctx)
        local _spg36 = H.safe_id("spell", "create_dream_dross")
        if _a35 and _spg36 then services.spells.set_experience(_a35, _spg36, math.floor((H.char_spell_exp(_a35, "create_dream_dross")) + ((((services.spells.experience_for_level(H.safe_id("spell", "create_dream_dross"), math.floor((H.char_spell_level(H.npc(ctx), "create_dream_dross") + 1))) or 0) - (services.spells.experience_for_level(H.safe_id("spell", "create_dream_dross"), math.floor(H.char_spell_level(H.npc(ctx), "create_dream_dross"))) or 0)) / H.jmath_spell_train_factor(ctx, 200)))), true) end
    end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_f3e3449167a9", function(ctx)
    H.set_var("global", nil, ctx, "npc_randomize_book_find_mission", services.random.native_int(0, H.round_half_away(3)))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_24bc083f4a9b", function(ctx)
    local _u37 = H.u(ctx)
    if _u37 then services.characters.adjust(_u37, { moves = -math.floor((services.random.native_float(60, (600 - (H.char_skill(H.u(ctx), "computer") * 5)))) * 100) }) end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_b157d4282aea", function(ctx)
    local _u38 = H.u(ctx)
    if _u38 then services.characters.adjust(_u38, { moves = -math.floor((services.random.native_float(30, (600 - (H.char_skill(H.u(ctx), "computer") * 2)))) * 100) }) end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_8bc82cf501b4", function(ctx)
    H.transform_radius(H.u(ctx), 3, "ter_local_metal_door_opening")
end)

ccb.runtime.handler("dlg_a_xedra_evolved_24a3c6481a26", function(ctx)
    H.transform_radius(H.u(ctx), 2, "ter_local_computer_shutdown")
    H.transform_radius(H.u(ctx), 3, "ter_local_metal_door_closing")
end)

ccb.runtime.handler("dlg_a_xedra_evolved_1d46c01e34bb", function(ctx)
    local _u39 = H.u(ctx)
    if _u39 then services.characters.adjust(_u39, { moves = -math.floor((services.random.native_float(60, (600 - (H.char_skill(H.u(ctx), "computer") * 5)))) * 100) }) end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_e63bbbe08795", function(ctx)
    local _u40 = H.u(ctx)
    if _u40 then services.characters.adjust(_u40, { moves = -math.floor((services.random.native_float(30, (600 - (H.char_skill(H.u(ctx), "computer") * 2)))) * 100) }) end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_5ada8748883b", function(ctx)
    H.transform_radius(H.u(ctx), 2, "ter_local_computer_shutdown")
    local _s41 = H.char_snap(H.u(ctx))
    if _s41 and _s41.creature then services.sound.emit(_s41.creature.position, math.floor(50), "alert", ctx:expand_text(services.translate("A loud alarm sounds!")), false) end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_5e49603d16bc", function(ctx)
    H.lose_trait(H.npc(ctx), "EGGSAC_SURVIVABLE")
    H.lose_trait(H.npc(ctx), "EGGSAC_FATAL")
end)

ccb.runtime.handler("dlg_a_xedra_evolved_de526d4c4753", function(ctx)
    if (H.char_has_trait(H.u(ctx), "VAMPIRE_MASTER_MORTAL_MIND_UPGRADE") == 1) then
        local _a42 = H.u(ctx)
        local _vg43 = H.safe_id("vitamin", "human_blood_vitamin")
        if _a42 and _vg43 then services.needs.modify_vitamin(_a42, _vg43, math.floor(-(50))) end
    else
        local _a44 = H.u(ctx)
        local _vg45 = H.safe_id("vitamin", "human_blood_vitamin")
        if _a44 and _vg45 then services.needs.modify_vitamin(_a44, _vg45, math.floor(-(100))) end
    end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_f1354bc7dded", function(ctx)
    if (H.char_has_trait(H.u(ctx), "VAMPIRE_MASTER_MORTAL_MIND_UPGRADE") == 1) then
        local _a46 = H.u(ctx)
        local _vg47 = H.safe_id("vitamin", "human_blood_vitamin")
        if _a46 and _vg47 then services.needs.modify_vitamin(_a46, _vg47, math.floor(-(250))) end
    else
        local _a48 = H.u(ctx)
        local _vg49 = H.safe_id("vitamin", "human_blood_vitamin")
        if _a48 and _vg49 then services.needs.modify_vitamin(_a48, _vg49, math.floor(-(500))) end
    end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_1f9c71875b83", function(ctx)
    if (H.char_has_trait(H.u(ctx), "VAMPIRE_MASTER_MORTAL_MIND_UPGRADE") == 1) then
        local _a50 = H.u(ctx)
        local _vg51 = H.safe_id("vitamin", "human_blood_vitamin")
        if _a50 and _vg51 then services.needs.modify_vitamin(_a50, _vg51, math.floor(-(1500))) end
    else
        local _a52 = H.u(ctx)
        local _vg53 = H.safe_id("vitamin", "human_blood_vitamin")
        if _a52 and _vg53 then services.needs.modify_vitamin(_a52, _vg53, math.floor(-(3000))) end
    end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_aa606712f66b", function(ctx)
    local _n54 = H.npc(ctx)
    if _n54 then services.characters.die(_n54) end
    services.messages.add(ctx:expand_text(services.translate("The mentor vanishes in a fine mist.")), "neutral")
end)

ccb.runtime.handler("dlg_a_xedra_evolved_53c17c81e090", function(ctx)
    local _n55 = H.npc(ctx)
    if _n55 then services.characters.die(_n55) end
    services.messages.add(ctx:expand_text(services.translate("The mentor vanishes in a fine mist.")), "neutral")
end)

ccb.runtime.handler("dlg_a_xedra_evolved_644c819c1395", function(ctx)
    H.learn_recipe(H.u(ctx), "xe_vampire_blood_gift_research")
    H.learn_recipe(H.u(ctx), "xe_vampire_blood_gift_refinement_research")
    H.learn_recipe(H.u(ctx), "xe_vampire_blood_weaknesses_reshuffle")
end)

ccb.runtime.handler("dlg_a_xedra_evolved_14594555e665", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You learn how to expand your blood gifts and how to change your vampiric weaknesses.")), "good")
end)

ccb.runtime.handler("dlg_a_xedra_evolved_ce0106b73c6d", function(ctx)
    H.receive_item(H.u(ctx), "vampire_mentor_book", 1, nil)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_c6ce859e7ff1", function(ctx)
    local _n56, _u57 = H.npc(ctx), H.u(ctx)
    if _n56 and _u57 then
        local _pay58 = services.trade.pay(_n56, _u57, math.floor(10000))
        if _pay58.ok and _pay58.value == true then
            H.receive_item(_u57, "vampire_mentor_book", 1, nil)
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_5c384dab2f0a", function(ctx)
    local _n59 = H.npc(ctx)
    if _n59 then services.characters.die(_n59) end
    services.messages.add(ctx:expand_text(services.translate("The mentor vanishes in a fine mist.")), "neutral")
end)

ccb.runtime.handler("dlg_a_xedra_evolved_0e28e28b2a89", function(ctx)
    local _n60 = H.npc(ctx)
    if _n60 then services.characters.die(_n60) end
    services.messages.add(ctx:expand_text(services.translate("The mentor vanishes in a fine mist.")), "neutral")
end)

ccb.runtime.handler("dlg_a_xedra_evolved_1a6836919060", function(ctx)
    H.add_morale(H.u(ctx), "morale_chat_uncaring", -10, -20, 7200, 3600)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_311733d56240", function(ctx)
    local _n61 = H.npc(ctx)
    if _n61 then services.characters.die(_n61) end
    ccb.presentation.notice(ctx:expand_text(services.translate("<npc_name> thanks you for the cure and departs.")))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_59715f55401e", function(ctx)
    local _n62 = H.npc(ctx)
    if _n62 then services.characters.die(_n62) end
    ccb.presentation.notice(ctx:expand_text(services.translate("<npc_name> reluctantly takes the cure and departs.")))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_a0f8c07ea720", function(ctx)
    H.add_proficiency_progress(H.npc(ctx), "prof_paraclesian_computer_understanding", 100, "percent", true, "+=")
end)

ccb.runtime.handler("dlg_a_xedra_evolved_c9aa1c3c2fda", function(ctx)
    H.add_proficiency_progress(H.npc(ctx), "prof_paraclesian_electronics_understanding", 100, "percent", true, "+=")
end)

ccb.runtime.handler("dlg_a_xedra_evolved_15ba983fa683", function(ctx)
    H.set_var("context", nil, ctx, "duration_lower_bound", (((908.54 + (H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") * 186.25)) + (H.char_skill(H.npc(ctx), "gramarye") * 385.43)) * (((H.global_var_num("global_what_is_the_season") == 3)) and (0.3) or (1))))
    H.set_var("context", nil, ctx, "duration_upper_bound", (((2448 + (H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") * 418.35)) + (H.char_skill(H.npc(ctx), "gramarye") * 985.15)) * (((H.global_var_num("global_what_is_the_season") == 3)) and (0.2) or (1))))
    local _a63 = H.npc(ctx)
    if _a63 then services.spells.set_mana_raw(_a63, math.floor((H.char_mana(_a63, "current")) - (math.max(((500 - (H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") * 4)) - (H.char_skill(H.npc(ctx), "gramarye") * 8)), 350)))) end
    H.add_effect(H.u(ctx), "effect_changeling_spring_prevent_bad_conditions", services.random.native_float((ctx:get_number("duration_lower_bound") or 0), (ctx:get_number("duration_upper_bound") or 0)))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_9f14d06f8544", function(ctx)
    H.set_var("context", nil, ctx, "duration_lower_bound", ((846.12 + (H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") * 129.52)) + (H.char_skill(H.npc(ctx), "gramarye") * 385.42)))
    H.set_var("context", nil, ctx, "duration_upper_bound", ((1685.24 + (H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") * 348.15)) + (H.char_skill(H.npc(ctx), "gramarye") * 898.51)))
    local _a64 = H.npc(ctx)
    if _a64 then services.spells.set_mana_raw(_a64, math.floor((H.char_mana(_a64, "current")) - (math.max(((800 - (H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") * 8)) - (H.char_skill(H.npc(ctx), "gramarye") * 15)), 450)))) end
    H.add_effect(H.u(ctx), "effect_changeling_spring_healing_increase_while_outside", services.random.native_float((ctx:get_number("duration_lower_bound") or 0), (ctx:get_number("duration_upper_bound") or 0)))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_545c60862204", function(ctx)
    local _a65 = H.u(ctx)
    local _vg66 = H.safe_id("vitamin", "human_blood_vitamin")
    if _a65 and _vg66 then services.needs.modify_vitamin(_a65, _vg66, math.floor(-(150))) end
    H.set_var("context", nil, ctx, "vampire_hypnotic_gaze_power_level", (((((2 + (H.jmath_vampire_total_tier_one_traits_plus_potency(ctx) * 0.5)) + (H.jmath_vampire_total_tier_two_traits(ctx) * 0.75)) + (H.jmath_vampire_total_tier_three_traits(ctx) * 1.2)) + (H.jmath_vampire_total_tier_four_traits_plus_potence(ctx) * 2.5)) + (H.jmath_vampire_total_tier_five_traits_plus_cauldron(ctx) * 3.5)))
    H.add_effect(H.npc(ctx), "effect_vampire_hypnotism", (ctx:get_number("vampire_hypnotic_gaze_power_level") or 0))
    H.add_effect(H.npc(ctx), "dazed", (ctx:get_number("vampire_hypnotic_gaze_power_level") or 0))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_72b8fc8b39b8", function(ctx)
    local _a67 = H.u(ctx)
    if _a67 then services.spells.set_mana_raw(_a67, math.floor((H.char_mana(_a67, "current")) - (math.max(((300 - (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 4)) - (H.char_skill(H.u(ctx), "gramarye") * 7)), 150)))) end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_50775eaa3d7a", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The glamour fails to take hold!")), "bad")
    local _a68 = H.u(ctx)
    if _a68 then services.spells.set_mana_raw(_a68, math.floor((H.char_mana(_a68, "current")) - (math.max(((300 - (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 4)) - (H.char_skill(H.u(ctx), "gramarye") * 7)), 150)))) end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_08365a1060b5", function(ctx)
    local _a69 = H.u(ctx)
    local _vg70 = H.safe_id("vitamin", "human_blood_vitamin")
    if _a69 and _vg70 then services.needs.modify_vitamin(_a69, _vg70, math.floor(-(150))) end
    H.set_var("context", nil, ctx, "vampire_hypnotic_gaze_power_level", (((((2 + (H.jmath_vampire_total_tier_one_traits_plus_potency(ctx) * 0.5)) + (H.jmath_vampire_total_tier_two_traits(ctx) * 0.75)) + (H.jmath_vampire_total_tier_three_traits(ctx) * 1.2)) + (H.jmath_vampire_total_tier_four_traits_plus_potence(ctx) * 2.5)) + (H.jmath_vampire_total_tier_five_traits_plus_cauldron(ctx) * 3.5)))
    H.add_effect(H.npc(ctx), "effect_vampire_hypnotism", (ctx:get_number("vampire_hypnotic_gaze_power_level") or 0))
    H.add_effect(H.npc(ctx), "dazed", (ctx:get_number("vampire_hypnotic_gaze_power_level") or 0))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_bdceae3aaeee", function(ctx)
    local _n71 = H.npc(ctx)
    if _n71 then services.characters.die(_n71) end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_fbe7cdc8fe88", function(ctx)
    local _n72 = H.npc(ctx)
    if _n72 then services.characters.die(_n72) end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_87ec93251ecd", function(ctx)
    local _n73 = H.npc(ctx)
    if _n73 then services.characters.die(_n73) end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_9addf16f3519", function(ctx)
    local _n74 = H.npc(ctx)
    if _n74 then services.characters.die(_n74) end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_437c7ccacbd1", function(ctx)
    local _n75 = H.npc(ctx)
    if _n75 then services.characters.die(_n75) end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_222ea183fbd2", function(ctx)
    H.set_var("global", nil, ctx, "sold_arvore_sample_to_bloodthorne_hunter", (H.global_var_num("sold_arvore_sample_to_bloodthorne_hunter")) + 1)
    local _sw76 = H.global_var_num("sold_arvore_sample_to_bloodthorne_hunter")
    if _sw76 == 1 then
        H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + 1)
    elseif _sw76 == 2 then
        if (H.global_var_num("owed_help_from_bloodthorne_transaction") > 1) then
            H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + 1)
            H.set_var("global", nil, ctx, "owed_help_from_bloodthorne_transaction", (H.global_var_num("owed_help_from_bloodthorne_transaction")) - (2))
        else
            H.set_var("global", nil, ctx, "owed_help_from_bloodthorne_transaction", (H.global_var_num("owed_help_from_bloodthorne_transaction")) + 1)
        end
    elseif _sw76 == 6 then
        if (H.global_var_num("owed_help_from_bloodthorne_transaction") > 2) then
            H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + 1)
            H.set_var("global", nil, ctx, "owed_help_from_bloodthorne_transaction", (H.global_var_num("owed_help_from_bloodthorne_transaction")) - (3))
        else
            H.set_var("global", nil, ctx, "owed_help_from_bloodthorne_transaction", (H.global_var_num("owed_help_from_bloodthorne_transaction")) + 1)
        end
    end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_c270fbcc5a33", function(ctx)
    H.set_var("global", nil, ctx, "sold_arvore_sample_to_bloodthorne_hunter", (H.global_var_num("sold_arvore_sample_to_bloodthorne_hunter")) + (5))
    local _sw77 = H.global_var_num("sold_arvore_sample_to_bloodthorne_hunter")
    if _sw77 == 5 then
        H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + (3))
    elseif _sw77 == 6 then
        H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + (2))
        H.set_var("global", nil, ctx, "owed_help_from_bloodthorne_transaction", (H.global_var_num("owed_help_from_bloodthorne_transaction")) + 1)
    elseif _sw77 == 7 then
        H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + (2))
        H.set_var("global", nil, ctx, "owed_help_from_bloodthorne_transaction", (H.global_var_num("owed_help_from_bloodthorne_transaction")) + (2))
    elseif _sw77 == 8 then
        H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + (2))
    elseif _sw77 == 9 then
        H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + (1))
        H.set_var("global", nil, ctx, "owed_help_from_bloodthorne_transaction", (H.global_var_num("owed_help_from_bloodthorne_transaction")) + (2))
    elseif _sw77 == 10 then
        if (H.global_var_num("owed_help_from_bloodthorne_transaction") > 0) then
            H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + (2))
            H.set_var("global", nil, ctx, "owed_help_from_bloodthorne_transaction", (H.global_var_num("owed_help_from_bloodthorne_transaction")) - 1)
        else
            H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + 1)
            H.set_var("global", nil, ctx, "owed_help_from_bloodthorne_transaction", (H.global_var_num("owed_help_from_bloodthorne_transaction")) + (2))
        end
    end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_1dee5cbf43dc", function(ctx)
    H.set_var("global", nil, ctx, "sold_arvore_sample_to_bloodthorne_hunter", (H.global_var_num("sold_arvore_sample_to_bloodthorne_hunter")) + (10))
    local _sw78 = H.global_var_num("sold_arvore_sample_to_bloodthorne_hunter")
    if _sw78 == 10 then
        H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + (4))
        H.set_var("global", nil, ctx, "owed_help_from_bloodthorne_transaction", (H.global_var_num("owed_help_from_bloodthorne_transaction")) + (2))
    elseif _sw78 == 11 then
        H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + (4))
    elseif _sw78 == 12 then
        H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + (3))
        H.set_var("global", nil, ctx, "owed_help_from_bloodthorne_transaction", (H.global_var_num("owed_help_from_bloodthorne_transaction")) + (2))
    elseif _sw78 == 15 then
        if (H.global_var_num("owed_help_from_bloodthorne_transaction") > 1) then
            H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + (4))
            H.set_var("global", nil, ctx, "owed_help_from_bloodthorne_transaction", (H.global_var_num("owed_help_from_bloodthorne_transaction")) - (2))
        else
            H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + (3))
            H.set_var("global", nil, ctx, "owed_help_from_bloodthorne_transaction", (H.global_var_num("owed_help_from_bloodthorne_transaction")) + 1)
        end
    end
end)

ccb.runtime.handler("dlg_a_xedra_evolved_39dc5675bdd6", function(ctx)
    H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + (3))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_9f27406266ec", function(ctx)
    local _n79, _u80 = H.npc(ctx), H.u(ctx)
    if _n79 and _u80 then services.trade.pay(_n79, _u80, math.floor(-2000)) end
    H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) - 1)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_7496547b9515", function(ctx)
    H.set_var("global", nil, ctx, "Vampire_Hunter_Quest_Completed", (H.global_var_num("Vampire_Hunter_Quest_Completed")) + 1)
    H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + (3))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_89e264286fdb", function(ctx)
    H.set_var("global", nil, ctx, "Vampire_Hunter_Quest_Completed", (H.global_var_num("Vampire_Hunter_Quest_Completed")) + 1)
    H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + (5))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_c41a938df19b", function(ctx)
    H.set_var("global", nil, ctx, "Vampire_Hunter_Quest_Completed", (H.global_var_num("Vampire_Hunter_Quest_Completed")) + 1)
    H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + (6))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_b061925b133f", function(ctx)
    H.set_var("global", nil, ctx, "Vampire_Hunter_Quest_Completed", (H.global_var_num("Vampire_Hunter_Quest_Completed")) + 1)
    H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + (7))
end)

ccb.runtime.handler("dlg_a_xedra_evolved_e534fc391cd7", function(ctx)
    H.set_var("global", nil, ctx, "Vampire_Hunter_Quest_Accepted", (H.global_var_num("Vampire_Hunter_Quest_Accepted")) + 1)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_1006266a91d6", function(ctx)
    H.set_var("global", nil, ctx, "Vampire_Hunter_Quest_Accepted", (H.global_var_num("Vampire_Hunter_Quest_Accepted")) + 1)
    H.receive_item(H.u(ctx), "blood_treatment", 1, "bottle_plastic")
end)

ccb.runtime.handler("dlg_a_xedra_evolved_d4fff8570f2a", function(ctx)
    H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) - 1)
    H.receive_item(H.u(ctx), "jerky", 5, nil)
end)

ccb.runtime.handler("dlg_a_xedra_evolved_26f5e04b6fdb", function(ctx)
    local _n81, _u82 = H.npc(ctx), H.u(ctx)
    if _n81 and _u82 then services.trade.pay(_n81, _u82, math.floor(-2500)) end
    H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) - 1)
end)

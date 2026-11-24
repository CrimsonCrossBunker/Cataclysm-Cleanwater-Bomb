local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

if H._jm_vampire_bloodthorne_maximal_cure_damage == nil then
H._jm_vampire_bloodthorne_maximal_cure_damage = function(ctx)
    return ((((((H.char_has_trait(H.u(ctx), "VAMPIRE") * 20) + (H.char_has_trait(H.u(ctx), "VAMPIRE2") * 20)) + (H.char_has_trait(H.u(ctx), "VAMPIRE3") * 20)) + H._jm_vampire_total_tier_one_traits(ctx)) + (H._jm_vampire_total_tier_two_traits(ctx) * 2)) + (H._jm_vampire_total_tier_three_traits(ctx) * 3))
end
end
if H._jm_vampire_total_tier_one_traits == nil then
H._jm_vampire_total_tier_one_traits = function(ctx)
    return ((((((((((H.char_has_trait(H.u(ctx), "EYEGLEAM") + H.char_has_trait(H.u(ctx), "BLOOD_FUN")) + H.char_has_trait(H.u(ctx), "STAMINAFORBLOOD")) + H.char_has_trait(H.u(ctx), "COMMUNE_NIGHT")) + H.char_has_trait(H.u(ctx), "VAMPIRIC_STRENGTH")) + H.char_has_trait(H.u(ctx), "VAMPIRIC_RESILIENCE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_HEIGHTENED_SENSES")) + H.char_has_trait(H.u(ctx), "VAMPIRE_HEALTH_BONUS")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SENSE_CHILDREN_OF_THE_NIGHT")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SILENT_MOVE")) + H.char_has_trait(H.u(ctx), "DHAMPIR_REDUCED_COLD_TEMPS"))
end
end
if H._jm_vampire_total_tier_three_traits == nil then
H._jm_vampire_total_tier_three_traits = function(ctx)
    return ((((((((((((((H.char_has_trait(H.u(ctx), "BLOODHASTE") + H.char_has_trait(H.u(ctx), "HYPNOTIC_GAZE")) + H.char_has_trait(H.u(ctx), "MAGICFORBLOOD")) + H.char_has_trait(H.u(ctx), "VAMPIRE_COMMAND_BEAST")) + H.char_has_trait(H.u(ctx), "VAMPIRE_EARTH_SLUMBER")) + H.char_has_trait(H.u(ctx), "VAMPIRE_CARDIO_BONUS")) + H.char_has_trait(H.u(ctx), "VAMPIRE_MOTION_ALARM")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BONUS_HP")) + H.char_has_trait(H.u(ctx), "VAMPIRE_STORE_MORE_BLOOD")) + H.char_has_trait(H.u(ctx), "VAMPIRE_INSTANT_BLEED")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BIG_STOMACH")) + H.char_has_trait(H.u(ctx), "VAMPIRE_DETECT_VAMPIRES")) + H.char_has_trait(H.u(ctx), "DHAMPIR_REDUCED_PAIN")) + H.char_has_trait(H.u(ctx), "DHAMPIR_MEND_WOUNDS_FASTER")) + H.char_has_trait(H.u(ctx), "DHAMPIR_AVOID_EAT_SLEEP_DRINK"))
end
end
if H._jm_vampire_total_tier_two_traits == nil then
H._jm_vampire_total_tier_two_traits = function(ctx)
    return (((((((((((((((((H.char_has_trait(H.u(ctx), "BLOODHEAL") + H.char_has_trait(H.u(ctx), "COAGULANTWEAVE")) + H.char_has_trait(H.u(ctx), "VAMPIRIC_DODGE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_FEAR_GAZE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_WALK_ON_WALLS")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BEAST_CLAWS")) + H.char_has_trait(H.u(ctx), "VAMPIRIC_STEALTH_BONUS")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SEE_HEAT")) + H.char_has_trait(H.u(ctx), "VAMPIRE_FEIGN_DEATH")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BLOOD_TEMPORARY_BOOST")) + H.char_has_trait(H.u(ctx), "EYEGLEAM_UPGRADE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SEE_THROUGH_NIGHT_EYES")) + H.char_has_trait(H.u(ctx), "BLOOD_FUN_UPGRADE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SILENT_MOVE_UPGRADE")) + H.char_has_trait(H.u(ctx), "DHAMPIR_FANGS")) + H.char_has_trait(H.u(ctx), "DHAMPIR_SLOWFALL")) + H.char_has_trait(H.u(ctx), "DHAMPIR_RESIST_DISEASE_POISON_INFECTION")) + H.char_has_trait(H.u(ctx), "DHAMPIR_BLACKEN_SOUL_ARION"))
end
end

ccb.runtime.handler("w16b_p_xedra_evolved_a36fde5af7fe", function(ctx)
    return (H.global_var_num("human_blood_vitamin") > 0)
end)
ccb.runtime.handler("w16b_p_xedra_evolved_f917d87baf9c", function(ctx)
    return ((H.global_var_num("human_blood_vitamin") < 1) and (H.char_hp(H.u(ctx), "head", false) >= H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)) and (H.char_hp(H.u(ctx), "torso", false) >= H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)) and (H.char_hp(H.u(ctx), "arm_l", false) >= H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)) and (H.char_hp(H.u(ctx), "arm_r", false) >= H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)) and (H.char_hp(H.u(ctx), "leg_l", false) >= H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)) and (H.char_hp(H.u(ctx), "leg_r", false) >= H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)))
end)
ccb.runtime.handler("w16b_p_xedra_evolved_8a7c92bf3c2d", function(ctx)
    return ((H.global_var_num("human_blood_vitamin") < 1) and ((H.char_hp(H.u(ctx), "head", false) < H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)) or (H.char_hp(H.u(ctx), "torso", false) < H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)) or (H.char_hp(H.u(ctx), "arm_l", false) < H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)) or (H.char_hp(H.u(ctx), "arm_r", false) < H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)) or (H.char_hp(H.u(ctx), "leg_l", false) < H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)) or (H.char_hp(H.u(ctx), "leg_r", false) < H._jm_vampire_bloodthorne_maximal_cure_damage(ctx))))
end)
ccb.runtime.handler("w16b_p_xedra_evolved_952e7812cbf7", function(ctx)
    return (H.global_var_num("vampire_hunters_owed_help") > 0)
end)
ccb.runtime.handler("w16b_p_xedra_evolved_e23f13094bcb", function(ctx)
    return (H.global_var_num("vampire_hunters_owed_help") < 1)
end)
ccb.runtime.handler("w16b_p_xedra_evolved_bd4c4a567679", function(ctx)
    return (H.global_var_num("vampire_hunters_owed_help") >= 1)
end)
ccb.runtime.handler("w16b_p_xedra_evolved_dfec4b4de226", function(ctx)
    return (H.global_var_num("vampire_hunters_owed_help") > 1)
end)
ccb.runtime.handler("w16b_a_xedra_evolved_db67e96e1c73", function(ctx)
    H.run_eoc("EOC_CHANGELING_SUMMER_PROTECT_FROM_HOT_WEATHER", ctx, nil, "u", nil)
    local _a1 = H.npc(ctx)
    if _a1 then services.spells.set_mana_raw(_a1, math.floor((H.char_mana(_a1, "current")) - (math.max(((250 - (H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER") * 2)) - (H.char_skill(H.npc(ctx), "gramarye") * 4.5)), 100)))) end
end)
ccb.runtime.handler("w16b_a_xedra_evolved_b286adc5eda4", function(ctx)
    H.run_eoc("EOC_LILIN_RUACH_DRAIN_DIALOGUE", ctx, nil, "npc", services.characters.avatar())
end)
ccb.runtime.handler("w16b_a_xedra_evolved_e185a1582968", function(ctx)
    H.run_eoc("EOC_BLOODTHORNE_DRUID_PURGE_VAMPIRISM_IN_OTHER", ctx, nil, services.characters.avatar(), nil)
end)
ccb.runtime.handler("w16b_a_xedra_evolved_11c9ecaecc8c", function(ctx)
    H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + (10))
end)
ccb.runtime.handler("w16b_a_xedra_evolved_3a02bfb200e3", function(ctx)
    H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + (3))
end)
ccb.runtime.handler("w16b_a_xedra_evolved_d9fb058089f3", function(ctx)
    if H.u(ctx) then services.characters.adjust(H.u(ctx), { cash = -math.floor(2000) }) end
end)
ccb.runtime.handler("w16b_a_xedra_evolved_067e0015be5d", function(ctx)
    H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) - (1))
    H.eoc_spawn_item(H.u(ctx), "blood_treatment", 3, false, false, "bottle_plastic")
end)
ccb.runtime.handler("w16b_a_xedra_evolved_79c405cd4be8", function(ctx)
    H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) - (1))
end)
ccb.runtime.handler("w16b_a_xedra_evolved_fa5f4419f53a", function(ctx)
    H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) - (2))
end)
ccb.runtime.handler("w16b_a_xedra_evolved_cf46f00fa379", function(ctx)
    if H.u(ctx) then services.characters.adjust(H.u(ctx), { cash = -math.floor(-2000) }) end
    H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) - (1))
end)
ccb.runtime.handler("w16b_a_xedra_evolved_c68b966624c1", function(ctx)
    H.run_eoc("EOC_VAMPIRE_HUNTERS_PERMA_HOSTILE", ctx, nil, nil, nil)
end)

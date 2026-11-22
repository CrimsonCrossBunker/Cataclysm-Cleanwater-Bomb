local ccb = require("ccb")
local services = ccb.services

local function safe_id(kind, name)
    local ok, gid = pcall(services.types.id, kind, name)
    if not ok then
        return nil
    end
    return gid
end

local function char_stat(actor, field)
    if not actor then
        return 0
    end
    local r = services.characters.snapshot(actor)
    if not r.ok then
        return 0
    end
    return r.value.stats[field] or 0
end

local function char_speed(actor)
    if not actor then
        return 0
    end
    local r = services.characters.snapshot(actor)
    if not r.ok then
        return 0
    end
    return r.value.movement.speed or 0
end

local function char_skill(actor, skill_id)
    if not actor then
        return 0
    end
    local r = services.skills.level(actor, skill_id)
    if not r.ok then
        return 0
    end
    return r.value or 0
end

local function char_spell_level(actor, spell_id)
    if not actor then
        return -1
    end
    local r = services.spells.effective_level(actor, spell_id)
    if not r.ok or r.value == nil then
        return -1
    end
    return r.value
end

local function char_spell_count(actor, school_id)
    if not actor then
        return 0
    end
    local gid = nil
    if school_id and school_id ~= "" then
        gid = safe_id("mutation", school_id)
        if not gid then
            return 0
        end
    end
    local r = services.spells.count(actor, gid)
    if not r.ok then
        return 0
    end
    return r.value or 0
end

local function char_has_trait(actor, trait_id)
    if not actor then
        return 0
    end
    local r = services.mutations.has_id_text(actor, trait_id)
    if not r.ok or not r.value then
        return 0
    end
    return 1
end

local function char_sum_traits_cat(actor, category_id, count_type)
    if not actor then
        return 0
    end
    local gid = safe_id("mutation_category", category_id)
    if not gid then
        return 0
    end
    local r = services.mutations.category_count(actor, gid, count_type or "ALL", true)
    if not r.ok then
        return 0
    end
    return r.value or 0
end

local function char_vitamin(actor, vitamin_id)
    if not actor then
        return 0
    end
    local gid = safe_id("vitamin", vitamin_id)
    if not gid then
        return 0
    end
    local r = services.needs.get_vitamin(actor, gid)
    if not r.ok then
        return 0
    end
    return r.value or 0
end

local function creature_effect_intensity(actor, effect_id, body_part)
    if not actor then
        return -1
    end
    local gid = safe_id("effect", effect_id)
    if not gid then
        return -1
    end
    local r
    if body_part then
        local bp_gid = safe_id("body_part", body_part)
        if not bp_gid then
            return -1
        end
        r = services.effects.exact_intensity(actor, gid, bp_gid)
    else
        r = services.effects.exact_intensity(actor, gid)
    end
    if not r.ok or r.value == nil then
        return -1
    end
    return r.value
end

local function creature_has_effect(actor, effect_id, body_part)
    if not actor then
        return false
    end
    local gid = safe_id("effect", effect_id)
    if not gid then
        return false
    end
    local r
    if body_part then
        local bp_gid = safe_id("body_part", body_part)
        if not bp_gid then
            return false
        end
        r = services.effects.has(actor, gid, bp_gid)
    else
        r = services.effects.has(actor, gid)
    end
    return r.ok and r.value == true
end

local function char_proficiency_pct(actor, prof_id)
    if not actor then
        return 0
    end
    local gid = safe_id("proficiency", prof_id)
    if not gid then
        return 0
    end
    local r = services.proficiencies.get(actor, gid)
    if not r.ok or not r.value then
        return 0
    end
    return (r.value.practice or 0) * 100
end

local function get_actor_var_num(actor, key)
    if not actor then
        return 0
    end
    local r = services.variables.get_number(actor, key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then
        return 0
    end
    return r.value.value
end

local function get_global_var_num(key)
    local r = services.variables.get_global_number(key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then
        return 0
    end
    return r.value.value
end

local MOON_PHASE_INDEX = {
    new = 0,
    waxing_crescent = 1,
    waxing_half = 2,
    waxing_gibbous = 3,
    full = 4,
    waning_gibbous = 5,
    waning_half = 6,
    waning_crescent = 7,
}
local function current_moon_phase_index()
    return MOON_PHASE_INDEX[services.time.now():moon_phase()] or 0
end

local function weather_temp_kelvin()
    return (services.weather_snapshot().temperature_c or 0) + 273.15
end

local function creature_is_outside(actor)
    if not actor then
        return false
    end
    local r = services.creatures.snapshot(actor)
    return r.ok and r.value.outside == true
end

local function creature_has_species(actor, species_id)
    if not actor then
        return false
    end
    local gid = safe_id("species", species_id)
    if not gid then
        return false
    end
    local r = services.creatures.has_species(actor, gid)
    return r.ok and r.value == true
end

local function char_has_item(actor, item_id)
    if not actor then
        return false
    end
    local gid = safe_id("item", item_id)
    if not gid then
        return false
    end
    local r = services.inventory.has_type(actor, gid)
    return r.ok and r.value == true
end

local function creature_on_terrain_flag(actor, flag_id)
    if not actor then
        return false
    end
    local r = services.creatures.snapshot(actor)
    if not r.ok then
        return false
    end
    return services.gameplay.environment.terrain_has_flag(r.value.position, flag_id)
end

local function creature_on_terrain(actor, ter_id)
    if not actor then
        return false
    end
    local r = services.creatures.snapshot(actor)
    if not r.ok then
        return false
    end
    return services.gameplay.environment.terrain_id(r.value.position) == ter_id
end

local function jmath_lucid_dreaming_proficiency_modifier(payload)
    return (1 + ((char_proficiency_pct(payload.speaker, "prof_lucid_dreaming") / 1000) * 3))
end

local function jmath_eater_level(payload, _0)
    return ((char_stat(payload.speaker, "strength") + char_stat(payload.speaker, "dexterity")) * _0)
end

local function jmath_dreamer_level(payload, _0)
    return ((char_stat(payload.speaker, "intelligence") + char_stat(payload.speaker, "perception")) * _0)
end

local function jmath_scaling_factor(payload, _0)
    return ((_0 + 10) / 20)
end

local function jmath_paraclesian_post_threshold_doubler(payload, _0)
    return (_0 + (1 * (((((char_has_trait(payload.speaker, "THRESH_ARVORE") + char_has_trait(payload.speaker, "THRESH_IERDE")) + char_has_trait(payload.speaker, "THRESH_HOMULLUS")) + char_has_trait(payload.speaker, "THRESH_SALAMANDER")) + char_has_trait(payload.speaker, "THRESH_SYLPH")) + char_has_trait(payload.speaker, "THRESH_UNDINE"))))
end

local function jmath_int_to_level(payload, _0)
    return ((char_stat(payload.speaker, "intelligence") * 1.5) * _0)
end

local function jmath_str_to_level(payload, _0)
    return ((char_stat(payload.speaker, "strength") * 1.5) * _0)
end

local function jmath_per_to_level(payload, _0)
    return ((char_stat(payload.speaker, "perception") * 1.5) * _0)
end

local function jmath_dex_to_level(payload, _0)
    return ((char_stat(payload.speaker, "dexterity") * 1.5) * _0)
end

local function jmath_vampire_total_tier_one_traits(payload)
    return ((((((((((char_has_trait(payload.speaker, "EYEGLEAM") + char_has_trait(payload.speaker, "BLOOD_FUN")) + char_has_trait(payload.speaker, "STAMINAFORBLOOD")) + char_has_trait(payload.speaker, "COMMUNE_NIGHT")) + char_has_trait(payload.speaker, "VAMPIRIC_STRENGTH")) + char_has_trait(payload.speaker, "VAMPIRIC_RESILIENCE")) + char_has_trait(payload.speaker, "VAMPIRE_HEIGHTENED_SENSES")) + char_has_trait(payload.speaker, "VAMPIRE_HEALTH_BONUS")) + char_has_trait(payload.speaker, "VAMPIRE_SENSE_CHILDREN_OF_THE_NIGHT")) + char_has_trait(payload.speaker, "VAMPIRE_SILENT_MOVE")) + char_has_trait(payload.speaker, "DHAMPIR_REDUCED_COLD_TEMPS"))
end

local function jmath_vampire_total_tier_two_traits(payload)
    return (((((((((((((((((char_has_trait(payload.speaker, "BLOODHEAL") + char_has_trait(payload.speaker, "COAGULANTWEAVE")) + char_has_trait(payload.speaker, "VAMPIRIC_DODGE")) + char_has_trait(payload.speaker, "VAMPIRE_FEAR_GAZE")) + char_has_trait(payload.speaker, "VAMPIRE_WALK_ON_WALLS")) + char_has_trait(payload.speaker, "VAMPIRE_BEAST_CLAWS")) + char_has_trait(payload.speaker, "VAMPIRIC_STEALTH_BONUS")) + char_has_trait(payload.speaker, "VAMPIRE_SEE_HEAT")) + char_has_trait(payload.speaker, "VAMPIRE_FEIGN_DEATH")) + char_has_trait(payload.speaker, "VAMPIRE_BLOOD_TEMPORARY_BOOST")) + char_has_trait(payload.speaker, "EYEGLEAM_UPGRADE")) + char_has_trait(payload.speaker, "VAMPIRE_SEE_THROUGH_NIGHT_EYES")) + char_has_trait(payload.speaker, "BLOOD_FUN_UPGRADE")) + char_has_trait(payload.speaker, "VAMPIRE_SILENT_MOVE_UPGRADE")) + char_has_trait(payload.speaker, "DHAMPIR_FANGS")) + char_has_trait(payload.speaker, "DHAMPIR_SLOWFALL")) + char_has_trait(payload.speaker, "DHAMPIR_RESIST_DISEASE_POISON_INFECTION")) + char_has_trait(payload.speaker, "DHAMPIR_BLACKEN_SOUL_ARION"))
end

local function jmath_vampire_total_tier_three_traits(payload)
    return ((((((((((((((char_has_trait(payload.speaker, "BLOODHASTE") + char_has_trait(payload.speaker, "HYPNOTIC_GAZE")) + char_has_trait(payload.speaker, "MAGICFORBLOOD")) + char_has_trait(payload.speaker, "VAMPIRE_COMMAND_BEAST")) + char_has_trait(payload.speaker, "VAMPIRE_EARTH_SLUMBER")) + char_has_trait(payload.speaker, "VAMPIRE_CARDIO_BONUS")) + char_has_trait(payload.speaker, "VAMPIRE_MOTION_ALARM")) + char_has_trait(payload.speaker, "VAMPIRE_BONUS_HP")) + char_has_trait(payload.speaker, "VAMPIRE_STORE_MORE_BLOOD")) + char_has_trait(payload.speaker, "VAMPIRE_INSTANT_BLEED")) + char_has_trait(payload.speaker, "VAMPIRE_BIG_STOMACH")) + char_has_trait(payload.speaker, "VAMPIRE_DETECT_VAMPIRES")) + char_has_trait(payload.speaker, "DHAMPIR_REDUCED_PAIN")) + char_has_trait(payload.speaker, "DHAMPIR_MEND_WOUNDS_FASTER")) + char_has_trait(payload.speaker, "DHAMPIR_AVOID_EAT_SLEEP_DRINK"))
end

local function jmath_vampire_total_tier_four_traits(payload)
    return ((((((((((((char_has_trait(payload.speaker, "TRUE_VAMPIRE_POWER") + char_has_trait(payload.speaker, "VAMPIRE_TORPOR")) + char_has_trait(payload.speaker, "VAMPIRE_DOMINATE")) + char_has_trait(payload.speaker, "VAMPIRE_NO_BREATHE")) + char_has_trait(payload.speaker, "VAMPIRE_NO_ILLNESS")) + char_has_trait(payload.speaker, "VAMPIRE_BAT_FORM")) + char_has_trait(payload.speaker, "VAMPIRE_WOLF_FORM")) + char_has_trait(payload.speaker, "VAMPIRE_MIST_FORM")) + char_has_trait(payload.speaker, "VAMPIRE_STORE_MORE_BLOOD_UPGRADE")) + char_has_trait(payload.speaker, "VAMPIRE_INVISIBLE_IN_DARK")) + char_has_trait(payload.speaker, "VAMPIRE_NO_ILLNESS_UPGRADE")) + char_has_trait(payload.speaker, "VAMPIRE_FORM_UPGRADE")) + char_has_trait(payload.speaker, "VAMPIRE_BLOOD_FOR_POTENCY"))
end

local function jmath_bloodthorn_druid_traits_sum(payload)
    return (((((((((((char_has_trait(payload.speaker, "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT") + char_has_trait(payload.speaker, "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_WHIP")) + char_has_trait(payload.speaker, "BLOODTHORNE_DRUID_REGAIN_BLOOD")) + char_has_trait(payload.speaker, "BLOODTHORNE_DRUID_BONUS_MANA_REGEN")) + char_has_trait(payload.speaker, "BLOODTHORNE_DRUID_PREVENT_VAMPIRISM")) + char_has_trait(payload.speaker, "BLOODTHORNE_DRUID_STOP_BLEEDING")) + char_has_trait(payload.speaker, "BLOODTHORNE_DRUID_WHIP_TARGETS_IN_NATURE")) + char_has_trait(payload.speaker, "BLOODTHORNE_DRUID_REDUCED_PAIN_PENALTIES")) + char_has_trait(payload.speaker, "BLOODTHORNE_DRUID_HEAL_FROM_SPILLED_BLOOD")) + char_has_trait(payload.speaker, "BLOODTHORNE_DRUID_SUMMON_THORNHOUND")) + char_has_trait(payload.speaker, "BLOODTHORNE_DRUID_SLOWER_BLEEDING")) + char_has_trait(payload.speaker, "BLOODTHORNE_DRUID_CREATE_THORN_PRISON"))
end

local function jmath_xedra_chron_spell_calc(payload, _0, _1, _2)
    return (((_0 * _1) + _2) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end

local function jmath_xedra_chronomancer_level(payload, _0)
    return ((2 * char_stat(payload.speaker, "intelligence")) * _0)
end

local function jmath_lilin_has_ruach_efficiency(payload)
    return (1 - math.min((((char_has_trait(payload.speaker, "LILIN_RUACH_EFFICIENCY") * 0.15) + (char_has_trait(payload.speaker, "LILIN_RUACH_EFFICIENCY_UPGRADE") * 0.15)) + (char_has_trait(payload.speaker, "LILIN_RUACH_EFFICIENCY_UPGRADE") * math.max(((char_vitamin(payload.speaker, "lilin_ruach_vitamin") - 3500) / 12000), 0))), 0.33))
end

local function jmath_vampire_total_tier_one_traits_plus_potency(payload)
    return (jmath_vampire_total_tier_one_traits(payload) + creature_effect_intensity(payload.speaker, "effect_player_anathema_potency_boost"))
end

local function jmath_vampire_total_tier_four_traits_plus_potence(payload)
    return (jmath_vampire_total_tier_four_traits(payload) + (char_has_trait(payload.speaker, "TRUE_VAMPIRE_POWER") * 5))
end

local function jmath_vampire_total_tier_five_traits(payload)
    return ((((((((((char_has_trait(payload.speaker, "VAMPIRE_MASTER_MORTAL_MIND") + char_has_trait(payload.speaker, "VAMPIRE_DISTILLATE_INNER_BLOOD")) + char_has_trait(payload.speaker, "VAMPIRE_SHADOW_FORM")) + char_has_trait(payload.speaker, "VAMPIRE_LAST_BREATH_MIST")) + char_has_trait(payload.speaker, "VAMPIRE_IRON_MIND")) + char_has_trait(payload.speaker, "VAMPIRE_BLIND_THE_SUN")) + char_has_trait(payload.speaker, "VAMPIRE_HEAL_IN_DARK")) + char_has_trait(payload.speaker, "VAMPIRE_DRINK_VAMPIRE_BLOOD")) + char_has_trait(payload.speaker, "VAMPIRE_GAIN_BLOOD_GIFTS")) + char_has_trait(payload.speaker, "VAMPIRE_LAST_BREATH_MIST_UPGRADE")) + char_has_trait(payload.speaker, "VAMPIRE_MASTER_MORTAL_MIND_UPGRADE"))
end

local function jmath_vampire_total_tier_five_traits_plus_cauldron(payload)
    return (jmath_vampire_total_tier_five_traits(payload) + (char_has_trait(payload.speaker, "VAMPIRE_BLOOD_FOR_POTENCY_REAL") * 10))
end

local function jmath_werewolf_tier_four_traits(payload)
    return ((char_has_trait(payload.speaker, "WEREWOLF_SUPER_FAST_REGENERATION") + char_has_trait(payload.speaker, "WEREWOLF_SUMMON_FOG")) + char_has_trait(payload.speaker, "WEREWOLF_MOON_ARMOR"))
end

local function jmath_werewolf_tier_five_traits(payload)
    return (((char_has_trait(payload.speaker, "WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM") + char_has_trait(payload.speaker, "WEREWOLF_CLOSE_TEAR_IN_REALITY")) + char_has_trait(payload.speaker, "WEREWOLF_WALK_THROUGH_WALLS")) + char_has_trait(payload.speaker, "WEREWOLF_SUMMON_SHADOW_PACK"))
end

local function jmath_werewolf_tier_one_traits(payload)
    return (((((char_has_trait(payload.speaker, "WEREWOLF_SMELL_NEARBY_ENEMIES") + char_has_trait(payload.speaker, "WEREWOLF_NO_SCENT")) + char_has_trait(payload.speaker, "WEREWOLF_ILLUMINATE_TARGET")) + char_has_trait(payload.speaker, "WEREWOLF_FRIEND_TO_ANIMALS")) + char_has_trait(payload.speaker, "WEREWOLF_SMASH_TERRAIN")) + char_has_trait(payload.speaker, "WEREWOLF_CLIMB_IN_WOLF_FORM"))
end

local function jmath_werewolf_tier_two_traits(payload)
    return ((((char_has_trait(payload.speaker, "WEREWOLF_SENSE_SPIRITS_AND_ALIENS") + char_has_trait(payload.speaker, "WEREWOLF_STUN_MACHINE")) + char_has_trait(payload.speaker, "WEREWOLF_EXTRA_WEAKPOINT_HITS")) + char_has_trait(payload.speaker, "WEREWOLF_FAR_JUMP")) + char_has_trait(payload.speaker, "WEREWOLF_CAMOUFLAGE_COAT"))
end

local function jmath_werewolf_tier_three_traits(payload)
    return ((((char_has_trait(payload.speaker, "WEREWOLF_PARTIAL_SHIFT") + char_has_trait(payload.speaker, "WEREWOLF_SILVER_CLAWS")) + char_has_trait(payload.speaker, "WEREWOLF_MANA_BONUS_AFTER_KILL")) + char_has_trait(payload.speaker, "WEREWOLF_STRENGTH_BONUS")) + char_has_trait(payload.speaker, "WEREWOLF_BATTLE_FURY"))
end

ccb.runtime.handler("wave14a_xedra_evolved_stat_1", function(payload)
    return ((char_spell_level(payload.speaker, "dream_mana_gain") * 4) * jmath_lucid_dreaming_proficiency_modifier(payload))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_2", function(payload)
    return ((char_spell_level(payload.speaker, "dream_mana_gain") * 7) * jmath_lucid_dreaming_proficiency_modifier(payload))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_3", function(payload)
    return math.max(jmath_eater_level(payload, 1), jmath_dreamer_level(payload, 1))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_4", function(payload)
    return ((char_spell_level(payload.speaker, "dream_mana_gain") * 2) * jmath_lucid_dreaming_proficiency_modifier(payload))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_5", function(payload)
    return ((char_spell_level(payload.speaker, "dream_mana_gain") * 5) * jmath_lucid_dreaming_proficiency_modifier(payload))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_6", function(payload)
    return math.max(math.max(jmath_eater_level(payload, 1), jmath_dreamer_level(payload, 1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_7", function(payload)
    return (char_stat(payload.speaker, "dexterity") / 2)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_8", function(payload)
    return (char_stat(payload.speaker, "dexterity") / 4)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_9", function(payload)
    return ((((-1) + (char_spell_count(payload.speaker, "ARVORE") * (-0.05))) + (char_skill(payload.speaker, "gramarye") * (-0.2))) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_10", function(payload)
    return math.min(((1 + (char_spell_count(payload.speaker, "ARVORE") * 0.45)) + (char_skill(payload.speaker, "gramarye") * 0.75)), 20)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_11", function(payload)
    return (((18642 + (char_spell_count(payload.speaker, "ARVORE") * 8341)) + (char_skill(payload.speaker, "gramarye") * 20571)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_12", function(payload)
    return (((39821 + (char_spell_count(payload.speaker, "ARVORE") * 19531)) + (char_skill(payload.speaker, "gramarye") * 48531)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_13", function(payload)
    return math.max(((750 + (char_spell_count(payload.speaker, "ARVORE") * (-7.2))) + (char_skill(payload.speaker, "gramarye") * (-11.3))), 500)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_14", function(payload)
    return (((char_spell_count(payload.speaker, "ARVORE") * 0.75) + (char_skill(payload.speaker, "gramarye") * 1.5)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_15", function(payload)
    return (((char_spell_count(payload.speaker, "ARVORE") * 2.5) + (char_skill(payload.speaker, "gramarye") * 4.5)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_16", function(payload)
    return math.min(((1 + (char_spell_count(payload.speaker, "ARVORE") * 0.2)) + (char_skill(payload.speaker, "gramarye") * 0.25)), 8)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_17", function(payload)
    return math.min(((30 + (char_spell_count(payload.speaker, "ARVORE") * 0.35)) + (char_skill(payload.speaker, "gramarye") * 0.6)), 55)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_18", function(payload)
    return math.max(((450 + (char_spell_count(payload.speaker, "ARVORE") * (-2))) + (char_skill(payload.speaker, "gramarye") * (-4.8))), 250)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_19", function(payload)
    return math.max(((150 + (char_spell_count(payload.speaker, "ARVORE") * (-0.6))) + (char_skill(payload.speaker, "gramarye") * (-1.4))), 100)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_20", function(payload)
    return math.min(((1 + (char_spell_count(payload.speaker, "ARVORE") * 0.16)) + (char_skill(payload.speaker, "gramarye") * 0.25)), 8)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_21", function(payload)
    return math.min(((1 + (char_spell_count(payload.speaker, "ARVORE") * 0.22)) + (char_skill(payload.speaker, "gramarye") * 0.4)), 15)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_22", function(payload)
    return (((22845 + (char_spell_count(payload.speaker, "ARVORE") * 2548)) + (char_skill(payload.speaker, "gramarye") * 8165)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_23", function(payload)
    return (((49285 + (char_spell_count(payload.speaker, "ARVORE") * 5942)) + (char_skill(payload.speaker, "gramarye") * 14953)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_24", function(payload)
    return ((((42815 + (char_spell_count(payload.speaker, "ARVORE") * 5681)) + (char_skill(payload.speaker, "gramarye") * 11583)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception"))) * jmath_paraclesian_post_threshold_doubler(payload, 1))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_25", function(payload)
    return ((((88165 + (char_spell_count(payload.speaker, "ARVORE") * 18735)) + (char_skill(payload.speaker, "gramarye") * 34825)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception"))) * jmath_paraclesian_post_threshold_doubler(payload, 1))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_26", function(payload)
    return math.min(((1 + (char_spell_count(payload.speaker, "ARVORE") * 0.41)) + (char_skill(payload.speaker, "gramarye") * 0.65)), 15)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_27", function(payload)
    return math.min(((30 + (char_spell_count(payload.speaker, "ARVORE") * 1)) + (char_skill(payload.speaker, "gramarye") * 2.5)), 80)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_28", function(payload)
    return math.min(((2 + (char_spell_count(payload.speaker, "ARVORE") * 0.78)) + (char_skill(payload.speaker, "gramarye") * 1.1)), 25)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_29", function(payload)
    return (((10 + (char_spell_count(payload.speaker, "ARVORE") * 1.5)) + (char_skill(payload.speaker, "gramarye") * 2.1)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_30", function(payload)
    return (((15 + (char_spell_count(payload.speaker, "ARVORE") * 3.2)) + (char_skill(payload.speaker, "gramarye") * 4.8)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_31", function(payload)
    return math.min((((2 + (char_spell_count(payload.speaker, "ARVORE") * 0.65)) + (char_skill(payload.speaker, "gramarye") * 1.2)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception"))), 70)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_32", function(payload)
    return math.min((((0 + (char_spell_count(payload.speaker, "ARVORE") * 0.15)) + (char_skill(payload.speaker, "gramarye") * 0.4)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception"))), 10)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_33", function(payload)
    return math.min(((0.25 + (char_spell_count(payload.speaker, "ARVORE") * 0.05)) + (char_skill(payload.speaker, "gramarye") * 0.1)), 3)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_34", function(payload)
    return (((221 + (char_spell_count(payload.speaker, "ARVORE") * 152)) + (char_skill(payload.speaker, "gramarye") * 329)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_35", function(payload)
    return (((1085 + (char_spell_count(payload.speaker, "ARVORE") * 371)) + (char_skill(payload.speaker, "gramarye") * 685)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_36", function(payload)
    return math.max(((400 + (char_spell_count(payload.speaker, "ARVORE") * 6.1)) + (char_skill(payload.speaker, "gramarye") * (-8.5))), 150)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_37", function(payload)
    return math.max(((200 + (char_spell_count(payload.speaker, "ARVORE") * 2.1)) + (char_skill(payload.speaker, "gramarye") * (-5.5))), 100)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_38", function(payload)
    return math.min((((2 + (char_spell_count(payload.speaker, "ARVORE") * 0.3)) + (char_skill(payload.speaker, "gramarye") * 0.75)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception"))), 20)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_39", function(payload)
    return ((char_stat(payload.speaker, "dexterity") / 2) * (-1))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_40", function(payload)
    return math.max(((1000 + (char_spell_count(payload.speaker, "ARVORE") * 10.4)) + (char_skill(payload.speaker, "gramarye") * (-22.8))), 500)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_41", function(payload)
    return math.max(((6000 + (char_spell_count(payload.speaker, "ARVORE") * (-85.8))) + (char_skill(payload.speaker, "gramarye") * (-127.6))), 1500)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_42", function(payload)
    return math.min((((1 + (char_spell_count(payload.speaker, "ARVORE") * 0.15)) + (char_skill(payload.speaker, "gramarye") * 0.4)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception"))), 15)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_43", function(payload)
    return math.max(((4000 + (char_spell_count(payload.speaker, "ARVORE") * 83.4)) + (char_skill(payload.speaker, "gramarye") * (-143.1))), 2500)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_44", function(payload)
    return math.max(((720000 + (char_spell_count(payload.speaker, "ARVORE") * (-2315))) + (char_skill(payload.speaker, "gramarye") * (-16103))), 360000)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_45", function(payload)
    return math.max(((350 + (char_spell_count(payload.speaker, "ARVORE") * (-1.8))) + (char_skill(payload.speaker, "gramarye") * (-3))), 200)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_46", function(payload)
    return math.max(((150 + (char_spell_count(payload.speaker, "ARVORE") * (-1.1))) + (char_skill(payload.speaker, "gramarye") * (-1.5))), 75)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_47", function(payload)
    return math.max(((500 + (char_spell_count(payload.speaker, "ARVORE") * (-10.9))) + (char_skill(payload.speaker, "gramarye") * (-15.6))), 250)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_48", function(payload)
    return math.max(((12000 + (char_spell_count(payload.speaker, "ARVORE") * (-305.1))) + (char_skill(payload.speaker, "gramarye") * (-561.8))), 1500)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_49", function(payload)
    return math.min((((3 + (char_spell_count(payload.speaker, "ARVORE") * 0.45)) + (char_skill(payload.speaker, "gramarye") * 0.8)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence"))), 35)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_50", function(payload)
    return math.min((((2 + (char_spell_count(payload.speaker, "ARVORE") * 0.2)) + (char_skill(payload.speaker, "gramarye") * 0.45)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence"))), 20)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_51", function(payload)
    return math.max(((150 + (char_spell_count(payload.speaker, "ARVORE") * (-2.8))) + (char_skill(payload.speaker, "gramarye") * (-4.2))), 50)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_52", function(payload)
    return math.max(((100 + (char_spell_count(payload.speaker, "ARVORE") * (-1.9))) + (char_skill(payload.speaker, "gramarye") * (-2.5))), 35)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_53", function(payload)
    return math.min((((2 + (char_spell_count(payload.speaker, "ARVORE") * 0.4)) + (char_skill(payload.speaker, "gramarye") * 0.65)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception"))), 40)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_54", function(payload)
    return math.min((((0 + (char_spell_count(payload.speaker, "ARVORE") * 0.08)) + (char_skill(payload.speaker, "gramarye") * 0.15)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception"))), 3)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_55", function(payload)
    return math.min(((0.15 + (char_spell_count(payload.speaker, "ARVORE") * 0.04)) + (char_skill(payload.speaker, "gramarye") * 0.08)), 3)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_56", function(payload)
    return (((150 + (char_spell_count(payload.speaker, "ARVORE") * 55)) + (char_skill(payload.speaker, "gramarye") * 112)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_57", function(payload)
    return (((680 + (char_spell_count(payload.speaker, "ARVORE") * 105)) + (char_skill(payload.speaker, "gramarye") * 252)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_58", function(payload)
    return math.max(((225 + (char_spell_count(payload.speaker, "ARVORE") * (-2.2))) + (char_skill(payload.speaker, "gramarye") * (-3.1))), 125)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_59", function(payload)
    return math.max(((150 + (char_spell_count(payload.speaker, "ARVORE") * (-2.2))) + (char_skill(payload.speaker, "gramarye") * (-3.1))), 50)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_60", function(payload)
    return math.min((((3 + (char_spell_count(payload.speaker, "ARVORE") * 0.45)) + (char_skill(payload.speaker, "gramarye") * 0.8)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception"))), 25)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_61", function(payload)
    return math.min(((1 + (char_spell_count(payload.speaker, "ARVORE") * 0.18)) + (char_skill(payload.speaker, "gramarye") * 0.25)), 6)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_62", function(payload)
    return (((482 + (char_spell_count(payload.speaker, "ARVORE") * 75)) + (char_skill(payload.speaker, "gramarye") * 258)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_63", function(payload)
    return (((2842 + (char_spell_count(payload.speaker, "ARVORE") * 210)) + (char_skill(payload.speaker, "gramarye") * 458)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_64", function(payload)
    return math.max(((1000 + (char_spell_count(payload.speaker, "ARVORE") * (-25.9))) + (char_skill(payload.speaker, "gramarye") * (-31.3))), 500)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_65", function(payload)
    return math.max(((150 + (char_spell_count(payload.speaker, "ARVORE") * 2.1)) + (char_skill(payload.speaker, "gramarye") * (-4.5))), 75)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_66", function(payload)
    return (((25 + (get_actor_var_num(payload.speaker, "arvore_turn_into_tree_spell_count") * 2.6)) + (get_actor_var_num(payload.speaker, "arvore_turn_into_tree_gramarye_level") * 3.4)) * get_actor_var_num(payload.speaker, "arvore_turn_into_tree_intelligence"))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_67", function(payload)
    return (((100 + (get_actor_var_num(payload.speaker, "arvore_turn_into_tree_spell_count") * 5.6)) + (get_actor_var_num(payload.speaker, "arvore_turn_into_tree_gramarye_level") * 7.1)) * get_actor_var_num(payload.speaker, "arvore_turn_into_tree_intelligence"))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_68", function(payload)
    return ((6000 + (char_spell_level(payload.speaker, "homullus_sense_vampires_spell") * 3000)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_69", function(payload)
    return jmath_int_to_level(payload, 1)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_70", function(payload)
    return ((6000 + (char_spell_level(payload.speaker, "homullus_invisible_to_humans_spell") * 3000)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_71", function(payload)
    return (((char_spell_level(payload.speaker, "homullus_restore_power_spell") * 350) + 400) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_72", function(payload)
    return (((char_spell_level(payload.speaker, "homullus_restore_power_spell") * 850) + 1500) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_73", function(payload)
    return ((90000 + (char_spell_level(payload.speaker, "homullus_add_learning_focus_spell") * 12000)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_74", function(payload)
    return ((180000 + (char_spell_level(payload.speaker, "homullus_add_learning_focus_spell") * 25000)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_75", function(payload)
    return (((char_spell_level(payload.speaker, "homullus_charm_feral_spell") * 5) + 20) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_76", function(payload)
    return (((char_spell_level(payload.speaker, "homullus_charm_feral_spell") * 8) + 45) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_77", function(payload)
    return math.min((((char_spell_level(payload.speaker, "homullus_charm_feral_spell") * 1.2) + 2) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence"))), 70)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_78", function(payload)
    return (((char_spell_level(payload.speaker, "homullus_charm_feral_spell") * 10) + 60) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_79", function(payload)
    return (((char_spell_level(payload.speaker, "homullus_charm_feral_spell") * 25) + 120) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_80", function(payload)
    return (char_stat(payload.speaker, "strength") * 2.5)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_81", function(payload)
    return (char_stat(payload.speaker, "strength") * 3.5)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_82", function(payload)
    return math.min((((char_spell_level(payload.speaker, "ierde_create_pits_spell") * 0.8) + 5) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength"))), 40)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_83", function(payload)
    return math.min((((char_spell_level(payload.speaker, "ierde_create_pits_spell") * 0.4) + 0) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength"))), 10)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_84", function(payload)
    return jmath_str_to_level(payload, 1)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_85", function(payload)
    return math.min((((char_spell_level(payload.speaker, "ierde_stomp_ground_smash_spell") * 0.8) + 3) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength"))), 15)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_86", function(payload)
    return (((char_spell_level(payload.speaker, "ierde_stomp_ground_smash_spell") * 45) + 200) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_87", function(payload)
    return (((char_spell_level(payload.speaker, "ierde_stomp_ground_smash_spell") * 75) + 300) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_88", function(payload)
    return (((char_spell_level(payload.speaker, "ierde_iron_armor_spell") * 36000) + 120000) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_89", function(payload)
    return (((char_spell_level(payload.speaker, "ierde_iron_armor_spell") * 72000) + 360000) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_90", function(payload)
    return (4 + ((char_spell_level(payload.speaker, "ierde_knockback_punch_spell") * 1.5) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength"))))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_91", function(payload)
    return (15 + ((char_spell_level(payload.speaker, "ierde_knockback_punch_spell") * 3) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength"))))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_92", function(payload)
    return (1 + ((char_spell_level(payload.speaker, "ierde_knockback_punch_spell") * 0.5) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength"))))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_93", function(payload)
    return (2 + ((char_spell_level(payload.speaker, "ierde_knockback_punch_spell") * 1) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength"))))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_94", function(payload)
    return (1 + ((char_spell_level(payload.speaker, "ierde_reshape_the_earth_spell") * 0.5) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength"))))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_95", function(payload)
    return jmath_per_to_level(payload, 1)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_96", function(payload)
    return (1 + ((char_spell_level(payload.speaker, "ierde_reshape_the_earth_spell") * 0.25) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength"))))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_97", function(payload)
    return (((char_spell_level(payload.speaker, "ierde_stomp_ground_smash_spell") * 1.5) + 20) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_98", function(payload)
    return (((char_spell_level(payload.speaker, "ierde_stomp_ground_smash_spell") * 5) + 50) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_99", function(payload)
    return math.min((((char_spell_level(payload.speaker, "ierde_stomp_ground_smash") * 0.7) + 5) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength"))), 15)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_100", function(payload)
    return math.min((((char_spell_level(payload.speaker, "ierde_stomp_ground_smash_spell") * 0.7) + 5) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength"))), 15)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_101", function(payload)
    return (((char_spell_level(payload.speaker, "ierde_slow_enemies_spell") * 0.9) + 2) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_102", function(payload)
    return (((char_spell_level(payload.speaker, "ierde_slow_enemies_spell") * 0.3) + 0) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_103", function(payload)
    return (((char_spell_level(payload.speaker, "ierde_slow_enemies_spell") * 150) + 300) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_104", function(payload)
    return (((char_spell_level(payload.speaker, "ierde_slow_enemies_spell") * 350) + 1000) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_105", function(payload)
    return (((char_spell_level(payload.speaker, "paraclesian_spell_dodge_bonus_sylph") * 1800) + 21000) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_106", function(payload)
    return (((char_spell_level(payload.speaker, "paraclesian_spell_dodge_bonus_sylph") * 4200) + 39000) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_107", function(payload)
    return char_spell_level(payload.speaker, "paraclesian_spell_make_gossamer")
end)

ccb.runtime.handler("wave14a_xedra_evolved_cond_1", function(payload)
    return ((not (not services.gameplay.environment.is_night())) and creature_is_outside(payload.speaker) and (current_moon_phase_index() ~= 0))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_108", function(payload)
    return (((75318 + (char_spell_count(payload.speaker, "SALAMANDER") * 19135)) + (char_skill(payload.speaker, "gramarye") * 28436)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_109", function(payload)
    return (((129425 + (char_spell_count(payload.speaker, "SALAMANDER") * 37512)) + (char_skill(payload.speaker, "gramarye") * 51835)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_110", function(payload)
    return math.min(((1 + (char_spell_count(payload.speaker, "SALAMANDER") * 0.08)) + (char_skill(payload.speaker, "gramarye") * 0.25)), 5)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_111", function(payload)
    return math.max(((200 + (char_spell_count(payload.speaker, "SALAMANDER") * (-4.8))) + (char_skill(payload.speaker, "gramarye") * (-6.1))), 75)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_112", function(payload)
    return math.max(((125 + (char_spell_count(payload.speaker, "SALAMANDER") * (-2.6))) + (char_skill(payload.speaker, "gramarye") * (-3.2))), 75)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_113", function(payload)
    return (((6 + (char_spell_count(payload.speaker, "SALAMANDER") * 0.9)) + (char_skill(payload.speaker, "gramarye") * 1.4)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_114", function(payload)
    return (((15 + (char_spell_count(payload.speaker, "SALAMANDER") * 2.1)) + (char_skill(payload.speaker, "gramarye") * 3.3)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_115", function(payload)
    return math.max(((150 + (char_spell_count(payload.speaker, "SALAMANDER") * (-3.5))) + (char_skill(payload.speaker, "gramarye") * (-4.9))), 50)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_116", function(payload)
    return math.max(((75 + (char_spell_count(payload.speaker, "SALAMANDER") * (-2.6))) + (char_skill(payload.speaker, "gramarye") * (-3.2))), 25)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_117", function(payload)
    return (((23485 + (char_spell_count(payload.speaker, "SALAMANDER") * 9815)) + (char_skill(payload.speaker, "gramarye") * 18553)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "dexterity")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_118", function(payload)
    return (((51398 + (char_spell_count(payload.speaker, "SALAMANDER") * 24851)) + (char_skill(payload.speaker, "gramarye") * 39915)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "dexterity")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_119", function(payload)
    return math.max(((250 + (char_spell_count(payload.speaker, "SALAMANDER") * (-5.9))) + (char_skill(payload.speaker, "gramarye") * (-8.2))), 100)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_120", function(payload)
    return math.max(((1000 + (char_spell_count(payload.speaker, "SALAMANDER") * (-8.2))) + (char_skill(payload.speaker, "gramarye") * (-12.6))), 750)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_121", function(payload)
    return math.max(((250 + (char_spell_count(payload.speaker, "SALAMANDER") * (-4.3))) + (char_skill(payload.speaker, "gramarye") * (-6))), 150)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_122", function(payload)
    return math.max(((800 + (char_spell_count(payload.speaker, "SALAMANDER") * (-10.9))) + (char_skill(payload.speaker, "gramarye") * (-13.1))), 550)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_123", function(payload)
    return (((23318 + (char_spell_count(payload.speaker, "SALAMANDER") * 6135)) + (char_skill(payload.speaker, "gramarye") * 11436)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_124", function(payload)
    return (((79425 + (char_spell_count(payload.speaker, "SALAMANDER") * 15512)) + (char_skill(payload.speaker, "gramarye") * 23835)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_125", function(payload)
    return math.max(((150 + (char_spell_count(payload.speaker, "SALAMANDER") * (-3.9))) + (char_skill(payload.speaker, "gramarye") * (-4.7))), 50)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_126", function(payload)
    return math.min(((3 + (char_spell_count(payload.speaker, "SALAMANDER") * 0.6)) + (char_skill(payload.speaker, "gramarye") * 1)), 25)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_127", function(payload)
    return (((1259 + (char_spell_count(payload.speaker, "SALAMANDER") * 26)) + (char_skill(payload.speaker, "gramarye") * 112)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "dexterity")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_128", function(payload)
    return (((3482 + (char_spell_count(payload.speaker, "SALAMANDER") * 85)) + (char_skill(payload.speaker, "gramarye") * 295)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "dexterity")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_129", function(payload)
    return math.max(((250 + (char_spell_count(payload.speaker, "SALAMANDER") * (-6.9))) + (char_skill(payload.speaker, "gramarye") * (-8.6))), 100)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_130", function(payload)
    return (((8952 + (char_spell_count(payload.speaker, "SALAMANDER") * 4284)) + (char_skill(payload.speaker, "gramarye") * 9815)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_131", function(payload)
    return (((32485 + (char_spell_count(payload.speaker, "SALAMANDER") * 9985)) + (char_skill(payload.speaker, "gramarye") * 22815)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_132", function(payload)
    return math.max(((550 + (char_spell_count(payload.speaker, "SALAMANDER") * (-8.4))) + (char_skill(payload.speaker, "gramarye") * (-11.9))), 250)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_133", function(payload)
    return math.max(((250 + (char_spell_count(payload.speaker, "SALAMANDER") * (-5.9))) + (char_skill(payload.speaker, "gramarye") * (-7.9))), 100)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_134", function(payload)
    return (((11385 + (char_spell_count(payload.speaker, "SALAMANDER") * 1823)) + (char_skill(payload.speaker, "gramarye") * 4552)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_135", function(payload)
    return (((48135 + (char_spell_count(payload.speaker, "SALAMANDER") * 5842)) + (char_skill(payload.speaker, "gramarye") * 11253)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_136", function(payload)
    return math.max(((700 + (char_spell_count(payload.speaker, "SALAMANDER") * (-14.4))) + (char_skill(payload.speaker, "gramarye") * (-16.5))), 450)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_137", function(payload)
    return math.max(((500 + (char_spell_count(payload.speaker, "SALAMANDER") * (-14.2))) + (char_skill(payload.speaker, "gramarye") * (-16.9))), 150)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_138", function(payload)
    return math.min(((1 + (char_spell_count(payload.speaker, "SALAMANDER") * 0.16)) + (char_skill(payload.speaker, "gramarye") * 0.25)), 8)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_139", function(payload)
    return math.min(((1 + (char_spell_count(payload.speaker, "SALAMANDER") * 0.22)) + (char_skill(payload.speaker, "gramarye") * 0.4)), 15)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_140", function(payload)
    return (((22845 + (char_spell_count(payload.speaker, "SALAMANDER") * 2548)) + (char_skill(payload.speaker, "gramarye") * 8165)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_141", function(payload)
    return (((49285 + (char_spell_count(payload.speaker, "SALAMANDER") * 5942)) + (char_skill(payload.speaker, "gramarye") * 14953)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_142", function(payload)
    return math.min(((2 + (char_spell_count(payload.speaker, "SALAMANDER") * 0.42)) + (char_skill(payload.speaker, "gramarye") * 0.65)), 18)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_143", function(payload)
    return math.max(((400 + (char_spell_count(payload.speaker, "SALAMANDER") * (-14.4))) + (char_skill(payload.speaker, "gramarye") * (-16.5))), 250)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_144", function(payload)
    return math.max(((300 + (char_spell_count(payload.speaker, "SALAMANDER") * (-14.2))) + (char_skill(payload.speaker, "gramarye") * (-16.9))), 75)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_145", function(payload)
    return math.min(((2 + (char_spell_count(payload.speaker, "SALAMANDER") * 0.75)) + (char_skill(payload.speaker, "gramarye") * 1.25)), 20)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_146", function(payload)
    return math.max(((100 + (char_spell_count(payload.speaker, "SALAMANDER") * (-6.9))) + (char_skill(payload.speaker, "gramarye") * (-8.5))), 50)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_147", function(payload)
    return ((14 + (char_spell_count(payload.speaker, "SALAMANDER") * 1.5)) + (char_skill(payload.speaker, "gramarye") * 5.6))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_148", function(payload)
    return ((27 + (char_spell_count(payload.speaker, "SALAMANDER") * 2.6)) + (char_skill(payload.speaker, "gramarye") * 8.9))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_149", function(payload)
    return math.min(((2 + (char_spell_count(payload.speaker, "SALAMANDER") * 0.15)) + (char_skill(payload.speaker, "gramarye") * 0.4)), 8)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_150", function(payload)
    return math.min(((30 + (char_spell_count(payload.speaker, "SALAMANDER") * 3.6)) + (char_skill(payload.speaker, "gramarye") * 5.5)), 120)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_151", function(payload)
    return math.max(((350 + (char_spell_count(payload.speaker, "SALAMANDER") * (-3.5))) + (char_skill(payload.speaker, "gramarye") * (-4.9))), 250)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_152", function(payload)
    return math.max(((100 + (char_spell_count(payload.speaker, "SALAMANDER") * (-6.9))) + (char_skill(payload.speaker, "gramarye") * (-8.5))), 75)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_153", function(payload)
    return math.min(((3 + (char_spell_count(payload.speaker, "SALAMANDER") * 0.29)) + (char_skill(payload.speaker, "gramarye") * 0.46)), 12)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_154", function(payload)
    return math.max(((350 + (char_spell_count(payload.speaker, "SALAMANDER") * (-4.2))) + (char_skill(payload.speaker, "gramarye") * (-6.4))), 200)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_155", function(payload)
    return math.max(((200 + (char_spell_count(payload.speaker, "SALAMANDER") * (-5.8))) + (char_skill(payload.speaker, "gramarye") * (-7.2))), 50)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_156", function(payload)
    return math.min(((3 + (char_spell_count(payload.speaker, "SALAMANDER") * 0.52)) + (char_skill(payload.speaker, "gramarye") * 0.85)), 20)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_157", function(payload)
    return math.max(((450 + (char_spell_count(payload.speaker, "SALAMANDER") * (-4.2))) + (char_skill(payload.speaker, "gramarye") * (-6))), 350)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_158", function(payload)
    return math.max(((180000 + (char_spell_count(payload.speaker, "SALAMANDER") * (-986))) + (char_skill(payload.speaker, "gramarye") * (-3185))), 6000)
end)

ccb.runtime.handler("wave14a_xedra_evolved_cond_2", function(payload)
    return (char_has_item(payload.speaker, "torch_lit") or char_has_item(payload.speaker, "candle_lit") or char_has_item(payload.speaker, "oil_lamp_on") or char_has_item(payload.speaker, "oil_lamp_clay_on") or char_has_item(payload.speaker, "cigar_lit") or char_has_item(payload.speaker, "cig_lit") or (get_actor_var_num(payload.speaker, "salamander_near_fire") == 1) or (weather_temp_kelvin() >= ((((80) - 32) * 5 / 9) + 273.15)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_159", function(payload)
    return math.min(((2 + (char_spell_count(payload.speaker, "SALAMANDER") * 0.15)) + (char_skill(payload.speaker, "gramarye") * 0.37)), 9)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_160", function(payload)
    return math.min(((1 + (char_spell_count(payload.speaker, "SALAMANDER") * 0.15)) + (char_skill(payload.speaker, "gramarye") * 0.37)), 5)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_161", function(payload)
    return math.max(((750 + (char_spell_count(payload.speaker, "SALAMANDER") * (-8.5))) + (char_skill(payload.speaker, "gramarye") * (-11.9))), 500)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_162", function(payload)
    return ((65 + (char_spell_count(payload.speaker, "SALAMANDER") * 8.5)) + (char_skill(payload.speaker, "gramarye") * 12.9))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_163", function(payload)
    return ((169 + (char_spell_count(payload.speaker, "SALAMANDER") * 15.9)) + (char_skill(payload.speaker, "gramarye") * 23.1))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_164", function(payload)
    return math.min(((4 + (char_spell_count(payload.speaker, "SALAMANDER") * 0.6)) + (char_skill(payload.speaker, "gramarye") * 1.5)), 35)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_165", function(payload)
    return math.max(((175 + (char_spell_count(payload.speaker, "SALAMANDER") * (-6.9))) + (char_skill(payload.speaker, "gramarye") * (-8.1))), 55)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_166", function(payload)
    return math.max(((2250 + (char_spell_count(payload.speaker, "SALAMANDER") * (-23.5))) + (char_skill(payload.speaker, "gramarye") * (-37.6))), 1750)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_167", function(payload)
    return (4 + ((char_spell_level(payload.speaker, "sylph_charge_dash_spell") * 1) * jmath_scaling_factor(payload, char_stat(payload.speaker, "dexterity"))))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_168", function(payload)
    return jmath_dex_to_level(payload, 1)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_169", function(payload)
    return (((char_spell_level(payload.speaker, "pushing_wind") * 0.25) + 2) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_170", function(payload)
    return (((char_spell_level(payload.speaker, "pushing_wind") * 0.25) + 6) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_171", function(payload)
    return (((char_spell_level(payload.speaker, "pushing_wind") * 1.2) + 1) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_172", function(payload)
    return (((char_spell_level(payload.speaker, "sylph_clear_the_air") * 0.9) + 3) * jmath_scaling_factor(payload, char_stat(payload.speaker, "perception")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_173", function(payload)
    return (((char_spell_level(payload.speaker, "sylph_hindering_wind_spell") * 1.2) + 1) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_174", function(payload)
    return (((char_spell_level(payload.speaker, "sylph_massive_lightning_bolt_spell") * 3) + 25) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_175", function(payload)
    return (((char_spell_level(payload.speaker, "sylph_massive_lightning_bolt_spell") * 7.5) + 110) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_176", function(payload)
    return math.min((((char_spell_level(payload.speaker, "sylph_massive_lightning_bolt_spell") * 0.9) + 4) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence"))), 50)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_177", function(payload)
    return (((char_spell_level(payload.speaker, "zap_electrical_emission") * 1) + 3) * jmath_scaling_factor(payload, char_stat(payload.speaker, "dexterity")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_178", function(payload)
    return (((char_spell_level(payload.speaker, "zap_electrical_emission") * 4) + 7) * jmath_scaling_factor(payload, char_stat(payload.speaker, "dexterity")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_179", function(payload)
    return (((char_spell_level(payload.speaker, "sylph_call_lightning") * 3) + 6) * jmath_scaling_factor(payload, char_stat(payload.speaker, "dexterity")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_180", function(payload)
    return (((char_spell_level(payload.speaker, "sylph_call_lightning") * 4) + 26) * jmath_scaling_factor(payload, char_stat(payload.speaker, "dexterity")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_181", function(payload)
    return (((char_spell_level(payload.speaker, "sylph_call_lightning") * 1.5) + 2) * jmath_scaling_factor(payload, char_stat(payload.speaker, "dexterity")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_182", function(payload)
    return (((char_spell_level(payload.speaker, "sylph_crash_of_lightning") * 3) + 6) * jmath_scaling_factor(payload, char_stat(payload.speaker, "dexterity")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_183", function(payload)
    return (((char_spell_level(payload.speaker, "sylph_crash_of_lightning") * 4) + 26) * jmath_scaling_factor(payload, char_stat(payload.speaker, "dexterity")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_184", function(payload)
    return (((char_spell_level(payload.speaker, "sylph_crash_of_lightning") * 1.5) + 2) * jmath_scaling_factor(payload, char_stat(payload.speaker, "dexterity")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_185", function(payload)
    return (((char_spell_level(payload.speaker, "electrical_field") * 1.5) + 2) * jmath_scaling_factor(payload, char_stat(payload.speaker, "dexterity")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_186", function(payload)
    return (((char_spell_level(payload.speaker, "lightning_field") * 1.5) + 2) * jmath_scaling_factor(payload, char_stat(payload.speaker, "dexterity")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_187", function(payload)
    return (((char_spell_level(payload.speaker, "acidic_mist") * 1.5) + 2) * jmath_scaling_factor(payload, char_stat(payload.speaker, "dexterity")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_188", function(payload)
    return (((char_spell_level(payload.speaker, "deadly_mist") * 1.5) + 2) * jmath_scaling_factor(payload, char_stat(payload.speaker, "dexterity")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_189", function(payload)
    return (((char_spell_level(payload.speaker, "undine_bash_and_slow_spell") * 2) + 15) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_190", function(payload)
    return (((char_spell_level(payload.speaker, "undine_bash_and_slow_spell") * 5) + 55) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_191", function(payload)
    return (((char_spell_level(payload.speaker, "undine_bash_and_slow_spell") * 1.1) + 3) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_192", function(payload)
    return (((char_spell_level(payload.speaker, "undine_bash_and_slow_spell") * 75) + 200) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_193", function(payload)
    return (((char_spell_level(payload.speaker, "undine_bash_and_slow_spell") * 150) + 800) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_194", function(payload)
    return math.min((((char_spell_level(payload.speaker, "undine_drag_inward_spell") * 0.8) + 5) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength"))), 40)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_195", function(payload)
    return math.min((((char_spell_level(payload.speaker, "undine_drag_inward_spell") * 0.25) + 3) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength"))), 15)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_196", function(payload)
    return (((char_spell_level(payload.speaker, "undine_drag_inward_spell") * 100) + 200) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_197", function(payload)
    return (((char_spell_level(payload.speaker, "undine_drag_inward_spell") * 200) + 800) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_198", function(payload)
    return (((char_spell_level(payload.speaker, "undine_tidal_wave_spell") * 3) + 40) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_199", function(payload)
    return (((char_spell_level(payload.speaker, "undine_tidal_wave_spell") * 9) + 100) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_200", function(payload)
    return math.min((((char_spell_level(payload.speaker, "undine_tidal_wave_spell") * 0.75) + 4) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength"))), 30)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_201", function(payload)
    return math.min((((char_spell_level(payload.speaker, "undine_tidal_wave_spell") * 0.3) + 2) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength"))), 6)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_202", function(payload)
    return (((char_spell_level(payload.speaker, "undine_tidal_wave_spell") * 0.25) + 1) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_203", function(payload)
    return (((char_spell_level(payload.speaker, "undine_tidal_wave_spell") * 0.5) + 2) * jmath_scaling_factor(payload, char_stat(payload.speaker, "strength")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_204", function(payload)
    return (((char_spell_level(payload.speaker, "create_fog") * 1.5) + 2) * jmath_scaling_factor(payload, char_stat(payload.speaker, "dexterity")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_205", function(payload)
    return (((char_spell_level(payload.speaker, "fog_bank") * 1.5) + 2) * jmath_scaling_factor(payload, char_stat(payload.speaker, "dexterity")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_206", function(payload)
    return (((char_spell_level(payload.speaker, "arvore_overgrowth_spell") * services.random.native_float(0.8, 1.2)) + services.random.native_float(1.5, 4)) * jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_207", function(payload)
    return get_actor_var_num(payload.speaker, "latest_arvore_embrace_of_verdant_mother_damage")
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_208", function(payload)
    return get_actor_var_num(payload.speaker, "latest_arvore_embrace_of_verdant_mother_aoe")
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_209", function(payload)
    return (get_actor_var_num(payload.speaker, "latest_arvore_embrace_of_verdant_mother_damage") * (-1))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_210", function(payload)
    return (services.random.native_float(0.75, 1.25) * ((((50 + (jmath_vampire_total_tier_one_traits(payload) * 5)) + (jmath_vampire_total_tier_two_traits(payload) * 12)) + (jmath_vampire_total_tier_three_traits(payload) * 20)) + (jmath_vampire_total_tier_three_traits(payload) * 35)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_211", function(payload)
    return (services.random.native_float(0.75, 1.25) * ((((6000 + (jmath_vampire_total_tier_one_traits(payload) * 1000)) + (jmath_vampire_total_tier_two_traits(payload) * 1800)) + (jmath_vampire_total_tier_three_traits(payload) * 2700)) + (jmath_vampire_total_tier_three_traits(payload) * 4500)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_212", function(payload)
    return (services.random.native_float(0.75, 1.25) * ((((20 + (jmath_vampire_total_tier_one_traits(payload) * 4)) + (jmath_vampire_total_tier_two_traits(payload) * 10)) + (jmath_vampire_total_tier_three_traits(payload) * 16)) + (jmath_vampire_total_tier_four_traits(payload) * 30)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_213", function(payload)
    return (services.random.native_float(0.75, 1.25) * ((((2500 + (jmath_vampire_total_tier_one_traits(payload) * 400)) + (jmath_vampire_total_tier_two_traits(payload) * 800)) + (jmath_vampire_total_tier_three_traits(payload) * 1150)) + (jmath_vampire_total_tier_four_traits(payload) * 2050)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_214", function(payload)
    return ((1500 / char_speed(payload.speaker)) * 100)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_215", function(payload)
    return ((2500 / char_speed(payload.speaker)) * 100)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_216", function(payload)
    return ((5 + (2 * jmath_bloodthorn_druid_traits_sum(payload))) + (0.8 * char_sum_traits_cat(payload.speaker, "ARVORE_ALCHEMY", "ALL")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_217", function(payload)
    return ((20 + (3.5 * jmath_bloodthorn_druid_traits_sum(payload))) + (1.8 * char_sum_traits_cat(payload.speaker, "ARVORE_ALCHEMY", "ALL")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_218", function(payload)
    return ((0 + (0.2 * jmath_bloodthorn_druid_traits_sum(payload))) + (0.05 * char_sum_traits_cat(payload.speaker, "ARVORE_ALCHEMY", "ALL")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_219", function(payload)
    return math.max((350 - (jmath_bloodthorn_druid_traits_sum(payload) * 6)), 150)
end)

ccb.runtime.handler("wave14a_xedra_evolved_cond_3", function(payload)
    return (creature_has_effect(payload.interlocutor, "effect_hungry_roots") or creature_on_terrain(payload.interlocutor, "t_grass_long") or creature_on_terrain(payload.interlocutor, "t_grass_tall") or creature_on_terrain_flag(payload.interlocutor, "YOUNG") or creature_on_terrain_flag(payload.interlocutor, "SHRUB"))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_220", function(payload)
    return (((51657 + (3651 * jmath_bloodthorn_druid_traits_sum(payload))) + (2015 * char_sum_traits_cat(payload.speaker, "ARVORE_ALCHEMY", "ALL"))) + (char_skill(payload.speaker, "deduction") * 1285))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_221", function(payload)
    return (((109395 + (9815 * jmath_bloodthorn_druid_traits_sum(payload))) + (4851 * char_sum_traits_cat(payload.speaker, "ARVORE_ALCHEMY", "ALL"))) + (char_skill(payload.speaker, "deduction") * 2795))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_222", function(payload)
    return math.max((450 - (jmath_bloodthorn_druid_traits_sum(payload) * 10)), 300)
end)

ccb.runtime.handler("wave14a_xedra_evolved_cond_4", function(payload)
    return (creature_on_terrain_flag(payload.speaker, "DIGGABLE") or creature_on_terrain_flag(payload.speaker, "YOUNG") or creature_on_terrain_flag(payload.speaker, "SHRUB"))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_223", function(payload)
    return (((23571 + (1905 * jmath_bloodthorn_druid_traits_sum(payload))) + (851 * char_sum_traits_cat(payload.speaker, "ARVORE_ALCHEMY", "ALL"))) + (char_skill(payload.speaker, "deduction") * 1315))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_224", function(payload)
    return (((79552 + (6812 * jmath_bloodthorn_druid_traits_sum(payload))) + (2904 * char_sum_traits_cat(payload.speaker, "ARVORE_ALCHEMY", "ALL"))) + (char_skill(payload.speaker, "deduction") * 3795))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_225", function(payload)
    return math.max((700 - (jmath_bloodthorn_druid_traits_sum(payload) * 20)), 300)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_226", function(payload)
    return (math.min(((2 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 0.4)) + (char_skill(payload.speaker, "gramarye") * 0.7)), 13) * (((get_global_var_num("global_what_is_the_season") == 1)) and (0.5) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_227", function(payload)
    return math.max(((100 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 3)) - (char_skill(payload.speaker, "gramarye") * 5)), 40)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_228", function(payload)
    return ((19085 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 9185)) + (char_skill(payload.speaker, "gramarye") * 19485))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_229", function(payload)
    return ((51385 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 16712)) + (char_skill(payload.speaker, "gramarye") * 31085))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_230", function(payload)
    return math.max(((250 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 3)) - (char_skill(payload.speaker, "gramarye") * 8)), 125)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_231", function(payload)
    return math.max(((200 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 3)) - (char_skill(payload.speaker, "gramarye") * 7)), 100)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_232", function(payload)
    return (((15 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 1.6)) + (char_skill(payload.speaker, "gramarye") * 3)) * (((get_global_var_num("global_what_is_the_season") == 1)) and (0.6) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_233", function(payload)
    return (((40 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 3.2)) + (char_skill(payload.speaker, "gramarye") * 7.5)) * (((get_global_var_num("global_what_is_the_season") == 1)) and (0.4) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_234", function(payload)
    return (math.min(((4 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 0.21)) + (char_skill(payload.speaker, "gramarye") * 0.65)), 15) * (((get_global_var_num("global_what_is_the_season") == 1)) and (0.4) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_235", function(payload)
    return (math.min(((7 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 0.45)) + (char_skill(payload.speaker, "gramarye") * 0.96)), 30) * (((get_global_var_num("global_what_is_the_season") == 1)) and (0.4) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_236", function(payload)
    return ((320 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 80)) + (char_skill(payload.speaker, "gramarye") * 125))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_237", function(payload)
    return ((681 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 154)) + (char_skill(payload.speaker, "gramarye") * 271))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_238", function(payload)
    return math.max(((300 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 3)) - (char_skill(payload.speaker, "gramarye") * 8)), 150)
end)

ccb.runtime.handler("wave14a_xedra_evolved_cond_5", function(payload)
    return (creature_has_species(payload.interlocutor, "CYBORG") or (creature_has_species(payload.interlocutor, "ROBOT") and (not creature_has_species(payload.interlocutor, "YRAX"))) or creature_has_species(payload.interlocutor, "ROBOT_FLYING") or ((char_skill(payload.speaker, "gramarye") >= 9) and creature_has_species(payload.interlocutor, "YRAX")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_239", function(payload)
    return ((235 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 52)) + (char_skill(payload.speaker, "gramarye") * 185))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_240", function(payload)
    return ((812 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 125)) + (char_skill(payload.speaker, "gramarye") * 322))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_241", function(payload)
    return math.max(((300 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 4)) - (char_skill(payload.speaker, "gramarye") * 7)), 150)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_242", function(payload)
    return (((1905 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 209)) + (char_skill(payload.speaker, "gramarye") * 684)) * (((get_global_var_num("global_what_is_the_season") == 3)) and (3) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_243", function(payload)
    return (((5690 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 581)) + (char_skill(payload.speaker, "gramarye") * 1185)) * (((get_global_var_num("global_what_is_the_season") == 3)) and (3) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_244", function(payload)
    return math.max(((500 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 7)) - (char_skill(payload.speaker, "gramarye") * 11)), 250)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_245", function(payload)
    return ((19852 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 5852)) + (char_skill(payload.speaker, "gramarye") * 11512))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_246", function(payload)
    return ((40851 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 16815)) + (char_skill(payload.speaker, "gramarye") * 32945))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_247", function(payload)
    return math.max(((450 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 5)) - (char_skill(payload.speaker, "gramarye") * 8)), 250)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_248", function(payload)
    return math.max(((500 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 8)) - (char_skill(payload.speaker, "gramarye") * 15)), 150)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_249", function(payload)
    return math.min(((0 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 0.05)) - (char_skill(payload.speaker, "gramarye") * 0.1)), 3)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_250", function(payload)
    return math.max(((800 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 8)) - (char_skill(payload.speaker, "gramarye") * 15)), 300)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_251", function(payload)
    return math.max(((30000 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 250)) - (char_skill(payload.speaker, "gramarye") * 500)), 6000)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_252", function(payload)
    return (math.min(((4 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 0.4)) + (char_skill(payload.speaker, "gramarye") * 1)), 25) * (((get_global_var_num("global_what_is_the_season") == 1)) and (0.5) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_253", function(payload)
    return (math.min(((2 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 0.4)) + (char_skill(payload.speaker, "gramarye") * 1)), 20) * (((get_global_var_num("global_what_is_the_season") == 1)) and (0.5) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_254", function(payload)
    return math.max(((750 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 4)) - (char_skill(payload.speaker, "gramarye") * 8)), 500)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_255", function(payload)
    return math.max(((250 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 5)) - (char_skill(payload.speaker, "gramarye") * 10)), 100)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_256", function(payload)
    return (((13 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 1)) + (char_skill(payload.speaker, "gramarye") * 2)) * (((get_global_var_num("global_what_is_the_season") == 1)) and (0.4) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_257", function(payload)
    return (((24 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 1.8)) + (char_skill(payload.speaker, "gramarye") * 3)) * (((get_global_var_num("global_what_is_the_season") == 1)) and (0.4) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_258", function(payload)
    return math.min(((3 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 0.5)) + (char_skill(payload.speaker, "gramarye") * 1)), 20)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_259", function(payload)
    return (((1 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 0.1)) + (char_skill(payload.speaker, "gramarye") * 0.3333)) * (((get_global_var_num("global_what_is_the_season") == 1)) and (0.4) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_260", function(payload)
    return ((805 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 75)) + (char_skill(payload.speaker, "gramarye") * 165))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_261", function(payload)
    return ((2105 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 195)) + (char_skill(payload.speaker, "gramarye") * 328))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_262", function(payload)
    return math.max(((2000 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 19)) - (char_skill(payload.speaker, "gramarye") * 28)), 1000)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_263", function(payload)
    return math.min(((3 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 0.8)) + char_skill(payload.speaker, "gramarye")), 30)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_264", function(payload)
    return (math.min(((2 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 0.25)) + (char_skill(payload.speaker, "gramarye") * 0.5)), 15) * (((get_global_var_num("global_what_is_the_season") == 3)) and (0.5) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_265", function(payload)
    return (math.max(((150 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 3)) - (char_skill(payload.speaker, "gramarye") * 4)), 50) * (((get_global_var_num("global_what_is_the_season") == 3)) and (4) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_266", function(payload)
    return ((27095 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 4521)) + (char_skill(payload.speaker, "gramarye") * 6241))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_267", function(payload)
    return ((70912 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 8491)) + (char_skill(payload.speaker, "gramarye") * 18405))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_268", function(payload)
    return math.max(((200 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 2)) - (char_skill(payload.speaker, "gramarye") * 6)), 75)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_269", function(payload)
    return (math.max(((1000 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 8)) - (char_skill(payload.speaker, "gramarye") * 10)), 500) * (((get_global_var_num("global_what_is_the_season") == 4)) and (10000) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_270", function(payload)
    return math.max(((6000 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 150)) - (char_skill(payload.speaker, "gramarye") * 75)), 1500)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_271", function(payload)
    return (((90854 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 18625)) + (char_skill(payload.speaker, "gramarye") * 38543)) * (((get_global_var_num("global_what_is_the_season") == 3)) and (0.3) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_272", function(payload)
    return (((244800 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 41835)) + (char_skill(payload.speaker, "gramarye") * 98515)) * (((get_global_var_num("global_what_is_the_season") == 3)) and (0.2) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_273", function(payload)
    return math.max(((500 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 4)) - (char_skill(payload.speaker, "gramarye") * 8)), 350)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_274", function(payload)
    return math.max(((6000 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 50)) - (char_skill(payload.speaker, "gramarye") * 120)), 2000)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_275", function(payload)
    return ((20864 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 7534)) + (char_skill(payload.speaker, "gramarye") * 9852))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_276", function(payload)
    return ((85346 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 17854)) + (char_skill(payload.speaker, "gramarye") * 21852))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_277", function(payload)
    return math.max(((500 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 6)) - (char_skill(payload.speaker, "gramarye") * 10)), 300)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_278", function(payload)
    return math.max(((3000 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 75)) - (char_skill(payload.speaker, "gramarye") * 100)), 500)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_279", function(payload)
    return ((44522 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 11741)) + (char_skill(payload.speaker, "gramarye") * 21399))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_280", function(payload)
    return ((100520 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 16438)) + (char_skill(payload.speaker, "gramarye") * 54992))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_281", function(payload)
    return (((creature_effect_intensity(payload.speaker, "effect_changeling_spring_enchanted_butterfly_wings") > (-1))) and (0) or (math.max(((350 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 3)) - (char_skill(payload.speaker, "gramarye") * 6)), 200)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_282", function(payload)
    return (((creature_effect_intensity(payload.speaker, "effect_changeling_spring_enchanted_butterfly_wings") > (-1))) and (0) or (math.max(((350 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 4)) - (char_skill(payload.speaker, "gramarye") * 10)), 150)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_283", function(payload)
    return ((1 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 0.05)) + (char_skill(payload.speaker, "gramarye") * 0.25))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_284", function(payload)
    return ((1 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 0.12)) + (char_skill(payload.speaker, "gramarye") * 0.5))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_285", function(payload)
    return math.max(((750 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 6)) - (char_skill(payload.speaker, "gramarye") * 12)), 450)
end)

ccb.runtime.handler("wave14a_xedra_evolved_cond_6", function(payload)
    return (creature_is_outside(payload.interlocutor) and creature_on_terrain_flag(payload.interlocutor, "DIGGABLE"))
end)

ccb.runtime.handler("wave14a_xedra_evolved_cond_7", function(payload)
    return (0 == 0)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_286", function(payload)
    return math.min(((20 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 0.5)) + (char_skill(payload.speaker, "gramarye") * 1.25)), 50)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_287", function(payload)
    return (math.min(((2 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 0.2)) + (char_skill(payload.speaker, "gramarye") * 0.5)), 16) * (((get_global_var_num("global_what_is_the_season") == 3)) and (0.6) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_288", function(payload)
    return math.max(((850 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 7)) - (char_skill(payload.speaker, "gramarye") * 13)), 500)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_289", function(payload)
    return math.max(((6000 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 75)) - (char_skill(payload.speaker, "gramarye") * 120)), 1500)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_290", function(payload)
    return (((42 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 1)) + (char_skill(payload.speaker, "gramarye") * 4)) * (((get_global_var_num("global_what_is_the_season") == 3)) and (0.6) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_291", function(payload)
    return (((78 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 2.5)) + (char_skill(payload.speaker, "gramarye") * 12)) * (((get_global_var_num("global_what_is_the_season") == 3)) and (0.4) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_292", function(payload)
    return math.min(((0 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 0.1)) + (char_skill(payload.speaker, "gramarye") * 0.25)), 4)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_293", function(payload)
    return ((1385 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 254)) + (char_skill(payload.speaker, "gramarye") * 544))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_294", function(payload)
    return ((3482 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 518)) + (char_skill(payload.speaker, "gramarye") * 815))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_295", function(payload)
    return math.max(((1100 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SPRING") * 12)) - (char_skill(payload.speaker, "gramarye") * 25)), 650)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_296", function(payload)
    return ((76628 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 14496)) + (char_skill(payload.speaker, "gramarye") * 29521))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_297", function(payload)
    return ((169485 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 45508)) + (char_skill(payload.speaker, "gramarye") * 116805))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_298", function(payload)
    return math.max(((250 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 2)) - (char_skill(payload.speaker, "gramarye") * 4.5)), 100)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_299", function(payload)
    return (math.min(((2 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 0.25)) + (char_skill(payload.speaker, "gramarye") * 0.5)), 12) * (((get_global_var_num("global_what_is_the_season") == 2)) and (1.35) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_300", function(payload)
    return math.max(((150 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 2)) - (char_skill(payload.speaker, "gramarye") * 4)), 50)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_301", function(payload)
    return (((2285 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 915)) + (char_skill(payload.speaker, "gramarye") * 3045)) * (((get_global_var_num("global_what_is_the_season") == 4)) and (0.6) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_302", function(payload)
    return (((6185 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 2025)) + (char_skill(payload.speaker, "gramarye") * 7185)) * (((get_global_var_num("global_what_is_the_season") == 4)) and (0.4) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_303", function(payload)
    return math.max(((300 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 5)) - (char_skill(payload.speaker, "gramarye") * 4)), 120)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_304", function(payload)
    return math.min(((2 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 0.5)) + (char_skill(payload.speaker, "gramarye") * 1)), 25)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_305", function(payload)
    return math.min(((1 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 0.2)) + (char_skill(payload.speaker, "gramarye") * 0.5)), 20)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_306", function(payload)
    return ((5438 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 2381)) + (char_skill(payload.speaker, "gramarye") * 3815))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_307", function(payload)
    return ((18513 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 5731)) + (char_skill(payload.speaker, "gramarye") * 9885))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_308", function(payload)
    return math.max(((400 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 5)) - (char_skill(payload.speaker, "gramarye") * 11)), 150)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_309", function(payload)
    return ((40 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 2)) + (char_skill(payload.speaker, "gramarye") * 4.5))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_310", function(payload)
    return ((85 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 4.5)) + (char_skill(payload.speaker, "gramarye") * 8))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_311", function(payload)
    return math.max(((800 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 8)) - (char_skill(payload.speaker, "gramarye") * 15)), 400)
end)

ccb.runtime.handler("wave14a_xedra_evolved_cond_8", function(payload)
    return (creature_is_outside(payload.speaker) and ((services.weather_snapshot().id == "lightning") or (services.weather_snapshot().id == "thunder") or (services.weather_snapshot().id == "rainstorm") or (services.weather_snapshot().id == "magic_weather_lightning") or (services.weather_snapshot().id == "magic_weather_thunder") or (services.weather_snapshot().id == "magic_weather_rainstorm")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_312", function(payload)
    return ((3825 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 1152)) + (char_skill(payload.speaker, "gramarye") * 4852))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_313", function(payload)
    return ((8642 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 2852)) + (char_skill(payload.speaker, "gramarye") * 9852))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_314", function(payload)
    return math.max(((550 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 5)) - (char_skill(payload.speaker, "gramarye") * 10)), 200)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_315", function(payload)
    return ((80925 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 45932)) + (char_skill(payload.speaker, "gramarye") * 70478))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_316", function(payload)
    return ((199862 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 76236)) + (char_skill(payload.speaker, "gramarye") * 136945))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_317", function(payload)
    return math.max(((750 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_SUMMER") * 3)) - (char_skill(payload.speaker, "gramarye") * 7)), 500)
end)

ccb.runtime.handler("wave14a_xedra_evolved_cond_9", function(payload)
    return (creature_is_outside(payload.speaker) and (not (services.time_snapshot().season_id == "winter")))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_318", function(payload)
    return math.min(((1 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 0.1)) + (char_skill(payload.speaker, "gramarye") * 0.2)), 10)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_319", function(payload)
    return (((5831 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 2882)) + (char_skill(payload.speaker, "gramarye") * 15385)) * (((get_global_var_num("global_what_is_the_season") == 2)) and (0.6) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_320", function(payload)
    return (((19850 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 9850)) + (char_skill(payload.speaker, "gramarye") * 35482)) * (((get_global_var_num("global_what_is_the_season") == 2)) and (0.4) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_321", function(payload)
    return math.max(((150 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 4)) - (char_skill(payload.speaker, "gramarye") * 6)), 50)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_322", function(payload)
    return ((6481 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 3192)) + (char_skill(payload.speaker, "gramarye") * 16972))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_323", function(payload)
    return ((20915 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 10921)) + (char_skill(payload.speaker, "gramarye") * 42392))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_324", function(payload)
    return math.max(((125 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 3.5)) - (char_skill(payload.speaker, "gramarye") * 6)), 50)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_325", function(payload)
    return (((2413 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 912)) + (char_skill(payload.speaker, "gramarye") * 3758)) * (((get_global_var_num("global_what_is_the_season") == 2)) and (0.6) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_326", function(payload)
    return (((5682 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 2782)) + (char_skill(payload.speaker, "gramarye") * 8372)) * (((get_global_var_num("global_what_is_the_season") == 2)) and (0.4) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_327", function(payload)
    return math.max(((200 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 4)) - (char_skill(payload.speaker, "gramarye") * 6)), 75)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_328", function(payload)
    return math.min(((3 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 0.45)) + (char_skill(payload.speaker, "gramarye") * 0.85)), 30)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_329", function(payload)
    return math.min(((2 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 0.25)) + (char_skill(payload.speaker, "gramarye") * 0.5)), 13)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_330", function(payload)
    return math.max(((150 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 3)) - (char_skill(payload.speaker, "gramarye") * 5)), 65)
end)

ccb.runtime.handler("wave14a_xedra_evolved_cond_10", function(payload)
    return (not (services.time_snapshot().season_id == "summer"))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_331", function(payload)
    return (((788 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 253)) + (char_skill(payload.speaker, "gramarye") * 672)) * (((get_global_var_num("global_what_is_the_season") == 4)) and (2.4) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_332", function(payload)
    return (((1531 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 585)) + (char_skill(payload.speaker, "gramarye") * 1585)) * (((get_global_var_num("global_what_is_the_season") == 4)) and (5.9) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_333", function(payload)
    return math.max(((150 - char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER")) - (char_skill(payload.speaker, "gramarye") * 2)), 75)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_334", function(payload)
    return (((1733 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 557)) + (char_skill(payload.speaker, "gramarye") * 1680)) * (((get_global_var_num("global_what_is_the_season") == 2)) and (0.6) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_335", function(payload)
    return (((3368 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 1345)) + (char_skill(payload.speaker, "gramarye") * 3963)) * (((get_global_var_num("global_what_is_the_season") == 2)) and (0.4) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_336", function(payload)
    return math.max(((250 - char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER")) - (char_skill(payload.speaker, "gramarye") * 2)), 120)
end)

ccb.runtime.handler("wave14a_xedra_evolved_cond_11", function(payload)
    return (creature_is_outside(payload.interlocutor) and (not services.gameplay.environment.is_night()))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_337", function(payload)
    return ((4 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 0.25)) + (char_skill(payload.speaker, "gramarye") * 1.25))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_338", function(payload)
    return ((10 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 0.8)) + (char_skill(payload.speaker, "gramarye") * 3))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_339", function(payload)
    return math.min(((2 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 0.1)) + (char_skill(payload.speaker, "gramarye") * 0.2)), 7)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_340", function(payload)
    return math.min(((30 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 1)) + (char_skill(payload.speaker, "gramarye") * 2)), 80)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_341", function(payload)
    return (((282 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 34)) + (char_skill(payload.speaker, "gramarye") * 56)) * (((get_global_var_num("global_what_is_the_season") == 2)) and (0.6) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_342", function(payload)
    return (((642 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 82)) + (char_skill(payload.speaker, "gramarye") * 132)) * (((get_global_var_num("global_what_is_the_season") == 2)) and (0.4) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_343", function(payload)
    return math.max(((200 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 3)) - (char_skill(payload.speaker, "gramarye") * 5)), 100)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_344", function(payload)
    return ((48462 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 6451)) + (char_skill(payload.speaker, "gramarye") * 11715))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_345", function(payload)
    return ((108164 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 15985)) + (char_skill(payload.speaker, "gramarye") * 27054))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_346", function(payload)
    return math.max(((450 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 2)) - (char_skill(payload.speaker, "gramarye") * 4)), 300)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_347", function(payload)
    return ((10 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 1.5)) + (char_skill(payload.speaker, "gramarye") * 2))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_348", function(payload)
    return ((25 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 4)) + (char_skill(payload.speaker, "gramarye") * 6))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_349", function(payload)
    return math.min(((2 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 0.35)) + (char_skill(payload.speaker, "gramarye") * 0.65)), 15)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_350", function(payload)
    return math.min(((2 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 0.2)) + (char_skill(payload.speaker, "gramarye") * 0.4)), 10)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_351", function(payload)
    return ((8 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 1)) + (char_skill(payload.speaker, "gramarye") * 1.8))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_352", function(payload)
    return ((20 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 3)) + (char_skill(payload.speaker, "gramarye") * 4))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_353", function(payload)
    return math.max(((1500 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 10)) - (char_skill(payload.speaker, "gramarye") * 25)), 800)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_354", function(payload)
    return math.max(((3000 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 50)) - (char_skill(payload.speaker, "gramarye") * 150)), 1000)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_355", function(payload)
    return (((5978 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 2684)) + (char_skill(payload.speaker, "gramarye") * 8225)) * (((get_global_var_num("global_what_is_the_season") == 4)) and (1.4) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_356", function(payload)
    return (((28028 + (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 13630)) + (char_skill(payload.speaker, "gramarye") * 30212)) * (((get_global_var_num("global_what_is_the_season") == 4)) and (1.4) or (1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_357", function(payload)
    return math.max(((600 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 5)) - (char_skill(payload.speaker, "gramarye") * 10)), 400)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_358", function(payload)
    return math.max(((2000 - (char_spell_count(payload.speaker, "CHANGELING_SEASONAL_MAGIC_WINTER") * 10)) - (char_skill(payload.speaker, "gramarye") * 50)), 500)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_359", function(payload)
    return (((char_sum_traits_cat(payload.speaker, "FAIR_FOLK_NOBLE", "ALL") * 0.04) + (char_skill(payload.speaker, "gramarye") * 0.1)) + 1)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_360", function(payload)
    return (((char_sum_traits_cat(payload.speaker, "FAIR_FOLK_NOBLE", "ALL") * 0.12) + (char_skill(payload.speaker, "gramarye") * 0.25)) + 2)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_361", function(payload)
    return (((char_sum_traits_cat(payload.speaker, "FAIR_FOLK_NOBLE", "ALL") * 340) + (char_skill(payload.speaker, "gramarye") * 2700)) + 14200)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_362", function(payload)
    return (((char_sum_traits_cat(payload.speaker, "FAIR_FOLK_NOBLE", "ALL") * 620) + (char_skill(payload.speaker, "gramarye") * 11300)) + 52300)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_363", function(payload)
    return math.max(((1200 - (char_sum_traits_cat(payload.speaker, "FAIR_FOLK_NOBLE", "ALL") * 15)) - (char_skill(payload.speaker, "gramarye") * 40)), 550)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_364", function(payload)
    return math.max(((400 - (char_sum_traits_cat(payload.speaker, "FAIR_FOLK_NOBLE", "ALL") * 8)) - (char_skill(payload.speaker, "gramarye") * 15)), 150)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_365", function(payload)
    return (((char_sum_traits_cat(payload.speaker, "FAIR_FOLK_NOBLE", "ALL") * 4.5) + (char_skill(payload.speaker, "gramarye") * 20)) + 10)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_366", function(payload)
    return (((char_sum_traits_cat(payload.speaker, "FAIR_FOLK_NOBLE", "ALL") * 9) + (char_skill(payload.speaker, "gramarye") * 30)) + 30)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_367", function(payload)
    return (((char_sum_traits_cat(payload.speaker, "FAIR_FOLK_NOBLE", "ALL") * 691) + (char_skill(payload.speaker, "gramarye") * 3246)) + 8259)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_368", function(payload)
    return (((char_sum_traits_cat(payload.speaker, "FAIR_FOLK_NOBLE", "ALL") * 1685) + (char_skill(payload.speaker, "gramarye") * 8388)) + 26221)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_369", function(payload)
    return math.max(((450 - (char_sum_traits_cat(payload.speaker, "FAIR_FOLK_NOBLE", "ALL") * 5)) - (char_skill(payload.speaker, "gramarye") * 15)), 150)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_370", function(payload)
    return math.max(((150 - (char_sum_traits_cat(payload.speaker, "FAIR_FOLK_NOBLE", "ALL") * 3)) - (char_skill(payload.speaker, "gramarye") * 8)), 50)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_371", function(payload)
    return (((char_sum_traits_cat(payload.speaker, "FAIR_FOLK_NOBLE", "ALL") * 3) + (char_skill(payload.speaker, "gramarye") * 20)) + 10)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_372", function(payload)
    return (((char_sum_traits_cat(payload.speaker, "FAIR_FOLK_NOBLE", "ALL") * 7) + (char_skill(payload.speaker, "gramarye") * 30)) + 30)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_373", function(payload)
    return (((char_sum_traits_cat(payload.speaker, "FAIR_FOLK_NOBLE", "ALL") * 286) + (char_skill(payload.speaker, "gramarye") * 2455)) + 5824)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_374", function(payload)
    return (((char_sum_traits_cat(payload.speaker, "FAIR_FOLK_NOBLE", "ALL") * 773) + (char_skill(payload.speaker, "gramarye") * 6250)) + 19375)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_375", function(payload)
    return math.max(((700 - (char_sum_traits_cat(payload.speaker, "FAIR_FOLK_NOBLE", "ALL") * 9)) - (char_skill(payload.speaker, "gramarye") * 25)), 300)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_376", function(payload)
    return (((char_sum_traits_cat(payload.speaker, "FAIR_FOLK_COMMONER_POOKA", "ALL") * 3) + (char_skill(payload.speaker, "gramarye") * 10)) + 15)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_377", function(payload)
    return (((char_sum_traits_cat(payload.speaker, "FAIR_FOLK_COMMONER_POOKA", "ALL") * 7) + (char_skill(payload.speaker, "gramarye") * 25)) + 60)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_378", function(payload)
    return (((char_sum_traits_cat(payload.speaker, "FAIR_FOLK_COMMONER_POOKA", "ALL") * 286) + (char_skill(payload.speaker, "gramarye") * 3455)) + 9450)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_379", function(payload)
    return (((char_sum_traits_cat(payload.speaker, "FAIR_FOLK_COMMONER_POOKA", "ALL") * 850) + (char_skill(payload.speaker, "gramarye") * 8641)) + 33145)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_380", function(payload)
    return math.max(((600 - (char_sum_traits_cat(payload.speaker, "FAIR_FOLK_COMMONER_POOKA", "ALL") * 8)) - (char_skill(payload.speaker, "gramarye") * 25)), 250)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_381", function(payload)
    return math.max(((200 - (char_sum_traits_cat(payload.speaker, "FAIR_FOLK_COMMONER_POOKA", "ALL") * 4)) - (char_skill(payload.speaker, "gramarye") * 8)), 50)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_382", function(payload)
    return (((char_sum_traits_cat(payload.speaker, "FAIR_FOLK_COMMONER_SELKIE", "ALL") * 3) + (char_skill(payload.speaker, "gramarye") * 10)) + 10)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_383", function(payload)
    return (((char_sum_traits_cat(payload.speaker, "FAIR_FOLK_COMMONER_SELKIE", "ALL") * 7) + (char_skill(payload.speaker, "gramarye") * 20)) + 30)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_384", function(payload)
    return (((char_sum_traits_cat(payload.speaker, "FAIR_FOLK_COMMONER_SELKIE", "ALL") * 286) + (char_skill(payload.speaker, "gramarye") * 2455)) + 5824)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_385", function(payload)
    return (((char_sum_traits_cat(payload.speaker, "FAIR_FOLK_COMMONER_SELKIE", "ALL") * 773) + (char_skill(payload.speaker, "gramarye") * 6250)) + 19375)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_386", function(payload)
    return math.max(((750 - (char_sum_traits_cat(payload.speaker, "FAIR_FOLK_COMMONER_SELKIE", "ALL") * 9)) - (char_skill(payload.speaker, "gramarye") * 25)), 350)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_387", function(payload)
    return math.max(((200 - (char_sum_traits_cat(payload.speaker, "FAIR_FOLK_COMMONER_SELKIE", "ALL") * 4)) - (char_skill(payload.speaker, "gramarye") * 8)), 50)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_388", function(payload)
    return math.max(((200 - (char_sum_traits_cat(payload.speaker, "FAIR_FOLK_COMMONER_TROW", "ALL") * 2)) - (char_skill(payload.speaker, "gramarye") * 5)), 35)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_389", function(payload)
    return math.max(((150 - (char_sum_traits_cat(payload.speaker, "FAIR_FOLK_COMMONER_TROW", "ALL") * 3)) - (char_skill(payload.speaker, "gramarye") * 6)), 50)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_390", function(payload)
    return math.min(jmath_xedra_chron_spell_calc(payload, char_spell_level(payload.speaker, "xedra_chronomancer_time_freeze_target"), 2, 1), 80)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_391", function(payload)
    return jmath_xedra_chron_spell_calc(payload, char_spell_level(payload.speaker, "xedra_chronomancer_time_freeze_target"), 60000, 0)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_392", function(payload)
    return jmath_xedra_chronomancer_level(payload, 1)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_393", function(payload)
    return math.min(jmath_xedra_chron_spell_calc(payload, char_spell_level(payload.speaker, "xedra_chronomancer_normalize_time"), 2, 1), 80)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_394", function(payload)
    return math.min(jmath_xedra_chron_spell_calc(payload, char_spell_level(payload.speaker, "xedra_chronomancer_entropic_burst"), 2, 1), 80)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_395", function(payload)
    return math.min(jmath_xedra_chron_spell_calc(payload, char_spell_level(payload.speaker, "xedra_chronomancer_entropic_burst"), 0.5, 1), 15)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_396", function(payload)
    return jmath_xedra_chron_spell_calc(payload, char_spell_level(payload.speaker, "xedra_chronomancer_entropic_burst"), 1, 0)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_397", function(payload)
    return jmath_xedra_chron_spell_calc(payload, char_spell_level(payload.speaker, "xedra_chronomancer_entropic_burst"), 50, 200)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_398", function(payload)
    return math.min(jmath_xedra_chron_spell_calc(payload, char_spell_level(payload.speaker, "xedra_chronomancer_time_bubble"), 2, 1), 80)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_399", function(payload)
    return math.min(jmath_xedra_chron_spell_calc(payload, char_spell_level(payload.speaker, "xedra_chronomancer_time_bubble"), 0.5, 1), 15)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_400", function(payload)
    return jmath_xedra_chron_spell_calc(payload, char_spell_level(payload.speaker, "xedra_chronomancer_time_bubble"), 60000, 0)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_401", function(payload)
    return jmath_xedra_chron_spell_calc(payload, char_spell_level(payload.speaker, "xedra_chronomancer_time_loop"), 3000, 0)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_402", function(payload)
    return jmath_xedra_chron_spell_calc(payload, char_spell_level(payload.speaker, "xedra_chronomancer_time_stop"), 200, 0)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_403", function(payload)
    return jmath_dreamer_level(payload, 1)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_404", function(payload)
    return (char_spell_level(payload.speaker, "xedra_dreamer_time_bubble") * 60000)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_405", function(payload)
    return jmath_eater_level(payload, 1)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_406", function(payload)
    return ((char_skill(payload.speaker, "deduction") + char_skill(payload.speaker, "throw")) * 4)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_407", function(payload)
    return ((char_skill(payload.speaker, "deduction") + char_skill(payload.speaker, "throw")) * 7)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_408", function(payload)
    return (char_skill(payload.speaker, "deduction") + char_skill(payload.speaker, "throw"))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_409", function(payload)
    return ((char_vitamin(payload.speaker, "lilin_ruach_vitamin") / 600) + 4)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_410", function(payload)
    return (1000 + (((char_vitamin(payload.speaker, "lilin_ruach_vitamin") * 8) * ((char_has_trait(payload.speaker, "LILIN_LIMB_SCORE_BONUSES_AT_NIGHT") * 0.5) + 1)) * ((char_has_trait(payload.speaker, "LILIN_NIGHT_VISION") * 0.3) + 1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_411", function(payload)
    return (5000 + (((char_vitamin(payload.speaker, "lilin_ruach_vitamin") * 19) * ((char_has_trait(payload.speaker, "LILIN_LIMB_SCORE_BONUSES_AT_NIGHT") * 0.5) + 1)) * ((char_has_trait(payload.speaker, "LILIN_NIGHT_VISION") * 0.3) + 1)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_412", function(payload)
    return (60 * jmath_lilin_has_ruach_efficiency(payload))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_413", function(payload)
    return ((char_vitamin(payload.speaker, "lilin_ruach_vitamin") / 500) + 6)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_414", function(payload)
    return ((char_vitamin(payload.speaker, "lilin_ruach_vitamin") * 500) * (char_has_trait(payload.speaker, "THRESH_LILIN") + 1))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_415", function(payload)
    return ((char_vitamin(payload.speaker, "lilin_ruach_vitamin") * 1200) * (char_has_trait(payload.speaker, "THRESH_LILIN") + 1))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_416", function(payload)
    return ((char_vitamin(payload.speaker, "lilin_ruach_vitamin") * 2400) * (char_has_trait(payload.speaker, "THRESH_LILIN") + 1))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_417", function(payload)
    return ((char_vitamin(payload.speaker, "lilin_ruach_vitamin") * 5100) * (char_has_trait(payload.speaker, "THRESH_LILIN") + 1))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_418", function(payload)
    return (240 * jmath_lilin_has_ruach_efficiency(payload))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_419", function(payload)
    return (((((1500 + (char_has_trait(payload.speaker, "THRESH_LILIN") * 1500)) + (char_vitamin(payload.speaker, "lilin_ruach_vitamin") / 0.24)) * (((creature_effect_intensity(payload.speaker, "effect_lilin_attribute_bonuses") > 0)) and (1.25) or (1))) * (((creature_effect_intensity(payload.speaker, "effect_lilin_limb_score_bonuses_at_night") > 0)) and (1.25) or (1))) * 0.7)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_420", function(payload)
    return (((((1500 + (char_has_trait(payload.speaker, "THRESH_LILIN") * 1500)) + (char_vitamin(payload.speaker, "lilin_ruach_vitamin") / 0.24)) * (((creature_effect_intensity(payload.speaker, "effect_lilin_attribute_bonuses") > 0)) and (1.25) or (1))) * (((creature_effect_intensity(payload.speaker, "effect_lilin_limb_score_bonuses_at_night") > 0)) and (1.25) or (1))) * 1.3)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_421", function(payload)
    return (360 * jmath_lilin_has_ruach_efficiency(payload))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_422", function(payload)
    return (0.3 * get_actor_var_num(payload.speaker, "has_arvore_jagged_claw_out"))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_423", function(payload)
    return (800 * get_actor_var_num(payload.speaker, "has_arvore_jagged_claw_out"))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_424", function(payload)
    return (2000 * get_actor_var_num(payload.speaker, "has_arvore_jagged_claw_out"))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_425", function(payload)
    return (math.min((((((1500 + (jmath_vampire_total_tier_one_traits_plus_potency(payload) * 200)) + (jmath_vampire_total_tier_two_traits(payload) * 450)) + (jmath_vampire_total_tier_three_traits(payload) * 900)) + (jmath_vampire_total_tier_four_traits_plus_potence(payload) * 1500)) + (jmath_vampire_total_tier_five_traits_plus_cauldron(payload) * 2000)), 15000) * 0.75)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_426", function(payload)
    return (math.min((((((1500 + (jmath_vampire_total_tier_one_traits_plus_potency(payload) * 200)) + (jmath_vampire_total_tier_two_traits(payload) * 450)) + (jmath_vampire_total_tier_three_traits(payload) * 900)) + (jmath_vampire_total_tier_four_traits_plus_potence(payload) * 1500)) + (jmath_vampire_total_tier_five_traits_plus_cauldron(payload) * 2000)), 15000) * 1.25)
end)

ccb.runtime.handler("wave14a_xedra_evolved_cond_12", function(payload)
    return (char_vitamin(payload.speaker, "human_blood_vitamin") > (-500))
end)

ccb.runtime.handler("wave14a_xedra_evolved_cond_13", function(payload)
    return (char_has_trait(payload.speaker, "VAMPIRE_CARDIO_BONUS_REFINEMENT_STAMINAFORBLOOD") == 1)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_427", function(payload)
    return math.min(((((jmath_vampire_total_tier_one_traits_plus_potency(payload) + (jmath_vampire_total_tier_two_traits(payload) * 2)) + (jmath_vampire_total_tier_three_traits(payload) * 3)) + (jmath_vampire_total_tier_four_traits_plus_potence(payload) * 4)) + (jmath_vampire_total_tier_five_traits_plus_cauldron(payload) * 5)), 35)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_428", function(payload)
    return (math.min((((((150 + (jmath_vampire_total_tier_one_traits_plus_potency(payload) * 20)) + (jmath_vampire_total_tier_two_traits(payload) * 45)) + (jmath_vampire_total_tier_three_traits(payload) * 90)) + (jmath_vampire_total_tier_four_traits_plus_potence(payload) * 150)) + (jmath_vampire_total_tier_five_traits_plus_cauldron(payload) * 200)), 1500) * 0.75)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_429", function(payload)
    return (math.min((((((150 + (jmath_vampire_total_tier_one_traits_plus_potency(payload) * 20)) + (jmath_vampire_total_tier_two_traits(payload) * 45)) + (jmath_vampire_total_tier_three_traits(payload) * 90)) + (jmath_vampire_total_tier_four_traits_plus_potence(payload) * 150)) + (jmath_vampire_total_tier_five_traits_plus_cauldron(payload) * 200)), 1500) * 1.25)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_430", function(payload)
    return (((((50 + (jmath_vampire_total_tier_one_traits(payload) * 5)) + (jmath_vampire_total_tier_two_traits(payload) * 12)) + (jmath_vampire_total_tier_three_traits(payload) * 20)) + (jmath_vampire_total_tier_three_traits(payload) * 35)) * 0.75)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_431", function(payload)
    return (((((50 + (jmath_vampire_total_tier_one_traits(payload) * 5)) + (jmath_vampire_total_tier_two_traits(payload) * 12)) + (jmath_vampire_total_tier_three_traits(payload) * 20)) + (jmath_vampire_total_tier_three_traits(payload) * 35)) * 1.25)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_432", function(payload)
    return math.min(((((3 + (jmath_vampire_total_tier_one_traits(payload) * 0.2)) + (jmath_vampire_total_tier_two_traits(payload) * 0.33)) + (jmath_vampire_total_tier_three_traits(payload) * 0.5)) + (jmath_vampire_total_tier_four_traits_plus_potence(payload) * 0.75)), 12)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_433", function(payload)
    return (((((6000 + (jmath_vampire_total_tier_one_traits(payload) * 1000)) + (jmath_vampire_total_tier_two_traits(payload) * 1800)) + (jmath_vampire_total_tier_three_traits(payload) * 2700)) + (jmath_vampire_total_tier_three_traits(payload) * 4500)) * 0.75)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_434", function(payload)
    return (((((6000 + (jmath_vampire_total_tier_one_traits(payload) * 1000)) + (jmath_vampire_total_tier_two_traits(payload) * 1800)) + (jmath_vampire_total_tier_three_traits(payload) * 2700)) + (jmath_vampire_total_tier_three_traits(payload) * 4500)) * 1.25)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_435", function(payload)
    return math.min((((((1 + (jmath_vampire_total_tier_one_traits(payload) * 0.075)) + (jmath_vampire_total_tier_two_traits(payload) * 0.12)) + (jmath_vampire_total_tier_three_traits(payload) * 0.25)) + (jmath_vampire_total_tier_four_traits_plus_potence(payload) * 0.5)) * 0.75), 10)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_436", function(payload)
    return math.min((((((1 + (jmath_vampire_total_tier_one_traits(payload) * 0.075)) + (jmath_vampire_total_tier_two_traits(payload) * 0.12)) + (jmath_vampire_total_tier_three_traits(payload) * 0.25)) + (jmath_vampire_total_tier_four_traits_plus_potence(payload) * 0.5)) * 1.25), 10)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_437", function(payload)
    return (((((18000 + (jmath_vampire_total_tier_one_traits(payload) * 2500)) + (jmath_vampire_total_tier_two_traits(payload) * 3600)) + (jmath_vampire_total_tier_three_traits(payload) * 4900)) + (jmath_vampire_total_tier_four_traits_plus_potence(payload) * 7700)) * 0.75)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_438", function(payload)
    return (((((18000 + (jmath_vampire_total_tier_one_traits(payload) * 2500)) + (jmath_vampire_total_tier_two_traits(payload) * 3600)) + (jmath_vampire_total_tier_three_traits(payload) * 4900)) + (jmath_vampire_total_tier_four_traits_plus_potence(payload) * 7700)) * 1.25)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_439", function(payload)
    return (((((20 + (jmath_vampire_total_tier_one_traits(payload) * 4)) + (jmath_vampire_total_tier_two_traits(payload) * 10)) + (jmath_vampire_total_tier_three_traits(payload) * 16)) + (jmath_vampire_total_tier_four_traits_plus_potence(payload) * 30)) * 0.75)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_440", function(payload)
    return (((((20 + (jmath_vampire_total_tier_one_traits(payload) * 4)) + (jmath_vampire_total_tier_two_traits(payload) * 10)) + (jmath_vampire_total_tier_three_traits(payload) * 16)) + (jmath_vampire_total_tier_four_traits_plus_potence(payload) * 30)) * 1.25)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_441", function(payload)
    return (((((2500 + (jmath_vampire_total_tier_one_traits(payload) * 400)) + (jmath_vampire_total_tier_two_traits(payload) * 800)) + (jmath_vampire_total_tier_three_traits(payload) * 1150)) + (jmath_vampire_total_tier_four_traits_plus_potence(payload) * 2050)) * 0.75)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_442", function(payload)
    return (((((2500 + (jmath_vampire_total_tier_one_traits(payload) * 400)) + (jmath_vampire_total_tier_two_traits(payload) * 800)) + (jmath_vampire_total_tier_three_traits(payload) * 1150)) + (jmath_vampire_total_tier_four_traits_plus_potence(payload) * 2050)) * 1.25)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_443", function(payload)
    return (15 + math.min(((jmath_werewolf_tier_four_traits(payload) * 1) + (jmath_werewolf_tier_five_traits(payload) * 2)), 20))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_444", function(payload)
    return (((((3700 + (jmath_werewolf_tier_one_traits(payload) * 150)) + (jmath_werewolf_tier_two_traits(payload) * 310)) + (jmath_werewolf_tier_three_traits(payload) * 625)) + (jmath_werewolf_tier_four_traits(payload) * 1201)) + (jmath_werewolf_tier_five_traits(payload) * 1680))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_445", function(payload)
    return (((((10810 + (jmath_werewolf_tier_one_traits(payload) * 295)) + (jmath_werewolf_tier_two_traits(payload) * 615)) + (jmath_werewolf_tier_three_traits(payload) * 1181)) + (jmath_werewolf_tier_four_traits(payload) * 1925)) + (jmath_werewolf_tier_five_traits(payload) * 2545))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_446", function(payload)
    return (((((char_stat(payload.speaker, "strength") + (jmath_werewolf_tier_two_traits(payload) * 0.1)) + (jmath_werewolf_tier_three_traits(payload) * 0.2)) + (jmath_werewolf_tier_four_traits(payload) * 0.3)) + (jmath_werewolf_tier_five_traits(payload) * 0.4)) * 2)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_447", function(payload)
    return (((((char_stat(payload.speaker, "strength") + (jmath_werewolf_tier_two_traits(payload) * 0.1)) + (jmath_werewolf_tier_three_traits(payload) * 0.2)) + (jmath_werewolf_tier_four_traits(payload) * 0.3)) + (jmath_werewolf_tier_five_traits(payload) * 0.4)) * 4)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_448", function(payload)
    return (math.min((((3 + (jmath_werewolf_tier_three_traits(payload) * 0.1)) + (jmath_werewolf_tier_four_traits(payload) * 0.25)) + (jmath_werewolf_tier_five_traits(payload) * 0.4)), 8) * (1 + (char_has_trait(payload.speaker, "VAMPIRE_WOLF_FORM") * 0.5)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_449", function(payload)
    return (math.min((((3 + (jmath_werewolf_tier_three_traits(payload) * 0.1)) + (jmath_werewolf_tier_four_traits(payload) * 0.25)) + (jmath_werewolf_tier_five_traits(payload) * 1.4)), 8) * (1 + (char_has_trait(payload.speaker, "VAMPIRE_WOLF_FORM") * 0.5)))
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_450", function(payload)
    return math.min((((((1050 + (jmath_werewolf_tier_one_traits(payload) * 45)) + (jmath_werewolf_tier_two_traits(payload) * 75)) + (jmath_werewolf_tier_three_traits(payload) * 135)) + (jmath_werewolf_tier_four_traits(payload) * 195)) + (jmath_werewolf_tier_five_traits(payload) * 200)), 12000)
end)

ccb.runtime.handler("wave14a_xedra_evolved_stat_451", function(payload)
    return math.min((((((1905 + (jmath_werewolf_tier_one_traits(payload) * 75)) + (jmath_werewolf_tier_two_traits(payload) * 100)) + (jmath_werewolf_tier_three_traits(payload) * 185)) + (jmath_werewolf_tier_four_traits(payload) * 235)) + (jmath_werewolf_tier_five_traits(payload) * 300)), 30000)
end)

ccb.runtime.handler("wave14a_xedra_evolved_cond_14", function(payload)
    return (not creature_has_effect(payload.speaker, "effect_xe_werewolf_summon_shadow_pack_limiter"))
end)

local ccb = require("ccb")
local services = ccb.services
local mom_knacks_only_active = ccb.content.is_mod_active("mom_knacks_only")

local function truthy(v)
    return v ~= false and v ~= nil and v ~= 0
end

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

local function char_has_wielded_flag(actor, flag_id)
    if not actor then
        return 0
    end
    local gid = safe_id("json_flag", flag_id)
    if not gid then
        return 0
    end
    local r = services.inventory.wielded_matches(actor, gid)
    if not r.ok or not r.value then
        return 0
    end
    return 1
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

local function char_has_bionic(actor, bionic_id)
    if not actor then
        return false
    end
    local gid = safe_id("bionic", bionic_id)
    if not gid then
        return false
    end
    local r = services.bionics.has(actor, gid)
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

local function jmath_mom_int_to_level(payload)
    return (char_stat(payload.speaker, "intelligence") * 1.5)
end

local function jmath_mom_biokinesis_max_power_formula(payload)
    return (jmath_mom_int_to_level(payload) + ((truthy(char_has_wielded_flag(payload.speaker, "MATRIX_CRYSTAL_BIOKINESIS"))) and (6) or (0)))
end

local function jmath_scaling_factor(payload, _0)
    local v = (_0 + 10) / 20
    if mom_knacks_only_active then return math.min(v, 1.25) end
    return v
end

local function jmath_weariness_power_scaling(payload)
    return ((((((((creature_effect_intensity(payload.speaker, "weary_1") > (-1))) and (0.9) or (1)) * (((creature_effect_intensity(payload.speaker, "weary_2") > (-1))) and (0.75) or (1))) * (((creature_effect_intensity(payload.speaker, "weary_3") > (-1))) and (0.6) or (1))) * (((creature_effect_intensity(payload.speaker, "weary_4") > (-1))) and (0.45) or (1))) * (((creature_effect_intensity(payload.speaker, "weary_5") > (-1))) and (0.25) or (1))) * (((creature_effect_intensity(payload.speaker, "weary_6") > (-1))) and (0.25) or (1)))
end

local function jmath_psionic_power_modifiers(payload)
    return ((jmath_scaling_factor(payload, char_stat(payload.speaker, "intelligence")) * get_actor_var_num(payload.speaker, "nether_attunement_power_scaling")) * jmath_weariness_power_scaling(payload))
end

local function jmath_mom_pyrokinesis_max_power_formula(payload)
    return (jmath_mom_int_to_level(payload) + ((truthy(char_has_wielded_flag(payload.speaker, "MATRIX_CRYSTAL_PYROKINESIS"))) and (6) or (0)))
end

local function jmath_mom_telepathy_max_power_formula(payload)
    return (jmath_mom_int_to_level(payload) + ((truthy(char_has_wielded_flag(payload.speaker, "MATRIX_CRYSTAL_TELEPATHY"))) and (6) or (0)))
end

ccb.runtime.handler("wave14a_mindovermatter_stat_1", function(payload)
    return jmath_mom_biokinesis_max_power_formula(payload)
end)

ccb.runtime.handler("wave14a_mindovermatter_cond_1", function(payload)
    return ((not char_has_bionic(payload.speaker, "bio_exodii_cyberframe_1b")) and (not char_has_bionic(payload.speaker, "bio_exodii_cyberframe_1a")))
end)

ccb.runtime.handler("wave14a_mindovermatter_stat_2", function(payload)
    return (math.min((((char_spell_level(payload.speaker, "biokin_dash") * 0.5) + 3) * jmath_psionic_power_modifiers(payload)), 12) * (((creature_effect_intensity(payload.speaker, "effect_biokin_combat_dance") > (-1))) and ((1.25 + (char_spell_level(payload.speaker, "biokin_combat_dance") * 0.03))) or (1)))
end)

ccb.runtime.handler("wave14a_mindovermatter_cond_2", function(payload)
    return ((not creature_has_effect(payload.speaker, "grabbed", "head")) and (not creature_has_effect(payload.speaker, "grabbed", "torso")) and (not creature_has_effect(payload.speaker, "grabbed", "arm_l")) and (not creature_has_effect(payload.speaker, "grabbed", "arm_r")) and (not creature_has_effect(payload.speaker, "grabbed", "leg_l")) and (not creature_has_effect(payload.speaker, "grabbed", "leg_r")) and (not creature_has_effect(payload.speaker, "disabled", "leg_l")) and (not creature_has_effect(payload.speaker, "disabled", "leg_r")) and (not creature_on_terrain_flag(payload.speaker, "DEEP_WATER")) and (not char_has_bionic(payload.speaker, "bio_exodii_cyberframe_1b")) and (not char_has_bionic(payload.speaker, "bio_exodii_cyberframe_1a")))
end)

ccb.runtime.handler("wave14a_mindovermatter_stat_3", function(payload)
    return ((((char_spell_level(payload.speaker, "pyrokinetic_intensify_flames") + char_spell_level(payload.speaker, "pyrokinetic_intensify_flames_knack")) * 1.5) + 6) * jmath_psionic_power_modifiers(payload))
end)

ccb.runtime.handler("wave14a_mindovermatter_stat_4", function(payload)
    return ((((char_spell_level(payload.speaker, "pyrokinetic_intensify_flames") + char_spell_level(payload.speaker, "pyrokinetic_intensify_flames_knack")) * 3) + 26) * jmath_psionic_power_modifiers(payload))
end)

ccb.runtime.handler("wave14a_mindovermatter_stat_5", function(payload)
    return jmath_mom_pyrokinesis_max_power_formula(payload)
end)

ccb.runtime.handler("wave14a_mindovermatter_cond_3", function(payload)
    return (creature_has_effect(payload.interlocutor, "onfire") or creature_has_effect(payload.interlocutor, "onfire", "torso") or creature_has_effect(payload.interlocutor, "onfire", "head") or creature_has_effect(payload.interlocutor, "onfire", "arm_l") or creature_has_effect(payload.interlocutor, "onfire", "arm_r") or creature_has_effect(payload.interlocutor, "onfire", "leg_l") or creature_has_effect(payload.interlocutor, "onfire", "leg_r") or creature_has_effect(payload.interlocutor, "onfire", "tail"))
end)

ccb.runtime.handler("wave14a_mindovermatter_stat_6", function(payload)
    return get_actor_var_num(payload.speaker, "telekinesis_shove_spell_level")
end)

ccb.runtime.handler("wave14a_mindovermatter_stat_7", function(payload)
    return ((((char_spell_level(payload.speaker, "telepathic_animal_mind_control") + char_spell_level(payload.speaker, "telepathic_animal_mind_control_knack")) * 8) + 40) * jmath_psionic_power_modifiers(payload))
end)

ccb.runtime.handler("wave14a_mindovermatter_stat_8", function(payload)
    return ((((char_spell_level(payload.speaker, "telepathic_animal_mind_control") + char_spell_level(payload.speaker, "telepathic_animal_mind_control_knack")) * 15) + 200) * jmath_psionic_power_modifiers(payload))
end)

ccb.runtime.handler("wave14a_mindovermatter_stat_9", function(payload)
    return math.min(((((char_spell_level(payload.speaker, "telepathic_animal_mind_control") + char_spell_level(payload.speaker, "telepathic_animal_mind_control_knack")) * 1) + 3) * jmath_psionic_power_modifiers(payload)), 70)
end)

ccb.runtime.handler("wave14a_mindovermatter_stat_10", function(payload)
    return ((((char_spell_level(payload.speaker, "telepathic_animal_mind_control") + char_spell_level(payload.speaker, "telepathic_animal_mind_control_knack")) * 1125) + 18000) * jmath_psionic_power_modifiers(payload))
end)

ccb.runtime.handler("wave14a_mindovermatter_stat_11", function(payload)
    return ((((char_spell_level(payload.speaker, "telepathic_animal_mind_control") + char_spell_level(payload.speaker, "telepathic_animal_mind_control_knack")) * 2800) + 47000) * jmath_psionic_power_modifiers(payload))
end)

ccb.runtime.handler("wave14a_mindovermatter_stat_12", function(payload)
    return jmath_mom_telepathy_max_power_formula(payload)
end)

ccb.runtime.handler("wave14a_mindovermatter_stat_13", function(payload)
    return ((((1 + creature_effect_intensity(payload.speaker, "effect_teleport_warped_strikes")) > (-1))) and (2) or (0))
end)

ccb.runtime.handler("wave14a_mindovermatter_stat_14", function(payload)
    return (get_actor_var_num(payload.speaker, "vitakinesis_degen_max_possible_limb_damage") / get_actor_var_num(payload.speaker, "vitakinesis_degen_duration"))
end)

ccb.runtime.handler("wave14a_mindovermatter_stat_15", function(payload)
    return (get_actor_var_num(payload.speaker, "vitakinesis_degen_duration") * 100)
end)

ccb.runtime.handler("wave14a_mindovermatter_stat_16", function(payload)
    return (get_actor_var_num(payload.speaker, "vitakinesis_degen_max_possible_monster_damage") / get_actor_var_num(payload.speaker, "vitakinesis_degen_duration"))
end)
